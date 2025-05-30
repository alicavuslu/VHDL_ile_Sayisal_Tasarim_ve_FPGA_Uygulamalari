library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
entity tb_sayac_4_bit is
end tb_sayac_4_bit;
	
architecture Behavioral of tb_sayac_4_bit is
  component sayac_4_bit
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    out_cikis : out std_logic_vector(3 downto 0)
  );
  end component;
	
  constant CLK_PERIOD : time := 150 ns;
  signal in_clk : std_logic := '0';
  signal in_rst : std_logic := '0';
  signal out_cikis : std_logic_vector(3 downto 0) := (others => '0');    
	
begin
	
  process
  begin
    in_clk <= '1';
    wait for CLK_PERIOD / 2;
    in_clk <= '0';
    wait for CLK_PERIOD / 2;        
  end process;
	
  process
  begin
    in_rst <= '0'; wait for 550 ns;            
    in_rst <= '1'; wait for 150 ns;
    in_rst <= '0'; wait for 300 ns;               
  end process;
	
  sayac_4_bit_map : sayac_4_bit
  port map(
    in_clk => in_clk,
    in_rst => in_rst,
    out_cikis => out_cikis        
  );     
end Behavioral;