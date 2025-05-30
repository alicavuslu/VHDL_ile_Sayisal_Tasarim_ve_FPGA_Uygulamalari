library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
	
entity case_ornek_type is
  Port ( 
    in_giris_1 : in std_logic_vector(3 downto 0);
    in_giris_2 : in std_logic_vector(3 downto 0);
    out_cikis : out std_logic_vector(3 downto 0)
  );
end case_ornek_type;

architecture Behavioral of case_ornek_type is
	
  type t_MATH_ISLEM is (TOPLA, CIKAR);
  signal r_MATH_ISLEM : t_MATH_ISLEM := TOPLA;
	
begin
	
  process(in_giris_1, in_giris_2)
  begin
    case r_MATH_ISLEM is
      when TOPLA =>
        r_MATH_ISLEM <= CIKAR;
        out_cikis <= in_giris_1 + in_giris_2;
	
      when CIKAR =>
        r_MATH_ISLEM <= TOPLA;
        out_cikis <= in_giris_1 - in_giris_2;

      when others =>
        out_cikis <= (others => '0');
    end case;
  end process;
end Behavioral;