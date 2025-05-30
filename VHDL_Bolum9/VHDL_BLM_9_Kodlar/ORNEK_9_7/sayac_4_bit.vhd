library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
	
entity sayac_4_bit is
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    out_cikis : out std_logic_vector(3 downto 0)
  );
end sayac_4_bit;

architecture Behavioral of sayac_4_bit is
	
  signal r_sayac : std_logic_vector(3 downto 0) := (others => '0');
	
begin
  out_cikis <= r_sayac;
	
  process(in_clk, in_rst)
  begin
    if in_rst = '1' then
      r_sayac <= (others => '0');
    elsif rising_edge(in_clk) then
      r_sayac <= r_sayac + 1;
    end if;
  end process;
	
end Behavioral;