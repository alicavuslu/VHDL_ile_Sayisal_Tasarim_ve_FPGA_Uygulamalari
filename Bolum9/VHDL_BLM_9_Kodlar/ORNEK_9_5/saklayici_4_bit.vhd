library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity saklayici_4_bit is
  port (
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_giris : in std_logic_vector(3 downto 0);
    out_cikis : out std_logic_vector(3 downto 0)
  );
end saklayici_4_bit;
	
architecture Behavioral of saklayici_4_bit is
	
  signal r_saklayici : std_logic_vector(3 downto 0);
	
begin
	
  out_cikis <= r_saklayici;
	
  process(in_clk, in_rst, in_giris)
  begin
    if in_rst = '1' then
      r_saklayici <= (others => '0');
    elsif rising_edge(in_clk) then
      r_saklayici <= in_giris;        
    end if;
  end process;
	
end Behavioral;