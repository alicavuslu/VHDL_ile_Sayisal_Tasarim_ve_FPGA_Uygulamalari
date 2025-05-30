library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity karakter_kaydirma is
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_giris_data : in std_logic_vector(3 downto 0);
    out_disp_sec : out std_logic_vector(7 downto 0);
    out_cikis : out std_logic_vector(7 downto 0)  
  );
end karakter_kaydirma;

architecture Behavioral of karakter_kaydirma is

  type t_display_ekran is array (0 to 15) of std_logic_vector(7 downto 0);
  constant DISP_EKRAN : t_display_ekran := ("10000001", "11001111", "10010010",
    "10000110", "11001100", "10100100", "10100000", "10001111", "10000000", 
    "10000100", "10001000", "11100000", "10110001", "11000010", "10110000", 
    "10111000");
    
  type t_RAM_data is array (0 to 7) of std_logic_vector(3 downto 0);
  signal r_RAM_data : t_RAM_data := (others => (others => '0'));
  
  constant BEKLEME : integer := 3;
   
  signal r_disp_sec : std_logic_vector(7 downto 0) := "11111110";
  signal r_cikis : std_logic_vector(7 downto 0) := (others => '0');
  signal r_sayac_clk : integer := 0;
  signal r_sayac_disp : integer := 0;
  
  function f_kaydir(in_giris : std_logic_vector(3 downto 0); r_RAM_data : t_RAM_data )  
  return t_RAM_data is
    variable v_RAM_data : t_RAM_data;
  begin
    v_RAM_data := r_RAM_data;
    for n_i in 6 downto 0 loop
      v_RAM_data(n_i + 1) := v_RAM_data(n_i);
    end loop;
    v_RAM_data(0) := in_giris;
    return v_RAM_data; 
  end f_kaydir; 

begin

  out_disp_sec <= r_disp_sec;
  out_cikis <= r_cikis;

  process(in_clk, in_rst, in_giris_data)
  begin
    if in_rst = '1' then
        r_RAM_data <= (others => (others => '0'));
        r_sayac_clk <= 0;
    elsif rising_edge(in_clk) then
        if r_sayac_clk = BEKLEME * 100000000 - 1 then
            r_sayac_clk <= 0;
            r_RAM_data <= f_kaydir(in_giris_data, r_RAM_data);
        else
            r_sayac_clk <= r_sayac_clk + 1; 
        end if;
    end if;
  end process;
  
  process(in_clk, in_rst, r_disp_sec)
  begin
    if in_rst = '1' then
      r_cikis <= "00000000";
    elsif rising_edge(in_clk) then
      case r_disp_sec is
        when "11111110" =>
          r_cikis <= DISP_EKRAN(conv_integer(r_RAM_data(0)));
        when "11111101" =>
          r_cikis <= DISP_EKRAN(conv_integer(r_RAM_data(1)));
        when "11111011" =>
          r_cikis <= DISP_EKRAN(conv_integer(r_RAM_data(2)));
        when "11110111" =>
          r_cikis <= DISP_EKRAN(conv_integer(r_RAM_data(3)));
        when "11101111" =>
          r_cikis <= DISP_EKRAN(conv_integer(r_RAM_data(4)));
        when "11011111" =>
          r_cikis <= DISP_EKRAN(conv_integer(r_RAM_data(5)));
        when "10111111" =>
          r_cikis <= DISP_EKRAN(conv_integer(r_RAM_data(6)));
        when "01111111" => 
          r_cikis <= DISP_EKRAN(conv_integer(r_RAM_data(7)));                
        when others =>
          r_cikis <= "00000000";                                                            
      end case;
  end if;
  end process;

  process(in_clk, in_rst)
  begin
    if in_rst = '1' then
      r_disp_sec <= "11111110";
      r_sayac_disp <= 0;
    elsif rising_edge(in_clk) then
      if r_sayac_disp = 10000 then
        r_sayac_disp <= 0;
        r_disp_sec <= r_disp_sec(6 downto 0) & r_disp_sec(7);
      else
        r_sayac_disp <= r_sayac_disp + 1;
      end if;
    end if;
  end process;     
          
end Behavioral;