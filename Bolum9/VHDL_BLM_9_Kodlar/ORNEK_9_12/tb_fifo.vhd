library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use std.textio.ALL;

entity tb_fifo is
end tb_fifo;
	
architecture Behavioral of tb_fifo is
  component FIFO
  Generic(
    FIFO_DERINLIGI : integer := 250;
    VERI_UZUNLUGU : integer := 24;
    FIFO_DOLUYOR : integer := 250;
    FIFO_BOSALIYOR : integer := 10
  );
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_yaz : in std_logic;
    in_oku : in std_logic;
    in_data : in std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    out_doluyor : out std_logic;
    out_dolu : out std_logic;
    out_data : out std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    out_data_vld : out std_logic;
    out_bosaliyor : out std_logic;
    out_bos : out std_logic
  );         
  end component;
	
  constant CLK_PERIOD : time := 150 ns;
  constant FIFO_DERINLIGI : integer := 250;
  constant VERI_UZUNLUGU : integer := 24;
  constant FIFO_DOLUYOR : integer := 250;
  constant FIFO_BOSALIYOR : integer := 10;
  constant VERI_YOLU : string := "C:\sin.txt";
	
  signal in_clk : std_logic := '0';
  signal in_rst : std_logic := '0'; 
  signal in_oku : std_logic := '0';
  signal in_yaz : std_logic := '0'; 
  signal in_data : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0'); 
  signal out_doluyor : std_logic := '0';
  signal out_dolu : std_logic := '0';
  signal out_data : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0');
  signal out_data_vld : std_logic := '0';
  signal out_bosaliyor : std_logic := '0';
  signal out_bos : std_logic := '0';    
  signal sayac : integer := 0;
	
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
      if (not endfile(dosya)) then
        readline(dosya, satir);
        read(satir, data);
        in_data <= conv_std_logic_vector(data, VERI_UZUNLUGU);
        in_yaz <= '1';
        sayac <= sayac + 1;
        if sayac > 100 then
          in_oku <= '1';
        end if;
      end if;
    end if;
  end process;    
	
  FIFO_map : FIFO
  generic map(
    FIFO_DERINLIGI => FIFO_DERINLIGI,
    VERI_UZUNLUGU => VERI_UZUNLUGU,
    FIFO_DOLUYOR => FIFO_DOLUYOR,
    FIFO_BOSALIYOR => FIFO_BOSALIYOR  )
  port map(
    in_clk => in_clk,
    in_rst => in_rst,  
    in_yaz => in_yaz,
    in_oku => in_oku,
    in_data => in_data,
    out_doluyor => out_doluyor,
    out_dolu => out_dolu,
    out_data => out_data,
    out_data_vld => out_data_vld,
    out_bosaliyor => out_bosaliyor,
    out_bos => out_bos     
  );
end Behavioral;
