library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
	
entity tam_toplayici is
  port (
    in_giris_elde : in std_logic;
    in_giris_1 : in std_logic_vector(3 downto 0);
    in_giris_2 : in std_logic_vector(3 downto 0);
    out_cikis : out std_logic_vector(3 downto 0);
    out_cikis_elde : out std_logic
  );
end tam_toplayici;
	
architecture Behavioral of tam_toplayici is
	
  signal r_Toplam : std_logic_vector(4 downto 0);
	
begin
	
  r_Toplam<= ('0' & in_giris_1) + in_giris_2 + in_giris_elde;
  out_cikis_elde<= r_Toplam(4);
  out_cikis<= r_Toplam(3 downto 0);

end Behavioral;