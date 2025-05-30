library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ornekler_paket.all;
	
entity tb_rom is
end tb_rom;

architecture Behavioral of tb_rom is
  component rom 
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
  end component;
	
  component rom_dosya 
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
  end component;
	
  constant CLK_PERIOD : time := 150 ns;
  constant ROM_DERINLIGI : integer := 30;
  constant VERI_UZUNLUGU : integer := 4;
  constant ROM_DERINLIGI_DOSYA : integer := 500;
  constant VERI_UZUNLUGU_DOSYA : integer := 24;
	  
  signal in_clk : std_logic := '0';
  signal in_rom_aktif : std_logic := '0';
  signal in_data_addr_rom : std_logic_vector( log2_int(ROM_DERINLIGI) - 1 downto 0) := (others => '0');
  signal out_data_rom :  std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0');
  signal in_data_addr_rom_dosya: std_logic_vector( log2_int(ROM_DERINLIGI_DOSYA) - 1 downto 0) := (others => '0');
  signal out_data_rom_dosya :  std_logic_vector( VERI_UZUNLUGU_DOSYA - 1 downto 0) := (others => '0');
	
begin
	
  process
  begin
    in_clk <= '1';
    wait for CLK_PERIOD / 2;
    in_clk <= '0';
    wait for CLK_PERIOD / 2;		
  end process;
	
  process(in_clk)
  begin  
    if rising_edge(in_clk) then
      in_data_addr_rom <= in_data_addr_rom + 1;
      if in_data_addr_rom = ROM_DERINLIGI - 1 then
        in_data_addr_rom <= (others => '0');
      end if;
      in_data_addr_rom_dosya <= in_data_addr_rom_dosya + 1;
      
      if in_data_addr_rom_dosya = ROM_DERINLIGI_DOSYA - 1 then
        in_data_addr_rom_dosya <= (others => '0');
      end if;
    end if;
  end process;
  in_rom_aktif <= '1';
  rom_map : rom generic map(
    ROM_DERINLIGI => ROM_DERINLIGI,
    VERI_UZUNLUGU => VERI_UZUNLUGU   )
  port map ( 
    in_clk => in_clk,
    in_rom_aktif => in_rom_aktif,
    in_data_addr => in_data_addr_rom,
    out_data => out_data_rom  );    
	
  rom_dosya_map : rom_dosya generic map(
    ROM_DERINLIGI => ROM_DERINLIGI_DOSYA,
    VERI_UZUNLUGU => VERI_UZUNLUGU_DOSYA  )
  port map ( 
    in_clk => in_clk,
    in_rom_aktif => in_rom_aktif,
    in_data_addr => in_data_addr_rom_dosya,
    out_data => out_data_rom_dosya);

end Behavioral;
