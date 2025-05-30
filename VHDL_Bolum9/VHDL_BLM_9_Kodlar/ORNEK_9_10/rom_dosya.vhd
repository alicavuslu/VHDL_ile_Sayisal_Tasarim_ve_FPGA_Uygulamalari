library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use std.textio.ALL;
use work.ornekler_paket.all;

entity rom_dosya is
  Generic(
    ROM_DERINLIGI : integer := 500;
    VERI_UZUNLUGU : integer := 24                
  );
  Port ( 
    in_clk : in std_logic;
    in_rom_aktif : in std_logic;
    in_data_addr : in std_logic_vector(log2_int(ROM_DERINLIGI) - 1 downto 0);
    out_data : out std_logic_vector(VERI_UZUNLUGU - 1 downto 0)
  );
end rom_dosya;
	
architecture Behavioral of rom_dosya is
	
  constant VERI_YOLU : string := "C:\sin.txt";
  type t_ROM_DATA is array (0 to ROM_DERINLIGI - 1) of std_logic_vector(VERI_UZUNLUGU - 1 downto 0) ; 
  signal r_ROM_DATA : t_ROM_DATA;
	
  procedure ROM_DATA_YUKLE(signal r_ROM_DATA : inout t_ROM_DATA) is
    file dosya : text open read_mode is VERI_YOLU;
    variable satir  :line;
    variable data : integer;
  begin
    for n_i in 0 to ROM_DERINLIGI - 1 loop
      if endfile(dosya) then
        exit;
      else
        readline(dosya, satir);
        read(satir, data);
        r_ROM_DATA(n_i) <= conv_std_logic_vector(data, VERI_UZUNLUGU);
      end if;
    end loop;
  end procedure;

begin

  ROM_DATA_YUKLE(r_ROM_DATA);
	  
  process(in_clk)
  begin
    if rising_edge(in_clk) then
      if in_rom_aktif = '1' then
        out_data <= r_ROM_DATA(conv_integer(in_data_addr));
      end if;
    end if;
  end process;
end Behavioral;