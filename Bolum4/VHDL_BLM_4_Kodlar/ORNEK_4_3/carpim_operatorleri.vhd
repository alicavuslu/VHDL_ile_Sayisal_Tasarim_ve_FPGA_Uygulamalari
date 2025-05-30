library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
	
entity carpim_operatorleri is
  Port ( 
    in_giris_1 : in std_logic_vector(3 downto 0) := "0100";
    in_giris_2 : in std_logic_vector(3 downto 0) := "0100"; 
    in_giris_3 : in integer := 19;
    out_cikis_carpim : out std_logic_vector(7 downto 0);
    out_cikis_bolme : out integer;   
    out_cikis_mod : out integer;
    out_cikis_rem : out integer
  );
end carpim_operatorleri;
	
architecture Behavioral of carpim_operatorleri is
	
begin
	
  process(in_giris_1, in_giris_2, in_giris_3)
  begin
	
    out_cikis_carpim <= in_giris_1 * in_giris_2;
    out_cikis_bolme <= in_giris_3 / conv_integer(in_giris_2);
    out_cikis_mod <= in_giris_3 mod conv_integer(in_giris_2);
    out_cikis_rem <= in_giris_3 rem conv_integer(in_giris_2);
	
  end process;
	
end Behavioral;