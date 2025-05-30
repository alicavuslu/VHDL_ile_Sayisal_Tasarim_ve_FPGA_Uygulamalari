library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
entity saat_darbesi_ornek is
  Port ( 
    in_clk : in std_logic;
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    in_giris_secme : in std_logic;
    out_cikis : out std_logic
  );
end saat_darbesi_ornek;
	
architecture Behavioral of saat_darbesi_ornek is
begin
	    
  process(in_clk)
  begin
	    
    if rising_edge(in_clk) then
      if in_giris_secme = '0' then
        out_cikis <= in_giris_1;
      elsif in_giris_secme = '1' then
        out_cikis <= in_giris_2;
      else
        out_cikis <= '0';
      end if;
    end if;
  end process;
end Behavioral;