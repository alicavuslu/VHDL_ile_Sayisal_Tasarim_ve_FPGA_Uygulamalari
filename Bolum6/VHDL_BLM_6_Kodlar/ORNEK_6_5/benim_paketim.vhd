library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
package benim_paketim is

  signal r_giris_1 : std_logic := '0';
  signal r_giris_2 : std_logic := '0';
  constant VERI_UZUNLUGU : integer := 6;
  signal in_giris_1 : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0');
  signal in_giris_2 : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0');

  type t_Kelime is array (9 downto 0) of std_logic;
  signal r_Kelime_1 : t_kelime := (others => '0');
  signal r_Kelime_2 : t_kelime := (others => '0');
	
  function buyuk_bul(in_Kelime_1, in_Kelime_2 : t_Kelime) return t_Kelime;

  component generic_toplayici
  Generic(
    n_bit : integer := 8    
  );
  Port (  
    in_giris_elde : in std_logic;
    in_giris_1 : in std_logic_vector(n_bit - 1 downto 0);
    in_giris_2 : in std_logic_vector(n_bit - 1 downto 0);
    out_cikis : out std_logic_vector(n_bit - 1 downto 0);
    out_cikis_elde : out std_logic      
  );
  end component;
	
end benim_paketim;

package body benim_paketim is
  function buyuk_bul(in_Kelime_1, in_Kelime_2 : t_Kelime) return t_Kelime is
    variable v_buyuk : t_Kelime;
  begin
    v_buyuk := in_Kelime_1;
    if v_buyuk < in_Kelime_2 then
      v_buyuk := in_Kelime_2;
    end if;
    return v_buyuk;
  end buyuk_bul;
end benim_paketim;