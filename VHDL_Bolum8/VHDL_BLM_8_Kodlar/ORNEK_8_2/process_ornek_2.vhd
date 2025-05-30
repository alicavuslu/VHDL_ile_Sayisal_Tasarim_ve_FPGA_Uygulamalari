library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity process_ornek_2 is
  Port ( 
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    in_giris_3 : in std_logic;
    out_sonuc : out std_logic
  );
end process_ornek_2;
	
architecture Behavioral of process_ornek_2 is

begin
	
  process_etiketi:process(in_giris_3)
  begin
		
     out_sonuc <= (in_giris_1 and in_giris_2) or in_giris_3;    

  end process process_etiketi;
end Behavioral;