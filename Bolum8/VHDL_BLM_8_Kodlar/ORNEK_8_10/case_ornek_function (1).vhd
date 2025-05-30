library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity case_ornek_function is
  Port ( 
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    in_giris_secme : in std_logic;
    out_cikis : out std_logic
  );
end case_ornek_function;
	
architecture Behavioral of case_ornek_function is
	
  function secme_case(sinyal_1, sinyal_2, sinyal_secme : std_logic) return std_logic is
	
    variable sinyal_cikis : std_logic;
	
  begin
	
    case sinyal_secme is
      when '0' =>
        sinyal_cikis := sinyal_1;
	
      when '1' =>
        sinyal_cikis := sinyal_2;
	
      when others =>
        sinyal_cikis := '0';
    end case;
    return sinyal_cikis;
  end secme_case;
	
begin
	
  out_cikis <= secme_case(in_giris_1, in_giris_2, in_giris_secme);
	
end Behavioral;