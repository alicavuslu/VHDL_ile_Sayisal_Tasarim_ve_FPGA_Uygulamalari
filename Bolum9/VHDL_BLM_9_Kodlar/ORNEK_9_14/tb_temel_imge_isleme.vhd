library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.ALL;
use work.ornekler_paket.all;
	
entity tb_temel_imge_isleme is
end tb_temel_imge_isleme;

architecture Behavioral of tb_temel_imge_isleme is
	
  component temel_imge_isleme
  generic(
    IMGE_SATIR : integer := 8;
    IMGE_SUTUN : integer:= 8;
    VERI_UZUNLUGU : integer:= 24        
  );
  port( 
	    in_clk : in std_logic;
    in_rst : in std_logic;
    in_en  : in std_logic;
    in_basla : in std_logic;
    in_islem : in std_logic_vector(2 downto 0);
    in_data : in std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    in_data_vld : in std_logic;
    out_addr : out std_logic_vector(log2_int(IMGE_SATIR * IMGE_SUTUN) - 1 downto 0);
    out_addr_vld : out std_logic;
    out_data : out std_logic_vector(7 downto 0);
    out_data_vld : out std_logic;
    out_tamam : out std_logic
  );
  end component;

  component block_ram 
  generic(
    VERI_UZUNLUGU : integer := 8;
    RAM_DERINLIGI : integer := 110
  );
  port(in_clk : in std_logic;
    in_rst : in std_logic;
    in_ram_aktif : in std_logic;
    in_yaz_en : in std_logic;
    in_oku_en : in std_logic;
    in_data_addr : in std_logic_vector(log2_int(RAM_DERINLIGI) - 1 downto 0);
    in_data : in std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    out_data : out std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
   out_data_vld : out std_logic
  );
  end component;
	
  constant CLK_PERIOD : time := 20 ns;
  constant IMGE_SATIR : integer := 256;
  constant IMGE_SUTUN : integer := 256; 
  constant VERI_UZUNLUGU : integer := 8; 
  constant VERI_YOLU_OKUMA : string := "C:\cameraman.txt";
  constant VERI_YOLU_YAZMA : string := "D:\cameraman_sonuc.txt";

  constant AYNALAMA : std_logic_vector(2 downto 0) := "000";
  constant TERS_CEVIRME : std_logic_vector(2 downto 0) := "001";
  constant NEGATIFLEME : std_logic_vector(2 downto 0) := "010";
  constant ESIKLEME : std_logic_vector(2 downto 0) := "011";
  constant PARLAKLIK_ARTIR : std_logic_vector(2 downto 0) := "100";
  constant PARLAKLIK_AZALT : std_logic_vector(2 downto 0) := "101";
  constant KARSITLIK_ARTIR : std_logic_vector(2 downto 0) := "110";
  constant KARSITLIK_AZALT : std_logic_vector(2 downto 0) := "111";
	
  type t_Imge_Isleme  is (RAM_OKUMA, RAM_YAZMA, TAMAM);
  signal r_Imge_Isleme : t_Imge_Isleme := RAM_YAZMA;
	
  signal in_clk : std_logic := '0';
  signal in_rst : std_logic := '0';
  signal in_basla : std_logic := '0';
  signal in_ram_aktif : std_logic := '1';
  signal out_data_vld : std_logic := '0';
  signal out_data : std_logic_vector(7 downto 0) := (others => '0');
  signal in_ram_data : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0'); 
  signal in_ram_data_addr : std_logic_vector(log2_int(IMGE_SATIR * IMGE_SUTUN) - 1 downto 0) := (others => '0');
  signal out_ram_data : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0'); 
  signal out_data_addr : std_logic_vector(log2_int(IMGE_SATIR * IMGE_SUTUN) - 1 downto 0) := (others => '0');
  signal out_ram_data_vld : std_logic := '0';        
  signal in_en : std_logic := '0';
  signal in_yaz_en : std_logic := '0';
  signal in_oku_en : std_logic := '0';        
  signal data_sayac : integer := 0;
	  signal out_data_addr_vld : std_logic := '0';  
	  signal r_imge_isleme_tamam : std_logic := '0';  

	begin
	
  process
  begin
    in_clk <= '1';
    wait for CLK_PERIOD / 2;
    in_clk <= '0';
    wait for CLK_PERIOD / 2;
  end process;  
	
  process
	 begin
	  in_basla <= '1';
	  wait for CLK_PERIOD;
	  in_basla <= '0'; wait;
	end process;     
	
	process(in_clk)
	  file dosya_okuma : text open read_mode is VERI_YOLU_OKUMA;
	  file dosya_yazma : text open write_mode is VERI_YOLU_YAZMA;
   variable satir_okuma : line;
	  variable satir_yazma : line;
	  variable data_okuma : integer;      
	begin
	  if rising_edge(in_clk) then
	      if out_data_vld = '1' then
          write(satir_yazma, conv_integer(out_data)); 
          writeline(dosya_yazma, satir_yazma);                
	      end if;
	      
	      case r_Imge_Isleme is
	          when RAM_YAZMA => 
	              if not endfile(dosya_okuma) then
	                  readline(dosya_okuma, satir_okuma);
	                  read(satir_okuma, data_okuma);
	                  in_ram_data <= conv_std_logic_vector( data_okuma, VERI_UZUNLUGU);
	                  in_ram_data_addr <= conv_std_logic_vector( data_sayac, in_ram_data_addr'length);
	                  in_en <= '0';
	                  in_yaz_en <= '1';
	                  data_sayac <= data_sayac + 1;
	              else
                  r_Imge_Isleme <= RAM_OKUMA; 
                  in_yaz_en <= '0';  
	              end if; 

          when RAM_OKUMA => 
              in_en <= '1';
	              in_ram_data_addr <= out_data_addr; 
	              in_oku_en <= out_data_addr_vld ;
	              if r_imge_isleme_tamam = '1' then
	                  r_Imge_Isleme <= TAMAM; 
	              end if;
	
	          when TAMAM => null;
          when others => NULL;
	      end case;
	  end if;
end process;     
	
	temel_imge_isleme_map : temel_imge_isleme
    generic map(
    IMGE_SATIR => IMGE_SATIR, 
    IMGE_SUTUN => IMGE_SUTUN,
    VERI_UZUNLUGU => VERI_UZUNLUGU       
	)
	port map( 
        in_clk => in_clk,
	    in_rst => in_rst,
	    in_en => in_en,
	    in_basla => in_basla,
        in_islem => KARSITLIK_AZALT,
	    in_data => out_ram_data, 
	    in_data_vld => out_ram_data_vld,
	    out_addr => out_data_addr,
	    out_addr_vld => out_data_addr_vld,  
	    out_data => out_data,
	    out_data_vld => out_data_vld,
	    out_tamam => r_imge_isleme_tamam                
	);   
	
	block_ram_map : block_ram 
	generic map(
	     VERI_UZUNLUGU => VERI_UZUNLUGU,
	     RAM_DERINLIGI => IMGE_SATIR * IMGE_SUTUN
	)
	port map(
	    in_clk => in_clk,
	    in_rst => in_rst,
	    in_ram_aktif => in_ram_aktif,
	    in_yaz_en => in_yaz_en,
	    in_oku_en => in_oku_en,
	    in_data_addr => in_ram_data_addr,
	    in_data => in_ram_data,
	    out_data => out_ram_data,
	    out_data_vld => out_ram_data_vld
  );
end Behavioral;
