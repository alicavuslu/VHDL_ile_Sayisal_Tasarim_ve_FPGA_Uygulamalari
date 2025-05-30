library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity for_ornek_function is
  Port ( 
    in_giris : in std_logic_vector(7 downto 0);
    out_cikis : out std_logic_vector(7 downto 0)
  );
end for_ornek_function;
	
architecture Behavioral of for_ornek_function is
	
  function fonksiyon_for(sinyal_giris : std_logic_vector(7 downto 0)) return std_logic_vector is

    variable sinyal_cikis : std_logic_vector(8 downto 0);
	
  begin
	
    sinyal_cikis(0) := '0';
    for n_i in 0 to 7 loop
      sinyal_cikis(n_i + 1) := sinyal_cikis(n_i) or sinyal_giris(n_i);
    end loop;
    return sinyal_cikis(8 downto 1);
  end fonksiyon_for;

begin
	
  out_cikis <= fonksiyon_for(in_giris);

end Behavioral;