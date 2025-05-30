library IEEE;
use IEEE.STD_LOGIC_1164.all;
	
entity tb_eszam_rstli_d_mandali is
end tb_eszam_rstli_d_mandali;
	
architecture Behavioral of tb_eszam_rstli_d_mandali is
	
  component eszam_rstli_d_mandali
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_giris : in std_logic;
    out_cikis : out std_logic;
    out_cikis_degil : out std_logic
  );
  end component;  
	
  constant CLK_PERIOD : time := 150 ns;  
  signal in_clk : std_logic := '0';
  signal in_rst : std_logic := '0';
  signal in_giris : std_logic := '0';
  signal out_cikis : std_logic := '0';
  signal out_cikis_degil : std_logic := '0';
	
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
    in_rst <= '0'; wait for 50 ns;
    in_rst <= '1'; wait for 100 ns;
    in_rst <= '0'; wait for 300 ns;
    in_rst <= '1'; wait for 150 ns;
    in_rst <= '0'; wait for 200 ns;
    in_rst <= '1'; wait for 180 ns;
    in_rst <= '0'; wait for 20 ns;                
  end process;

  process
  begin
    in_giris <= '0'; wait for 100 ns;
    in_giris <= '1'; wait for 400 ns;
    in_giris <= '0'; wait for 200 ns;
    in_giris <= '1'; wait for 100 ns;
    in_giris <= '0'; wait for 200 ns;
  end process;
	
  eszam_rstli_d_mandali_map :
  eszam_rstli_d_mandali port map(
    in_clk => in_clk,
    in_rst => in_rst,
    in_giris => in_giris,
    out_cikis => out_cikis,
    out_cikis_degil => out_cikis_degil
  );
end Behavioral;
