library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
	
entity ornek_std_logic is
  port(
    in_giris_1 : in  std_logic_vector(1 downto 0);
    in_giris_2 : in std_logic_vector(1 downto 0);
    out_cikis_toplam : out std_logic_vector(1 downto 0);
    out_cikis_fark : out std_logic_vector(1 downto 0);
    out_cikis_carpim : out std_logic_vector(3 downto 0)
  );
end ornek_std_logic;
	
architecture Behavioral of ornek_std_logic is
	
begin
	
  out_cikis_toplam <= in_giris_1 + in_giris_2;
  out_cikis_fark <= in_giris_1 - in_giris_2;
  out_cikis_carpim <= in_giris_1 * in_giris_2;
	
end Behavioral; 