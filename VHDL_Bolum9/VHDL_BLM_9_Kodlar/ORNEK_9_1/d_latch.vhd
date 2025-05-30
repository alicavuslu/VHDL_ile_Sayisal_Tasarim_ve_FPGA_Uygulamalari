library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity d_latch is
  port (
    in_en : in std_logic;
    in_giris : in std_logic;
    out_cikis : out std_logic;
    out_cikis_degil : out std_logic
  );
end d_latch;
	
architecture Behavioral of d_latch is
	
  signal r_cikis : std_logic := '0';
	
begin
	
  process(in_en, in_giris)
  begin
	
    if in_en = '1' then
      r_cikis <= in_giris;
    end if;
	
  end process;
	
  out_cikis <= r_cikis;
  out_cikis_degil <= (not r_cikis);
	
end Behavioral;