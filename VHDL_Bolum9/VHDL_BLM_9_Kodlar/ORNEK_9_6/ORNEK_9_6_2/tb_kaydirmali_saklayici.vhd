library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_kaydirmali_saklayici is
end tb_kaydirmali_saklayici;
	
architecture Behavioral of tb_kaydirmali_saklayici is
	
  component kaydirmali_saklayici
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_giris : in std_logic;
    out_cikis : out std_logic_vector(3 downto 0)
  );
  end component;
	
  constant CLK_PERIOD : time := 150 ns;
  signal in_clk : std_logic := '0';
  signal in_rst : std_logic := '0';
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
    in_rst <= '0'; wait for 350 ns;
    in_rst <= '1'; wait for 150 ns;
    in_rst <= '0'; wait for 450 ns;
    in_rst <= '1'; wait for 50 ns;              
  end process;
	
  process
  begin
    in_giris <= '1'; wait for CLK_PERIOD;
    in_giris <= '0'; wait for CLK_PERIOD;
    in_giris <= '1'; wait for 3 * CLK_PERIOD;
    in_giris <= '0'; wait for CLK_PERIOD;
    in_giris <= '1'; wait for CLK_PERIOD; 
    in_giris <= '0'; wait for CLK_PERIOD;                         
  end process;
	
  kaydirmali_saklayic_map : kaydirmali_saklayici
  port map(
    in_clk => in_clk,
    in_rst => in_rst,
    in_giris => in_giris,
    out_cikis => out_cikis        
  );
end Behavioral;