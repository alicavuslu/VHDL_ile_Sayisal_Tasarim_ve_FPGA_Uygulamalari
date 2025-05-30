library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
entity wait_until_ornek is
  Port ( 
    in_clk : in std_logic;
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    in_giris_secme : in std_logic;
    out_cikis : out std_logic
  );    
end wait_until_ornek;
	
architecture Behavioral of wait_until_ornek is
	
begin
	
  process
  begin
	   
    wait until in_clk'event and in_clk = '1';
	    
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