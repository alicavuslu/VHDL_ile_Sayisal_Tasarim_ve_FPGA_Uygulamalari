library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity ornek_signed is
  port (
    in_giris_1 : in std_logic_vector(3 downto 0);
    in_giris_2 : in std_logic_vector(3 downto 0); 
    in_giris_3 : in signed(3 downto 0);
    out_cikis_1 : out std_logic_vector(3 downto 0); 
    out_cikis_2 : out signed(3 downto 0)
  );
end ornek_signed;
	
architecture Behavioral of ornek_signed is

begin
	
  out_cikis_1 <= std_logic_vector(in_giris_3) + 1;
  out_cikis_2 <= signed(in_giris_1 + in_giris_2);
	
end Behavioral;