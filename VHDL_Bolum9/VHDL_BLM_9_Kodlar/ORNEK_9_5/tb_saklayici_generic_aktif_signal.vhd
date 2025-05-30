library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_saklayici_generic_aktif_signal is
end tb_saklayici_generic_aktif_signal;

architecture Behavioral of tb_saklayici_generic_aktif_signal is
	
  component saklayici_generic_aktif_signal
  Generic(
    n_bit : integer := 4
  );
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_en : in std_logic;
    in_giris : in std_logic_vector(n_bit - 1 downto 0);
    out_cikis : out std_logic_vector(n_bit - 1 downto 0)
  );
  end component;
	
  constant CLK_PERIOD : time := 150 ns;
  signal in_clk : std_logic := '0';
  signal in_rst : std_logic := '0';
  signal in_en: std_logic := '0';
  signal in_giris : std_logic_vector(3 downto 0) := (others => '0');
  signal out_cikis : std_logic_vector(3 downto 0) := (others => '0');
	
begin
	
	
  Process
  Begin
    in_clk <= '1';
    wait for CLK_PERIOD / 2;
	
    in_clk <= '0';
    wait for CLK_PERIOD / 2;        
	
  end process;
	
  Process
  Begin
    in_rst <= '0'; wait for 50 ns;            
    in_rst <= '1'; wait for 150 ns;
    in_rst <= '0'; wait for 300 ns;
    in_rst <= '1'; wait for 100 ns;
    in_rst <= '0'; wait for 100 ns;
    in_rst <= '1';  wait for 280 ns;
    in_rst <= '0'; wait for 20 ns;                
  end process;
	
  process
  begin
    in_en <= '1'; wait for 250 ns;            
    in_en <= '0'; wait for 150 ns;
    in_en <= '1'; wait for 250 ns;            
    in_en <= '0'; wait for 150 ns;
    in_en <= '1'; wait for 200 ns;             
  end process; 
	
	
  process
  begin
    in_giris <= (others => '0'); wait for 100 ns;
    in_giris <= (others => '1'); wait for 370 ns;
    in_giris <= (others => '0'); wait for 230 ns;
    in_giris <= (others => '1'); wait for 100 ns;
    in_giris <= (others => '0'); wait for 200 ns;
  end process;
	
  saklayici_generic_aktif_signal_map : 
  saklayici_generic_aktif_signal
  generic map(
    n_bit => 4
  )
  port map( 
    in_clk => in_clk,
    in_rst => in_rst,
    in_en => in_en,
    in_giris => in_giris,
    out_cikis => out_cikis
  );
	
end Behavioral;