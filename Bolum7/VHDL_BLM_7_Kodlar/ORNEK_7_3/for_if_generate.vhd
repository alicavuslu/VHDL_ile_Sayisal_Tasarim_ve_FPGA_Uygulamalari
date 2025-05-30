library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity for_if_generate is
  port (
    in_giris_1 : in std_logic_vector(7 downto 0);  
    in_giris_2 : in std_logic_vector(7 downto 0);  
    out_cikis : out std_logic_vector(7 downto 0);  
    out_cikis_elde : out std_logic
  );
end for_if_generate;
	
architecture Behavioral of for_if_generate is
	
  signal r_toplam : std_logic_vector(8 downto 1);
	
begin
	
  for_kontrol : for n_i in 0 to 7 generate
    if_kontrol_EAB : if n_i = 0 generate 
      out_cikis(n_i)<= in_giris_1(n_i) xor in_giris_2(n_i);
      r_toplam(n_i + 1)<= in_giris_1(n_i) and in_giris_2(n_i);
    end generate if_kontrol_EAB;
	
    if_kontrol_DB : if n_i> 0 generate
      out_cikis(n_i) <= r_toplam(n_i) xor 
      in_giris_1(n_i) xor in_giris_2(n_i);
	         
      r_toplam(n_i + 1)<= (r_toplam(n_i) and 
      in_giris_1(n_i)) or (in_giris_1(n_i) and 
      in_giris_2(n_i)) or (in_giris_2(n_i) and 
      r_toplam(n_i));  
	      
    end generate if_kontrol_DB;
  end generate for_kontrol;
	
  out_cikis_elde <= r_toplam(8);
	
end Behavioral;
