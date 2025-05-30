library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
	
entity FIFO is
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
end FIFO;
	
architecture Behavioral of FIFO is
	
  type t_FIFO_DATA is array (0 to FIFO_DERINLIGI - 1) of std_logic_vector(VERI_UZUNLUGU - 1 downto 0) ; 
  signal r_FIFO_DATA : t_FIFO_DATA := (others =>(others => '0'));
  signal r_fifo_sayac : integer range -1 to FIFO_DERINLIGI + 1 := 0;
  signal ind_yaz : integer range 0 to FIFO_DERINLIGI - 1 := 0;
  signal ind_oku : integer range 0 to FIFO_DERINLIGI - 1 := 0;
  signal bayrak_dolu  : std_logic := '0';
  signal bayrak_bos : std_logic := '0';
  signal r_data_vld : std_logic := '0';
  signal r_data : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0'); 
	
begin
	
  out_data <= r_data;
  out_data_vld <= r_data_vld;
  out_dolu  <= '1' when r_fifo_sayac = FIFO_DERINLIGI else '0';
  out_bos <= '1' when r_fifo_sayac = 0 else '0';
	  
  bayrak_dolu  <= '1' when r_fifo_sayac = FIFO_DERINLIGI else '0';
  bayrak_bos <= '1' when r_fifo_sayac = 0 else '0';
	
  out_doluyor <= '1' when r_fifo_sayac > FIFO_DOLUYOR else '0';
  out_bosaliyor <= '1' when r_fifo_sayac < FIFO_BOSALIYOR else '0';
	
  process(in_clk, in_rst)
  begin
    if in_rst = '1' then
      r_FIFO_DATA <= (others =>(others => '0'));
      r_fifo_sayac <= 0;
      ind_yaz <= 0;
      ind_oku <= 0;
      r_data_vld <= '0';
      r_data <= (others => '0');
	
    elsif rising_edge(in_clk) then
      if in_yaz = '1' and in_oku = '0' then
        r_fifo_sayac <= r_fifo_sayac + 1;
      elsif in_yaz = '0' and in_yaz = '1' then
        r_fifo_sayac <= r_fifo_sayac - 1;
      end if;      
       
      if in_yaz = '1' and bayrak_dolu = '0' then
        if ind_yaz = FIFO_DERINLIGI - 1 then
          ind_yaz <= 0;
        else
          ind_yaz <= ind_yaz + 1;
        end if;               
      end if; 
      if (in_oku = '1' and bayrak_bos = '0') then
        if ind_oku = FIFO_DERINLIGI - 1 then
          ind_oku <= 0;
        else
          ind_oku <= ind_oku + 1;
        end if;
        r_data <= r_FIFO_DATA(ind_oku);
        r_data_vld <= '1';
       else
        r_data_vld <= '0';
      end if;          
    end if;
    if in_yaz = '1' then
      r_FIFO_DATA(ind_yaz) <= in_data;
    end if;
  end process;
end Behavioral;