
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity UART_tx is
    Generic ( 
        CLK_FREKANS : integer := 100000000;
        BOUDRATE : integer := 115200
    );
    Port(
        in_clk : in std_logic;
        in_rst : in std_logic;
        in_tx_basla : in std_logic;
        in_tx_data : in std_logic_vector(7 downto 0);
        out_tx : out std_logic;
        out_tx_tamam : out std_logic
    );
    
end UART_tx;

architecture Behavioral of UART_tx is

    constant CLK_BIT : integer := CLK_FREKANS / BOUDRATE + 1;
    type t_UART_tx is (BOSTA, BASLA, GONDER, BITIR, TAMAM);
    signal r_UART_tx : t_UART_tx := BOSTA;
    
    signal r_clk_sayac : integer range 0 to CLK_BIT - 1 := 0;
    signal r_data_ind : integer range 0 to 7 := 0; 
    signal r_data   : std_logic_vector(7 downto 0) := (others => '0');
    signal r_tx : std_logic := '1';
    signal r_tx_tamam : std_logic := '0';    

begin

    out_tx <= r_tx;
    out_tx_tamam <= r_tx_tamam;
    
    process(in_clk, in_rst)
    begin
        if in_rst = '1' then
            r_UART_tx <= BOSTA;
            r_clk_sayac <= 0;
            r_data_ind <= 0;
            r_data <= (others => '0');
            r_tx <= '1';
            r_tx_tamam <= '0';
            
        elsif rising_edge(in_clk) then
            r_tx_tamam <= '0';
            case r_UART_tx is
                when BOSTA =>
                    r_tx <= '1'; 
					r_clk_sayac <= 0;
					r_data_ind <= 0;
                    if in_tx_basla = '1' then
                        r_data <= in_tx_data;
                        r_UART_tx <= BASLA;
                    end if;  
                    
                when BASLA =>
                    r_tx <= '0';
                    if r_clk_sayac = CLK_BIT - 1 then
                        r_clk_sayac <= 0;
                        r_UART_tx <= GONDER;                        
                    else
						r_clk_sayac <= r_clk_sayac + 1;
                    end if;
                    
                when GONDER =>      
                    r_tx  <= r_data(r_data_ind);
                    if r_clk_sayac = CLK_BIT - 1 then
						r_clk_sayac <= 0;
                        if r_data_ind = 7 then
							r_data_ind <= 0;
                            r_UART_tx <= BITIR;
                            
                        else
							r_data_ind <= r_data_ind + 1;
                        end if;
                        
                    else
						r_clk_sayac <= r_clk_sayac + 1;

                    end if;                    
                when BITIR =>
                    r_tx  <= '1';
                    if r_clk_sayac = CLK_BIT - 1 then
                        r_clk_sayac <= 0;
                        r_UART_tx <= TAMAM;                        
                    else
						r_clk_sayac <= r_clk_sayac + 1;
                    end if;
                
                when TAMAM =>
					r_tx  <= '1';
                    r_tx_tamam <= '1';
                    r_UART_tx <= BOSTA;  
                                      
                when others => NULL;
            end case;
        end if;
    end process;

end Behavioral;
