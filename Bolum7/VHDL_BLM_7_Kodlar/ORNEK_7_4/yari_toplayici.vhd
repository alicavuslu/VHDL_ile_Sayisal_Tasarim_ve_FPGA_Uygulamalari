library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity yari_toplayici is
  Port ( 
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    out_cikis : out std_logic;
    out_cikis_elde : out std_logic                            
  );
end yari_toplayici;
	
architecture Behavioral of yari_toplayici is
	
begin
	
  out_cikis <= in_giris_1 xor in_giris_2;    
  out_cikis_elde <= in_giris_1 and in_giris_2;   

end Behavioral;