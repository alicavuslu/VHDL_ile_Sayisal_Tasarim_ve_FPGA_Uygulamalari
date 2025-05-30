library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
entity if_ornek_process is
  Port ( 
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    in_giris_secme : in std_logic;
    out_cikis : out std_logic
  );
end if_ornek_process;
	
architecture Behavioral of if_ornek_process is
	
begin
	
  process(in_giris_1, in_giris_2, in_giris_secme)
  begin
	
    if in_giris_secme = '0' then
      out_cikis <= in_giris_1;
    elsif in_giris_secme = '1' then
      out_cikis <= in_giris_2;
    else
      out_cikis <= '0';
    end if;
	
  end process;
end Behavioral;