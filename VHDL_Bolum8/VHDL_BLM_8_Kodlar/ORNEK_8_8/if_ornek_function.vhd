library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity if_ornek_function is
  Port ( 
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    in_giris_secme : in std_logic;
    out_cikis : out std_logic
  );
end if_ornek_function;
	
architecture Behavioral of if_ornek_function is
	
  function secme_if(sinyal_1, sinyal_2, sinyal_secme : std_logic) return std_logic is
	
    variable sinyal_cikis : std_logic;
	
  begin
    if sinyal_secme = '0' then
      sinyal_cikis := sinyal_1;
    elsif sinyal_secme = '1' then
      sinyal_cikis := sinyal_2;
    else
      sinyal_cikis := '0';
    end if;
    return sinyal_cikis;
  end secme_if;
	
begin
	
  out_cikis <= secme_if(in_giris_1, in_giris_2, in_giris_secme);

end Behavioral;