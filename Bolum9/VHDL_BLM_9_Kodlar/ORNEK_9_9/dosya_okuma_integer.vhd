library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use std.textio.ALL;
	
entity dosya_okuma_integer is
end dosya_okuma_integer;
	
architecture Behavioral of dosya_okuma_integer is
	  
  constant CLK_PERIOD : time := 150 ns;
  constant VERI_YOLU : string := "C:\sin.txt";
  signal r_giris_data : std_logic_vector(23 downto 0) := (others=> '0');
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
    variable data : integer;
  begin
    if rising_edge(in_clk) then
      if not endfile(dosya)  then
        readline(dosya, satir);
        read(satir, data);
        r_giris_data <= conv_std_logic_vector(data, r_giris_data'length);			
      end if;
    end if;
  end process;
	
end Behavioral;