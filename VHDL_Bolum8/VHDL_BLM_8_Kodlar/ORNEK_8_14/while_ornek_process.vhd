library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity while_ornek_process is
  Port ( 
    in_giris : in std_logic_vector(7 downto 0);
    out_cikis : out std_logic_vector(7 downto 0)
  );
end while_ornek_process;
	
architecture Behavioral of while_ornek_process is

  signal r_sinyal_sonuc : std_logic_vector(7 downto 0);
	
begin
	
  out_cikis <= r_sinyal_sonuc;

  process(in_giris)
	
    variable v_sinyal_sonuc : std_logic_vector(8 downto 0);
    variable n_i : integer := 0;

  begin
	    
    n_i := 0;
    v_sinyal_sonuc(0) := '0';
    while n_i < 8 loop
      v_sinyal_sonuc(n_i + 1) := v_sinyal_sonuc(n_i) or in_giris(n_i);
      n_i := n_i + 1;
    end loop;
	
    r_sinyal_sonuc <= v_sinyal_sonuc(8 downto 1);
	
  end process;
end Behavioral;