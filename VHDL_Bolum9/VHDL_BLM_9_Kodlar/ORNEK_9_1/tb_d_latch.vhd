library IEEE;
use IEEE.STD_LOGIC_1164.all;
	
entity tb_d_latch is
end tb_d_latch;
	
architecture Behavioral of tb_d_latch is
	
  component d_latch
  Port ( 
    in_en : in std_logic;
    in_giris : in std_logic;
    out_cikis : out std_logic;
    out_cikis_degil : out std_logic            
  );
  end component;
	
  signal in_en 		: std_logic := '0';
  signal in_giris 	: std_logic := '0';
  signal out_cikis 	: std_logic := '0';
  signal out_cikis_degil	: std_logic := '0';
	
begin
	
  process
  begin
    in_en <= '1'; wait for 100 ns;
    in_en <= '0'; wait for 120 ns;
    in_en <= '1'; wait for 320 ns;
    in_en <= '0'; wait for 160 ns;
    in_en <= '1'; wait for 200 ns;
    in_en <= '0'; wait for 100 ns;
  end process;
	
  process
  begin
    in_giris <= '0'; wait for 100 ns;
    in_giris <= '1'; wait for 400 ns;
    in_giris <= '0'; wait for 200 ns;
    in_giris <= '1'; wait for 100 ns;
    in_giris <= '0'; wait for 200 ns;
  end process;
	
  d_latch_map : d_latch
  port map(
    in_en => in_en,
    in_giris => in_giris,
    out_cikis => out_cikis,
    out_cikis_degil => out_cikis_degil
  );
	
end Behavioral; 