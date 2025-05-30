library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity case_ornek_process is
  Port ( 
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    in_giris_secme : in std_logic;
    out_cikis : out std_logic
  );
end case_ornek_process;
	
architecture Behavioral of case_ornek_process is
	
begin
  process(in_giris_1, in_giris_2, in_giris_secme)
  begin
    case in_giris_secme is
      when '0' =>
        out_cikis <= in_giris_1;
	
      when '1' =>
        out_cikis <= in_giris_2;

      when others =>
        out_cikis <= '0';
    end case;
  end process;
end Behavioral;