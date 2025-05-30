library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.ALL;
use work.ornekler_paket.all;
	
entity tb_blok_ram is
end tb_blok_ram;

architecture Behavioral of tb_blok_ram is
	
  component blok_ram
  generic(
    VERI_UZUNLUGU : integer := 8;
    RAM_DERINLIGI : integer := 110
  );
  port(
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_ram_aktif : in std_logic;
    in_yaz_en : in std_logic;
    in_data_addr : in std_logic_vector(log2_int(RAM_DERINLIGI) - 1 downto 0);
    in_data : in std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    out_data : out std_logic_vector(VERI_UZUNLUGU - 1 downto 0)
  );
  end component;
	
  type t_RAM_Kontrol is (DATA_YAZ, DATA_OKU, TAMAM);
  signal r_RAM_Kontrol : t_RAM_Kontrol := DATA_YAZ;
	   
  constant CLK_PERIOD : time := 150 ns;
  constant VERI_UZUNLUGU : integer := 24;
  constant RAM_DERINLIGI : integer := 500;
  constant VERI_YOLU : string := "C:\sin.txt";
	  
  signal in_clk : std_logic := '0';
  signal in_rst : std_logic := '0';
  signal in_ram_aktif : std_logic := '0';
  signal in_yaz_en : std_logic := '0';
  signal in_data_addr : std_logic_vector(log2_int(RAM_DERINLIGI) - 1 downto 0) := (others => '0');
  signal in_data : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0');
  signal out_data : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0');    
  signal sayac : std_logic_vector(log2_int(RAM_DERINLIGI) - 1 downto 0) := (others => '0');
  signal ORNEK_SAYISI : std_logic_vector(log2_int(RAM_DERINLIGI) - 1 downto 0) := (others => '0');
	
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
      case r_RAM_Kontrol is
        when DATA_YAZ =>
          if (not endfile(dosya)) then
            readline(dosya, satir);
            read(satir, data);
            in_data <= conv_std_logic_vector(data, VERI_UZUNLUGU);
            in_data_addr <= sayac;
            in_yaz_en <= '1';
            in_ram_aktif <= '1';
            if sayac = RAM_DERINLIGI - 1 then
              sayac <= (others => '0');	
              ORNEK_SAYISI <= sayac;
              r_RAM_Kontrol <= DATA_OKU;
            else 
              sayac <= sayac + 1;	
            end if;
          end if;
	
        when DATA_OKU =>
          in_yaz_en <= '0';
          in_data_addr <= sayac;
          sayac <= sayac + 1;	
          if sayac = ORNEK_SAYISI then
            r_RAM_Kontrol <= TAMAM;
          end if;
	
        when TAMAM => 
          in_ram_aktif <= '0';	
	            
        when others => NULL;
      end case;
    end if;
  end process;	
	
  blok_ram_map : blok_ram
  generic map(
	VERI_UZUNLUGU => VERI_UZUNLUGU,
    RAM_DERINLIGI => RAM_DERINLIGI
  )
  port map(
    in_clk => in_clk,
    in_rst => in_rst,
    in_ram_aktif => in_ram_aktif,
    in_yaz_en => in_yaz_en,
    in_data_addr => in_data_addr ,
    in_data => in_data,
    out_data => out_data
  );
end Behavioral;