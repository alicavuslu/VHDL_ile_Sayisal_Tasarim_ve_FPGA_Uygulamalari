library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ornekler_paket.all;
	
entity rom is
  Generic(
    ROM_DERINLIGI : integer := 30;
    VERI_UZUNLUGU : integer := 4                
  );
  Port ( 
    in_clk : in std_logic;
    in_rom_aktif : in std_logic;
    in_data_addr : in std_logic_vector(log2_int(ROM_DERINLIGI) - 1 downto 0);
    out_data : out std_logic_vector(VERI_UZUNLUGU - 1 downto 0)
  );
end rom;

architecture Behavioral of rom is
	
  type t_ROM_DATA is array (0 to ROM_DERINLIGI - 1) of std_logic_vector(VERI_UZUNLUGU - 1 downto 0) ; 
  constant r_ROM_DATA : t_ROM_DATA := ( X"0", X"3", X"6", X"9", X"C", 
X"F", X"C", X"9", X"6", X"3", X"0", X"3", X"6", X"9", X"C",
X"F", X"C", X"9", X"6", X"3", X"0", X"3", X"6", X"9", X"C", 
X"F", X"C", X"9", X"6", X"3" );
	
begin
	  
  process(in_clk)
  begin
    if rising_edge(in_clk) then
      if in_rom_aktif = '1' then
        out_data <= r_ROM_DATA(conv_integer(in_data_addr));
      end if;
    end if;
  end process;
end Behavioral;
