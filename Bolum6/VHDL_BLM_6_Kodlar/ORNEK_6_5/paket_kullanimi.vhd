library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
library work;
use work.benim_paketim.all;
	
entity paket_kullanimi is
end paket_kullanimi;
	
architecture Behavioral of paket_kullanimi is
	    
  signal r_Buyuk : t_Kelime;
	
begin
	
  r_Buyuk <= buyuk_bul(r_Kelime_1, r_Kelime_2);
  generic_toplayici_4_bit : generic_toplayici
    Generic map( n_bit => VERI_UZUNLUGU )
    Port map (  
      in_giris_elde => r_giris_1,
      in_giris_1 => in_giris_1,
      in_giris_2 => in_giris_2,
      out_cikis => open,
      out_cikis_elde => r_giris_2      
  );
end Behavioral;