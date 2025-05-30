library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ornekler_paket.all;

entity block_ram is
  generic(
    VERI_UZUNLUGU : integer := 8;
    RAM_DERINLIGI : integer := 110
  );
  port(
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_ram_aktif : in std_logic;
    in_yaz_en : in std_logic;
    in_oku_en : in std_logic;
    in_data_addr : in std_logic_vector(log2_int(RAM_DERINLIGI) - 1 downto 0);
    in_data : in std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    out_data : out std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    out_data_vld : out std_logic
  );
end block_ram;
	
architecture Behavioral of block_ram is
	
  type t_BRAM_DATA is array (0 to RAM_DERINLIGI - 1) of std_logic_vector(VERI_UZUNLUGU - 1 downto 0) ; 
  signal r_BRAM_DATA : t_BRAM_DATA := (others =>(others => '0'));
	
begin
	
  process(in_clk, in_rst)
  begin
    if in_rst = '1' then
      r_BRAM_DATA <= (others =>(others => '0'));

    elsif rising_edge(in_clk) then
      if in_ram_aktif = '1' then
        if in_oku_en = '1' then
          out_data <= r_BRAM_DATA( conv_integer( in_data_addr));
          out_data_vld <= '1';
        else
          out_data_vld <= '0';
        end if;
        if in_yaz_en = '1' then
          r_BRAM_DATA(conv_integer(in_data_addr)) <= in_data;
        end if;
      end if;
    end if;
  end process;
end Behavioral;