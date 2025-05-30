library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
entity kaydirmali_saklayici is
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_giris : in std_logic;
    out_cikis : out std_logic_vector(3 downto 0)
  );
end kaydirmali_saklayici;
	
architecture Behavioral of kaydirmali_saklayici is

  signal r_saklayici : std_logic_vector(3 downto 0):= (others => '0');
	
begin
	
  out_cikis <= r_saklayici;
	
  process(in_clk, in_rst, in_giris)
  begin
    if in_rst = '1' then
      r_saklayici <= (others => '0');
    elsif rising_edge(in_clk) then
      r_saklayici(3) <= in_giris ;
      r_saklayici(2) <= r_saklayici(3) ;
      r_saklayici(1) <= r_saklayici(2) ;
      r_saklayici(0) <= r_saklayici(1) ;
	
    end if;
  end process;
	
end Behavioral;