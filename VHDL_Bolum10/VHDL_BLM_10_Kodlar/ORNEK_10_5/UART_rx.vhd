
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity UART_rx is
    Generic ( 
        CLK_FREKANS : integer := 100000000;
        BOUDRATE : integer := 115200
    );
	Port(
        in_clk : in std_logic;
        in_rst : in std_logic;
        in_rx : in std_logic;
        out_rx_data : out std_logic_vector(7 downto 0);
        out_rx_tamam : out std_logic
    );
end UART_rx;

architecture Behavioral of UART_rx is

	constant CLK_BIT : integer := CLK_FREKANS / BOUDRATE + 1;
    type t_UART_rx is (BOSTA, BASLA, DATA_AL, BITIR, TAMAM);
    signal r_UART_rx : t_UART_rx := BOSTA;
	
	signal r_clk_sayac : integer range 0 to CLK_BIT - 1 := 0;
    signal r_data_ind : integer range 0 to 7 := 0; 
	signal r_data   : std_logic_vector(7 downto 0) := (others => '0');
	signal r_rx_tamam : std_logic := '0';  
	signal r_rx_cnt : std_logic_vector(2 downto 0) := (others => '0'); 
	
begin
	
    out_rx_data <= r_data;
    out_rx_tamam <= r_rx_tamam;
	
	process(in_clk)
	begin
		if in_rst = '1' then
			r_UART_rx <= BOSTA;
            r_clk_sayac <= 0;
            r_data_ind <= 0;
            r_data <= (others => '0');
			r_rx_cnt <= (others => '0');
            r_rx_tamam <= '0';
			
		elsif rising_edge(in_clk) then
			r_rx_cnt <= r_rx_cnt(1 downto 0) & in_rx;
			r_rx_tamam <= '0';
			case r_UART_rx is
				when BOSTA => 
					if r_rx_cnt(2 downto 1) = "10" then
						r_UART_rx <= BASLA;						
					end if;
					
				when BASLA =>
					if r_clk_sayac = (CLK_BIT - 1) / 2 then
                        r_clk_sayac <= 0;
                        r_UART_rx <= DATA_AL;                        
                    else
						r_clk_sayac <= r_clk_sayac + 1;
                    end if;
					
				when DATA_AL =>	
					r_data(r_data_ind) <= r_rx_cnt(2);
                    if r_clk_sayac = CLK_BIT - 1 then
						r_clk_sayac <= 0;
                        if r_data_ind = 7 then
							r_data_ind <= 0;
                            r_UART_rx <= BITIR;                           
                        else
							r_data_ind <= r_data_ind + 1;
                        end if;
                        
                    else
						r_clk_sayac <= r_clk_sayac + 1;

                    end if; 
					
                when BITIR =>
                    if r_clk_sayac = CLK_BIT - 1 then
                        r_clk_sayac <= 0;
                        r_UART_rx <= TAMAM;                        
                    else
						r_clk_sayac <= r_clk_sayac + 1;
                    end if;
                
                when TAMAM =>
                    r_rx_tamam <= '1';
                    r_UART_rx <= BOSTA;  
                    					
				when others => NULL;
			end case;	
		end if;
	end process;
end Behavioral;