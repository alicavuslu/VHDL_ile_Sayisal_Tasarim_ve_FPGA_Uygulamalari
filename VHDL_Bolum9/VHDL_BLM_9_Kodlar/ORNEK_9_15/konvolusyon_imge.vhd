library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.konvolusyon_imge_paket.all;

entity konvolusyon_imge is
  port( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_en  : in std_logic;
    in_basla : in std_logic;
    in_data : in std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    in_data_vld : in std_logic;
    in_kernel : in std_logic_vector(2 downto 0);
    out_addr : out std_logic_vector(log2_int(IMGE_SATIR * IMGE_SUTUN) - 1 downto 0);
    out_addr_vld : out std_logic;
    out_data : out std_logic_vector(7 downto 0);
    out_data_vld : out std_logic;
    out_tamam : out std_logic                
  );
end konvolusyon_imge;

architecture Behavioral of konvolusyon_imge is

  type t_Konvolusyon_Imge is (BOSTA, RAMDAN_OKU, OKUMA_BEKLE, MATRIS_KAYDIR, KONV_HESAPLA, SAYAC_KONT, TAMAM );  
  signal r_Konvolusyon_Imge : t_Konvolusyon_Imge := RAMDAN_OKU; 

  signal VERI : m_VERI_MATRISI := (others => (others => (others => '0')));   
  signal Tek_Sutun : v_VERI_DIZISI := (others => (others => '0'));       

  signal n_i : integer := 0;
  signal n_j : integer := 0;
  signal n_k : integer := 0;
  signal n_s : integer := 0;
  
  signal r_addr : std_logic_vector(log2_int(IMGE_SATIR * IMGE_SUTUN) - 1 downto 0) := (others => '0');    
  signal r_addr_vld : std_logic := '0';
  signal r_data : std_logic_vector(7 downto 0) := (others => '0');   
  signal r_data_vld : std_logic := '0';
  signal r_bayrak_oku : std_logic := '0';
  signal r_kenar_bulma_tmm : std_logic := '0';   
  signal r_tamam : std_logic := '0';
   
begin

  out_addr <= r_addr;
  out_addr_vld <= r_addr_vld;
  out_data <= r_data;
  out_data_vld <= r_data_vld;
  out_tamam <= r_tamam;

  process(in_clk, in_rst, in_en)
  begin
    if in_rst = '1' then
      Tek_Sutun <= (others => (others => '0'));  
      n_s <= 0;
      r_bayrak_oku <= '0';
   elsif rising_edge(in_clk) then
      if in_en = '1' then
        if in_data_vld = '1' then
          Tek_Sutun(n_s) <= in_data;
          n_s <= n_s + 1;
          if n_s = 2 then
            n_s <= 0; 
            r_bayrak_oku <= '1';
          end if;
        else
          r_bayrak_oku <= '0'; 
        end if;
            
      end if;
      
    end if;
  end process;
  
  process(in_clk, in_rst)
  begin
    if in_rst = '1' then
      VERI <= (others => (others => (others => '0'))); 
      r_Konvolusyon_Imge <= BOSTA;
      n_i <= 0;
      n_j <= 0;  
      r_addr <= (others => '0');
      r_addr_vld <= '0';
      r_data <= (others => '0');
      r_data_vld <= '0'; 
      r_tamam <= '0';  
      n_k <= 0;  
      
    elsif rising_edge(in_clk) then
      if in_en = '1' then
        r_addr_vld <= '0';
        r_data_vld <= '0';
        r_tamam <= '0';   
        case r_Konvolusyon_Imge is
          when BOSTA => 
            if in_basla = '1' then
              r_Konvolusyon_Imge <= RAMDAN_OKU;
            end if;

          when RAMDAN_OKU =>
            r_addr <= conv_std_logic_vector((n_i + n_k) * IMGE_SUTUN + n_j,  r_addr'length);
            r_addr_vld <= '1';
            n_k <= n_k + 1;
            if n_k = 2 then
              r_Konvolusyon_Imge <= OKUMA_BEKLE;  
            end if;
             
          when OKUMA_BEKLE =>  
            n_k <= 0;
            if r_bayrak_oku = '1' then
              r_Konvolusyon_Imge <= MATRIS_KAYDIR;  
            end if;
          when MATRIS_KAYDIR =>
            n_j <= n_j + 1;
            VERI <= f_Matris_Kaydýr(VERI, Tek_Sutun);
            if n_j < 2 then
              r_Konvolusyon_Imge <= RAMDAN_OKU;    
            else
              r_Konvolusyon_Imge <= KONV_HESAPLA;  
            end if;
            
          when KONV_HESAPLA => 
            r_data <=  f_Konvolusyon_Imge(VERI, r_KERNEL_LISTE(conv_integer(in_kernel)));
            r_data_vld <= '1'; 
            r_Konvolusyon_Imge <= SAYAC_KONT;
            if n_j = IMGE_SUTUN then
              n_i <= n_i + 1;
              n_j <= 0;
            end if;
    
          when SAYAC_KONT => 
            r_data_vld <= '0';
            if n_i < IMGE_SATIR - 2 then
              r_Konvolusyon_Imge <= RAMDAN_OKU;
            else
              n_i <= 0;
              r_Konvolusyon_Imge <= TAMAM;                               
            end if;
            
          when TAMAM =>
            r_tamam <= '1';  
            r_Konvolusyon_Imge <= BOSTA;
          when others => NULL;                
        end case;
      end if;
    end if;        
  end process;
end Behavioral;
