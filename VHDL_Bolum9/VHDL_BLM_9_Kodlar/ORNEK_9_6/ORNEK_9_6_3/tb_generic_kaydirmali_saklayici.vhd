library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
entity tb_generic_kaydirmali_saklayici is
end tb_generic_kaydirmali_saklayici;
	
architecture Behavioral of tb_generic_kaydirmali_saklayici is
	
  component generic_kaydirmali_saklayici
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_yon : in std_logic;
    in_giris : in std_logic;
    out_cikis : out std_logic_vector(3 downto 0)    );
  end component;
	
  constant CLK_PERIOD : time := 150 ns;
  signal in_clk : std_logic := '0';
  signal in_rst : std_logic := '0';
  signal in_yon : std_logic := '0';
  signal in_giris : std_logic := '0';
  signal out_cikis : std_logic_vector(3 downto 0) := (others => '0');
	
begin
	
  process
  begin
    in_clk <= '1';    wait for CLK_PERIOD / 2;
    in_clk <= '0';    wait for CLK_PERIOD / 2;        
 end process;
	
  process
  begin
    in_rst <= '0'; wait for 550 ns;
    in_rst <= '1'; wait for 150 ns;
    in_rst <= '0'; wait for 300 ns;            
  end process;
	
  process
  begin
    in_yon <= '0'; wait for 350 ns;
    in_yon <= '1'; wait for 350 ns;
    in_yon <= '0'; wait for 300 ns;            
  end process;    
	
  process
  begin
    in_giris <= '1'; wait for CLK_PERIOD;
    in_giris <= '0'; wait for CLK_PERIOD;
    in_giris <= '1'; wait for CLK_PERIOD;
    in_giris <= '0'; wait for CLK_PERIOD;
    in_giris <= '1'; wait for 3 * CLK_PERIOD; 
    in_giris <= '0'; wait for CLK_PERIOD;                         
  end process;
	
  generic_kaydirmali_saklayic_map : generic_kaydirmali_saklayici
  port map(
    in_clk => in_clk,
    in_rst => in_rst,
    in_yon => in_yon,
    in_giris => in_giris,
    out_cikis => out_cikis        
  );
	
end Behavioral;