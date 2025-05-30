library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
use work.ornekler_paket.all;	
use std.textio.ALL;

entity tb_konvolusyon_signal is
end tb_konvolusyon_signal;
	
architecture Behavioral of tb_konvolusyon_signal is

  component konvolusyon_sinyal is
  Generic(
    VERI_UZUNLUGU : integer := 24;
    KATSAYI : integer := 5;
    KATSAYI_UZUNLUGU : integer := 8;
    KATSAYI_CARPIM : integer := 3
  );
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_en : in std_logic;
    in_katsayi_vld : in std_logic;
    in_katsayi_addr : in std_logic_vector(log2_int(KATSAYI)  downto 0);
    in_katsayi_data : in std_logic_vector(KATSAYI_UZUNLUGU - 1 downto 0);
    in_data : in std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    in_data_vld : in std_logic;
    out_data : out std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    out_data_vld : out std_logic;
    out_calisiyor : out std_logic    
  );
  end component;
	
  constant CLK_PERIOD : time := 10 ns;
  constant ORNEKLEME_PERIOD : time := 10 us;
  constant VERI_YOLU : string := "C:\sin.txt";
  constant VERI_UZUNLUGU : integer := 24;
  constant KATSAYI : integer := 17;
  constant KATSAYI_UZUNLUGU : integer := 8;
  constant KATSAYI_CARPIM : integer := 7;    
	  
  signal in_clk : std_logic  := '0';
  signal ornekleme_clk : std_logic := '0';
  signal ornek_data : std_logic_vector(23 downto 0) := (others => '0');
  signal clk_domain : std_logic_vector(3 downto 0) := (others => '0');
  signal son_data : std_logic := '0';
  signal in_rst : std_logic := '0';
  signal in_en : std_logic := '0';
  signal in_katsayi_vld : std_logic := '0';
  signal in_katsayi_addr : std_logic_vector(log2_int(KATSAYI) downto 0) := (others => '0');
  signal in_katsayi_data : std_logic_vector(KATSAYI_UZUNLUGU - 1 downto 0) := (others => '0');
  signal in_data : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0');
  signal in_data_vld : std_logic := '0';
  signal out_data : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0');
  signal out_data_vld : std_logic := '0';
  signal out_calisiyor : std_logic := '0'; 
	 
  type t_Katsayi_Kontrol is  (BOSTA, YUKLE);
  signal r_Katsayi_Kontrol : t_Katsayi_Kontrol := BOSTA;
  
  type t_Filtre_Katsayi is array (0 to KATSAYI - 1) of integer;
  signal r_Filtre_Katsayi : t_Filtre_Katsayi := (1, 2, 3, 5, 8, 10, 13, 14, 15, 14, 13, 10, 8, 5, 3, 2, 1);
	
  signal katsayi_yukle : std_logic := '0';
  signal n_i : integer := 0;
	
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
    ornekleme_clk <= '1';
    wait for ORNEKLEME_PERIOD / 2;
    ornekleme_clk <= '0';
    wait for ORNEKLEME_PERIOD / 2;		
  end process;
	
  process
  begin
    katsayi_yukle <= '0';
    wait for CLK_PERIOD * 2;
    katsayi_yukle <= '1';
    wait for CLK_PERIOD ;
    katsayi_yukle <= '0';
    wait;
  end process;	
	
  process (ornekleme_clk)
    file dosya : text open read_mode is VERI_YOLU ;
    variable satir : line;
    variable data : integer;
  begin  
    if rising_edge(ornekleme_clk) then
      if not(endfile(dosya)) then
        readline(dosya, satir);
        read(satir, data);
        ornek_data <= conv_std_logic_vector(data, 24) ;                
        son_data <= '0';
      else
        ornek_data <= conv_std_logic_vector(0, 24) ;
        son_data <= '1';
      end if;                    
    end if;
  end process; 
	
  process(in_clk)
  begin
    if rising_edge(in_clk) then
      clk_domain <= clk_domain(2 downto 0) & ornekleme_clk; 
    end if;
  end process;
	
  process (in_clk) 
  begin  
    if rising_edge(in_clk) then
      if son_data = '0' and clk_domain(3 downto 2) = "01" then
        in_data_vld <= '1' ;
        in_data <= ornek_data ;
      else
        in_data_vld <= '0' ;
        in_data <= (others=>'0') ;
      end if;                    
    end if;
  end process; 
	
  process(in_clk)
  begin
	if rising_edge(in_clk) then	
      in_katsayi_vld <= '0';
      case r_Katsayi_Kontrol is
        when BOSTA => 
          if katsayi_yukle = '1' then
            r_Katsayi_Kontrol <= YUKLE;
          end if;
	    
        when YUKLE => 
          in_katsayi_vld <= '1';
          in_katsayi_addr <= conv_std_logic_vector(n_i, log2_int(KATSAYI) + 1);
          in_katsayi_data <= conv_std_logic_vector( r_Filtre_Katsayi(n_i), KATSAYI_UZUNLUGU);
          if n_i = KATSAYI - 1 then
            r_Katsayi_Kontrol <= BOSTA;
            n_i <= 0; 
            in_en <= '1';
          else
            n_i <= n_i + 1;
          end if;
	    when others => NULL;
	    end case;
      end if;
    end process;		
	
  konvolusyon_sinyal_map :  konvolusyon_sinyal
  Generic map(
    VERI_UZUNLUGU => VERI_UZUNLUGU,
    KATSAYI => KATSAYI,
    KATSAYI_UZUNLUGU => KATSAYI_UZUNLUGU,
   	KATSAYI_CARPIM => KATSAYI_CARPIM
	)
	Port map( 
	in_clk => in_clk,
	in_rst => in_rst,
    in_en => in_en,
  in_katsayi_vld => in_katsayi_vld,
  in_katsayi_addr => in_katsayi_addr,
  in_katsayi_data => in_katsayi_data,
  in_data => in_data,
  in_data_vld => in_data_vld,
  out_data => out_data,
  out_data_vld => out_data_vld,
  out_calisiyor => out_calisiyor  
  );
end Behavioral;