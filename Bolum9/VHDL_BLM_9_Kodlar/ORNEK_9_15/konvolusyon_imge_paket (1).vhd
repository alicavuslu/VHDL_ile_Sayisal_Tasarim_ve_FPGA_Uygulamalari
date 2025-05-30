library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package konvolusyon_imge_paket is
  
  constant IMGE_SATIR : integer := 256;
  constant IMGE_SUTUN : integer := 256;
  constant VERI_UZUNLUGU : integer := 8;
   
  type v_VERI_DIZISI is array (0 to 2) of std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
  type m_VERI_MATRISI is array (0 to 2) of v_VERI_DIZISI;
    
  type v_KERNEL_DIZISI is array (0 to 2) of integer;
  type m_KERNEL_MATRISI is array (0 to 2) of v_KERNEL_DIZISI;   
  
  type t_KERNEL_LISTE is array (0 to 7) of m_KERNEL_MATRISI;
  constant r_KERNEL_LISTE : t_KERNEL_LISTE := 
          (((1, 2, 1), (0, 0, 0), (-1, -2, -1)),
           ((1, 0, -1), (2, 0, -2), (1, 0, -1)),
           ((1, 1, 1), (0, 0, 0), (-1, -1, -1)),
           ((1, 0, -1), (2, 0, -2), (1, 0, -1)),
           ((0, 0, 0), (0, 1, 0), (0, 0, -1)),
           ((0, 1, 0), (1, 0, 1), (0, 1, 0)),
           ((-1, -1, -1), (-1, 8, -1), (-1, -1, -1)),
           ((1, 2, 1), (2, 4, 2), (1, 2, 1)));                                             
                                                 
  constant YATAY_SOBEL : std_logic_vector(2 downto 0) := "000";    
  constant DIKEY_SOBEL : std_logic_vector(2 downto 0) := "001"; 
  constant YATAY_PREWIT : std_logic_vector(2 downto 0) := "010"; 
  constant DIKEY_PREWIT : std_logic_vector(2 downto 0) := "011";  
  constant KAYDIR_CIKART : std_logic_vector(2 downto 0) := "100";   
  constant ALCAK_GECIREN : std_logic_vector(2 downto 0) := "101";     
  constant YUKSEK_GECIREN : std_logic_vector(2 downto 0) := "110";  
  constant GAUSS : std_logic_vector(2 downto 0) := "111";  
  
  function log2_int(in_giris : integer) return integer;
  function f_Matris_Kaydýr(Kernel : m_VERI_MATRISI; Tek_Sutun : v_VERI_DIZISI) return m_VERI_MATRISI;
  function f_Konvolusyon_Imge(VERI : m_VERI_MATRISI; KERNEL : m_KERNEL_MATRISI) return std_logic_vector;

end konvolusyon_imge_paket;
	
package body konvolusyon_imge_paket is

  function f_Konvolusyon_Imge(VERI : m_VERI_MATRISI; KERNEL : m_KERNEL_MATRISI) return std_logic_vector is
    variable Toplam : integer;
  begin
    Toplam := 0;
    for n_i in 0 to 2 loop
      for n_j in 0 to 2 loop
        Toplam := Toplam +  conv_integer(VERI(n_i)(n_j)) * KERNEL(2 - n_i)(2 - n_j);  
      end loop;
    end loop;
    if Toplam > 255 then
      Toplam := 255;
    elsif Toplam < 0 then
      Toplam := 0;
    end if;
    return conv_std_logic_vector(Toplam, 8);        
  end f_Konvolusyon_Imge;

  function f_Matris_Kaydýr(Kernel : m_VERI_MATRISI; Tek_Sutun : v_VERI_DIZISI) return m_VERI_MATRISI is
    variable Kernel_v : m_VERI_MATRISI;
    variable Tek_Sutun_v : v_VERI_DIZISI;
  begin
    Kernel_v := Kernel;
    Tek_Sutun_v := Tek_Sutun;        
    for n_j in 0 to 1 loop
      for n_i in 0 to 2 loop
        Kernel_v(n_i)(n_j) := Kernel_v(n_i)(n_j + 1); 
      end loop;
    end loop;
    for n_j in 0 to 2 loop
      Kernel_v(n_j)(2) := Tek_Sutun_v(n_j); 
    end loop;
    return Kernel_v;        
  end f_Matris_Kaydýr;   

  function log2_int(in_giris : integer) return integer is
    variable sonuc : integer;
  begin
    for n_i in 0 to 31 loop
      if (in_giris <= (2 ** n_i)) then
        sonuc := n_i;
        exit;
      end if;
    end loop;
    return sonuc;
  end function;
end package body;
