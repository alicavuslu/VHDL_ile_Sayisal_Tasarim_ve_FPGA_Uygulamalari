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
	
  signal r_saklayici : std_logic_vector(3 downto 0) := (others => '0');
	
begin
	
  out_cikis <= r_saklayici;

  process(in_clk, in_rst, in_giris)
    variable v_saklayici : std_logic_vector(3 downto 0) := (others => '0');
  begin
    if in_rst = '1' then
      v_saklayici := (others => '0');
	
    elsif rising_edge(in_clk) then
      v_saklayici(3) := in_giris ;
      v_saklayici(2) := v_saklayici(3) ;
      v_saklayici(1) := v_saklayici(2) ;
      v_saklayici(0) := v_saklayici(1) ;

    end if;
    r_saklayici <= v_saklayici;
  end process;
	
end Behavioral;
