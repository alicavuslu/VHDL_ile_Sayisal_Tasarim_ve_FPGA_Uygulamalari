library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ornek_signed is
  port (
    in_giris_1 : in integer range 0 to 15;
    in_giris_2 : in integer range 0 to 31;
    in_giris_3 : in integer range 0 to 128;
    out_cikis_1 : out integer range 0 to 511;
    out_cikis_2 : out integer
  );
end ornek_signed;

architecture Behavioral of ornek_signed is
	
begin
	
  out_cikis_1 <= in_giris_1 * in_giris_2;
  out_cikis_2 <= in_giris_2 * in_giris_3;
	
end Behavioral;