library IEEE;
use IEEE.STD_LOGIC_1164.all;
	
entity bit_say_signal is
  port(
    in_giris : in std_logic_vector(0 to 7);
    out_sayac : out integer
  );
end bit_say_signal;
	
architecture Behavioral of bit_say_signal is
	
  signal r_sayac : integer := 0;
	
begin
	
  process(in_giris)
  begin
    r_sayac<= 0;
	
    for n_i in 7 downto 0 loop
      if in_giris(n_i) = '1' then
        r_sayac<= r_sayac + 1;
      end if;       
    end loop;
	
  end process;
	    
  out_sayac <= r_sayac;
	
end Behavioral;