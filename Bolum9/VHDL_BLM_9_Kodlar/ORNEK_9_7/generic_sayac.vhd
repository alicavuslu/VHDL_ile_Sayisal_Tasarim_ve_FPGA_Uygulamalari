library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
	
entity generic_sayac is
  Generic(
    n_bit : integer := 4    
  );
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_say : in std_logic;
    out_cikis : out std_logic_vector(n_bit - 1 downto 0)
  );
end generic_sayac;
	
architecture Behavioral of generic_sayac is

  signal r_sayac : std_logic_vector(n_bit - 1 downto 0) := (others => '0');
	
begin
	
  out_cikis <= r_sayac;
	
  process(in_clk, in_rst)
  begin
    if in_rst = '1' then
      r_sayac <= (others => '0');
	
    elsif rising_edge(in_clk) then
      if in_say = '0' then
        r_sayac <= r_sayac + 1;
      elsif in_say = '1' then
        r_sayac <= r_sayac - 1;
      end if;
    end if;
  end process;
	
end Behavioral;