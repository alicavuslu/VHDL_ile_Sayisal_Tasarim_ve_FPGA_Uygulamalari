library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
	
entity toplama_operatorleri is
  Port (
    in_giris_1 : in std_logic_vector(3 downto 0);
    in_giris_2 : in std_logic_vector(3 downto 0);
    out_cikis_toplam : out std_logic_vector(3 downto 0);
    out_cikis_fark : out std_logic_vector(3 downto 0);
    out_cikis_ekleme : out std_logic_vector(7 downto 0)
  );
end toplama_operatorleri;
	
architecture Behavioral of toplama_operatorleri is
	
begin

  process(in_giris_1, in_giris_2)
  begin

    out_cikis_toplam  <= in_giris_1 + in_giris_2;
    out_cikis_fark    <= in_giris_1 - in_giris_2;
    out_cikis_ekleme  <= in_giris_1 & in_giris_2;
	
  end process;
	
end Behavioral;