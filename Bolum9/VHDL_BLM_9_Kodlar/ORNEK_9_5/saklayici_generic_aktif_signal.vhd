library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
entity saklayici_generic_aktif_signal is
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
	end saklayici_generic_aktif_signal;
	
architecture Behavioral of saklayici_generic_aktif_signal is

  signal r_saklayici : std_logic_vector(n_bit - 1 downto 0); 

begin

  out_cikis <= r_saklayici;
	
  process(in_clk, in_rst, in_en, in_giris)
  begin
    if in_rst = '1' then
      r_saklayici <= (others => '0');
    elsif rising_edge(in_clk) then
      if in_en = '1' then
        r_saklayici <= in_giris;
      end if;        
    end if;
  end process;
end Behavioral;