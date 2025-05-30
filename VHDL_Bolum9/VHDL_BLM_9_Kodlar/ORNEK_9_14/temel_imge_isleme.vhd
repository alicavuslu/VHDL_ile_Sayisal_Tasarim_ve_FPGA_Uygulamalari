library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.ornekler_paket.all;

entity temel_imge_isleme is
  generic(
    IMGE_SATIR : integer := 8;
    IMGE_SUTUN : integer := 8;
    VERI_UZUNLUGU : integer := 24        
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
end temel_imge_isleme;
	
architecture Behavioral of temel_imge_isleme is
	
  constant AYNALAMA : std_logic_vector(2 downto 0) := "000";
  constant TERS_CEVIRME : std_logic_vector(2 downto 0) := "001";
  constant NEGATIFLEME : std_logic_vector(2 downto 0) := "010";
  constant ESIKLEME : std_logic_vector(2 downto 0) := "011";
  constant PARLAKLIK_ARTIR : std_logic_vector(2 downto 0) := "100";
  constant PARLAKLIK_AZALT : std_logic_vector(2 downto 0) := "101";
  constant KARSITLIK_ARTIR : std_logic_vector(2 downto 0) := "110";
  constant KARSITLIK_AZALT : std_logic_vector(2 downto 0) := "111";
	
  type t_Imge_Isleme is (BOSTA, RAMDAN_OKU, OKUMA_BEKLE, ISLEM_YAP, SAYAC_KONT, TAMAM );  
  signal r_Imge_Isleme : t_Imge_Isleme := RAMDAN_OKU; 
  signal n_i : integer := 0;
  signal n_j : integer := 0;
  signal r_addr : std_logic_vector(log2_int(IMGE_SATIR * IMGE_SUTUN) - 1 downto 0) := (others => '0');    
  signal r_addr_vld : std_logic := '0';
  signal r_data : std_logic_vector(7 downto 0) := (others => '0');   
  signal r_data_vld : std_logic := '0';
  signal r_tamam : std_logic := '0';
	
begin
	    
  out_addr <= r_addr;
  out_addr_vld <= r_addr_vld;
  out_data <= r_data;
  out_data_vld <= r_data_vld;
  out_tamam <= r_tamam;
	
  process(in_clk, in_rst)
  begin
    if in_rst = '1' then
      r_Imge_Isleme <= BOSTA;
      n_i <= 0;
      n_j <= 0;  
      r_addr <= (others => '0');
      r_addr_vld <= '0';
      r_data <= (others => '0');
      r_data_vld <= '0'; 
      r_tamam <= '0';
	
    elsif rising_edge(in_clk) then
      if in_en = '1' then
        r_data_vld <= '0';
        r_addr_vld <= '0'; 
        r_tamam <= '0';
       
        case r_Imge_Isleme is
          when BOSTA => 
            if in_basla = '1' then
              r_Imge_Isleme <= RAMDAN_OKU;
            end if;
	             
          when RAMDAN_OKU =>                        
            if in_islem = AYNALAMA then
              r_addr <= conv_std_logic_vector(n_i * IMGE_SUTUN + (IMGE_SUTUN - 1 - n_j) ,  r_addr'length);
            elsif in_islem = TERS_CEVIRME then
              r_addr <= conv_std_logic_vector((IMGE_SATIR - 1 -n_i) * IMGE_SUTUN +  n_j ,  r_addr'length);
            elsif in_islem = NEGATIFLEME or in_islem = ESIKLEME or 
                in_islem = PARLAKLIK_ARTIR or in_islem = PARLAKLIK_AZALT or
                in_islem = KARSITLIK_ARTIR or in_islem = KARSITLIK_AZALT then
              r_addr<= conv_std_logic_vector(n_i * IMGE_SUTUN +  n_j ,  r_addr'length);
            end if;
            r_addr_vld <= '1';
            r_Imge_Isleme <= OKUMA_BEKLE;  

          when OKUMA_BEKLE =>  
            if in_data_vld = '1' then
              r_data <= in_data;
              r_Imge_Isleme <= ISLEM_YAP;                          
            end if;
          when ISLEM_YAP =>
            if in_islem = AYNALAMA or in_islem = TERS_CEVIRME then
              r_data <= r_data;
            elsif in_islem = NEGATIFLEME then
              r_data <= 255 - r_data;
	        elsif in_islem = ESIKLEME then
              if r_data > 128 then
                r_data <= conv_std_logic_vector(255, r_data'length);
	          else
                r_data <= (others => '0');
	          end if;
            elsif in_islem = PARLAKLIK_ARTIR then
	          if r_data > 210 then
	            r_data <= conv_std_logic_vector(255, r_data'length);
	          else
	            r_data <= r_data + 45;
	          end if;
	        elsif in_islem = PARLAKLIK_AZALT then
	          if r_data < 45 then
	            r_data <= conv_std_logic_vector(0, r_data'length);
	          else
                r_data <= r_data - 45;
              end if;    
            elsif in_islem = KARSITLIK_ARTIR then
              if r_data > 128 then
                r_data <= conv_std_logic_vector(255, r_data'length);
              else
                r_data <= r_data(6 downto 0) & '0';
              end if;
            elsif in_islem = KARSITLIK_AZALT then
              r_data <= '0' & r_data(7 downto 1);     
            end if;
            r_data_vld <= '1'; 
            r_Imge_Isleme <= SAYAC_KONT;
          when SAYAC_KONT =>                         
            if n_j = IMGE_SUTUN - 1 then                            
              n_j <= 0;
              if n_i = IMGE_SATIR - 1 then
                n_i <= 0;
                r_Imge_Isleme <= TAMAM;  
              else
                n_i <= n_i + 1;
                r_Imge_Isleme <= RAMDAN_OKU;
              end if;
            else
              n_j <= n_j + 1;
              r_Imge_Isleme <= RAMDAN_OKU;
            end if;                    
          when TAMAM =>       
            r_tamam <= '1';                
            r_Imge_Isleme <= BOSTA;
          when others => NULL;                
        end case;
      end if;
    end if;        
  end process;
end Behavioral;
