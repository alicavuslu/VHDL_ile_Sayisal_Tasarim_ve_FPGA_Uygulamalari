library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity while_ornek_function is
  Port ( 
    in_giris : in std_logic_vector(7 downto 0);
    out_cikis : out std_logic_vector(7 downto 0)
  );
end while_ornek_function;
	
architecture Behavioral of while_ornek_function is
	
  function fonksiyon_while(sinyal_giris : std_logic_vector(7 downto 0)) return std_logic_vector is
    variable sinyal_cikis : std_logic_vector(8 downto 0);
    variable n_i : integer := 0;
  begin
    sinyal_cikis(0) := '0';
    while n_i < 8 loop
      sinyal_cikis(n_i + 1) := sinyal_cikis(n_i) or sinyal_giris(n_i);
      n_i := n_i + 1;
    end loop;
    return sinyal_cikis(8 downto 1);
  end fonksiyon_while;
	
begin
	
  out_cikis <= fonksiyon_while(in_giris);   
	
end Behavioral;