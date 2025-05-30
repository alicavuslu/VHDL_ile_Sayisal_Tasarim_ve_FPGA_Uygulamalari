library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
entity tb_saat_frekans_bolucu is
end tb_saat_frekans_bolucu;
	
architecture Behavioral of tb_saat_frekans_bolucu is

  component saat_frekans_bolucu
  generic(
    N : integer := 16
  );
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    out_clk_2 : out std_logic;
    out_clk_4 : out std_logic;
    out_clk_8 : out std_logic;
    out_clk_16 : out std_logic;
    out_clk_N : out std_logic                                                                 
  );        
  end component;

  constant CLK_PERIOD : time := 150 ns;
  signal in_clk : std_logic := '0';
  signal in_rst : std_logic := '0';
  signal out_clk_2 : std_logic := '0';
  signal out_clk_4 : std_logic := '0';
  signal out_clk_8 : std_logic := '0';
  signal out_clk_16 : std_logic := '0';
  signal out_clk_N : std_logic := '0';   
	
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
    in_rst <= '1'; wait for 120 ns;            
    in_rst <= '0'; wait; 
  end process;
	
  saat_frekans_bolucu_map : saat_frekans_bolucu
  generic map( N => 16  )
  port map ( 
    in_clk => in_clk,
    in_rst => in_rst,
    out_clk_2 => out_clk_2,
    out_clk_4 => out_clk_4,
    out_clk_8 => out_clk_8,
    out_clk_16 => out_clk_16,
    out_clk_N => out_clk_N 
  );
end Behavioral;