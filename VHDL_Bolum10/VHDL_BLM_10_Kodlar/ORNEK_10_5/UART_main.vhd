
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_main is
    Port ( 
		in_clk : in std_logic;
		in_rst : in std_logic;
		in_rx : in std_logic;
		out_tx : out std_logic
	);
end UART_main;

architecture Behavioral of UART_main is

	component UART_tx
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
	end component;
	
	component UART_rx
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
	end component;
	
	type t_Data_Cntrl is (BOSTA, DATA_AL, DATA_GONDER);
	signal r_Data_Cntrl : t_Data_Cntrl := BOSTA;
	
	signal r_tx_basla : std_logic := '0';
	signal r_tx_tamam : std_logic := '0';
	signal r_rx_tamam : std_logic := '0';
	signal r_data : std_logic_vector(7 downto 0);
	signal r_rx_data : std_logic_vector(7 downto 0);
	signal r_tx_data : std_logic_vector(7 downto 0);
	
begin

	process(in_clk, in_rst)
	begin
		if in_rst = '1' then
			r_Data_Cntrl <= BOSTA;
			r_data <= (others => '0');
			
		elsif rising_edge(in_clk) then
			r_tx_basla <= '0';
			case r_Data_Cntrl is 	
				when BOSTA =>
					r_Data_Cntrl <= DATA_AL;
				when DATA_AL =>
					if r_rx_tamam = '1' then
						r_tx_data <= r_rx_data;
						r_tx_basla <= '1';
					end if;
										
				when DATA_GONDER => 
					if r_tx_tamam = '1' then
						r_Data_Cntrl <= BOSTA;
					end if;
				when others => NULL;
				
			end case;
		end if;
	end process;
	
	UART_rx_map : UART_rx
	Generic map( 
        CLK_FREKANS => 100000000, --100 MHz
        BOUDRATE => 115200
    )
    Port map(
        in_clk => in_clk,
        in_rst => in_rst,
        in_rx => in_rx,
        out_rx_data => r_rx_data,
        out_rx_tamam => r_rx_tamam
    );	

	UART_tx_map : UART_tx
	Generic map( 
        CLK_FREKANS => 100000000, --100 MHz
        BOUDRATE => 115200
    )
    Port map(
        in_clk => in_clk,
        in_rst => in_rst,
        in_tx_basla => r_tx_basla,
        in_tx_data => r_tx_data,
        out_tx => out_tx,
        out_tx_tamam => r_tx_tamam
    );

end Behavioral;
