library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
	
entity ornek_conv is
  port (
    in_giris_1 : in std_logic_vector(9 downto 0);
    in_giris_2 : in integer range 0 to 511;
    out_cikis_1 : out integer;
    out_cikis_2 : out std_logic_vector(9 downto 0)   
  );
end ornek_conv;
	
architecture Behavioral of ornek_conv is

begin
	
  out_cikis_1 <= conv_integer(in_giris_1);
  out_cikis_2 <= conv_std_logic_vector(in_giris_2, 10);
	
end Behavioral;