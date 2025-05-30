library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.ALL;
	
entity dosya_okuma_karakter is
end dosya_okuma_karakter;

architecture Behavioral of dosya_okuma_karakter is

  constant CLK_PERIOD : time := 150 ns;
  constant VERI_YOLU : string := "C:\karakter.txt";

  signal r_giris_data : character;
  signal in_clk : std_logic := '0';
	
begin
	
  process
  begin
    in_clk <= '1';
    wait for CLK_PERIOD / 2;
    in_clk <= '0';
    wait for CLK_PERIOD / 2;		
  end process;
	
  process(in_clk)
    file dosya : text open read_mode is VERI_YOLU;
    variable satir : line;
    variable data : character;
	
  begin
    if rising_edge(in_clk) then
      if not endfile(dosya)  then
        readline(dosya, satir);
        read(satir, data);				
      end if;
    end if;
    r_giris_data <= data;			
  end process;
end Behavioral;