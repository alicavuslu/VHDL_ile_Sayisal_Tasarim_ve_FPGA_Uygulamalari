library IEEE;
use IEEE.STD_LOGIC_1164.all;
	
entity oncelikli_atama is
  port (
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    in_giris_3 : in std_logic;
    out_cikis : out std_logic_vector(1 downto 0)
  );
end oncelikli_atama;
	
architecture Behavioral of oncelikli_atama is
	
begin
	
  out_cikis<= "01" when in_giris_1 = '1' 
     else "10" when in_giris_2 = '1' 
     else "11" when in_giris_3 = '1' 
     else "00" ;
	
end Behavioral;