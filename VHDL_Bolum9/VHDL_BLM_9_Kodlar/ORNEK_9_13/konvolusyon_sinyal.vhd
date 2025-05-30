library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
use work.ornekler_paket.all;	
	
entity konvolusyon_sinyal is
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
    in_katsayi_addr : in std_logic_vector(log2_int(KATSAYI) downto 0);
    in_katsayi_data : in std_logic_vector(KATSAYI_UZUNLUGU - 1 downto 0);
    in_data : in std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    in_data_vld : in std_logic;
    out_data : out std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
    out_data_vld : out std_logic;
    out_calisiyor : out std_logic    
  );
end konvolusyon_sinyal;
	
architecture Behavioral of konvolusyon_sinyal is
	
  type t_Kayma_Ctrl is (BOSTA, DATA_KAYDIR);
  signal r_Kayma_Ctrl : t_Kayma_Ctrl := BOSTA;
	
  type t_Filtre_Hesap is (BOSTA, HESAPLA, TAMAM);
  signal r_Filtre_Hesap : t_Filtre_Hesap := BOSTA;
	
  type t_katsayi_bellek is array (0 to KATSAYI - 1 ) of std_logic_vector(KATSAYI_UZUNLUGU - 1 downto 0);
  signal r_katsayi_bellek : t_katsayi_bellek := (others => (others => '0')); 
	
  type t_data_bellek is array (0 to KATSAYI - 1 ) of std_logic_vector(VERI_UZUNLUGU - 1 downto 0);
  signal r_data_bellek : t_data_bellek := (others => (others => '0')); 
	
  function f_Bellek_Kaydir(r_data_bellek : t_data_bellek; in_data : std_logic_vector(VERI_UZUNLUGU - 1 downto 0)) return t_data_bellek is
    variable v_data_bellek : t_data_bellek;
  begin
    v_data_bellek := r_data_bellek;
    for n_i in KATSAYI - 2 downto 0 loop
        v_data_bellek(n_i + 1) := v_data_bellek(n_i); 
    end loop;
    v_data_bellek(0) := in_data; 
    return v_data_bellek;        
  end f_Bellek_Kaydir;
	
  signal r_hesap_basla : std_logic := '0';
  signal r_data : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0');
  signal r_toplam : std_logic_vector(VERI_UZUNLUGU + KATSAYI_UZUNLUGU + log2_int(KATSAYI) - 1 downto 0) := (others => '0');
  signal r_data_out : std_logic_vector(VERI_UZUNLUGU - 1 downto 0) := (others => '0');
  signal r_data_out_vld : std_logic := '0';
  signal r_calisiyor : std_logic := '0';
  signal n_i : integer := 0;
	
begin
	
  out_data <= r_data_out;
  out_data_vld <= r_data_out_vld;
  out_calisiyor <= r_calisiyor;

  process(in_clk, in_rst)
  begin
    if in_rst = '1' then
      r_katsayi_bellek <= (others => (others => '0'));
    elsif rising_edge(in_clk) then
      if in_katsayi_vld = '1' then
        r_katsayi_bellek(conv_integer(in_katsayi_addr)) <= in_katsayi_data;                
      end if;
    end if;
    end process;
	
  process(in_clk, in_rst)
  begin
    if in_rst = '1' then
      r_Kayma_Ctrl <= BOSTA;
      r_data_bellek <= (others => (others => '0')); 
      r_hesap_basla <= '0';
      r_data <= (others => '0');

    elsif rising_edge(in_clk) then
      r_hesap_basla <= '0';
      case r_Kayma_Ctrl is
        when BOSTA => 
          if in_data_vld = '1' then
            r_data <= in_data;
            r_Kayma_Ctrl <= DATA_KAYDIR;
          end if;
	
        when DATA_KAYDIR => 
          r_data_bellek <= f_Bellek_Kaydir(r_data_bellek, r_data);
          r_Kayma_Ctrl <= BOSTA; 
          r_hesap_basla <= '1';
        
     when others => NULL;    
      end case;
	  end if;
	end process;
	
	process(in_clk, in_rst)
	begin
    if in_rst = '1' then
        r_Filtre_Hesap <= BOSTA;
        r_toplam <= (others => '0');
        r_data_out_vld <= '0';
        r_data_out <= (others => '0');
        r_calisiyor <= '0';
        n_i <= 0; 
	
	elsif rising_edge(in_clk) then
        r_data_out_vld <= '0';
        case r_Filtre_Hesap is
            when BOSTA =>
                r_calisiyor <= '0';
                if r_hesap_basla = '1' and in_en = '1' then
                    r_Filtre_Hesap <= HESAPLA;
                    r_calisiyor <= '1';
                end if;
	
            when HESAPLA =>
                r_toplam <= r_toplam + sxt((r_data_bellek(n_i)) * (r_katsayi_bellek(KATSAYI - 1 - n_i)), r_toplam'length);
                n_i <= n_i + 1;
                if n_i = KATSAYI - 1 then
                    n_i <= 0;
                    r_Filtre_Hesap <= TAMAM; 
                end if;
	
            when TAMAM =>					
                r_toplam <= (others => '0');
                r_calisiyor <= '0';
                r_data_out_vld <= '1';
                r_data_out <= r_toplam(KATSAYI_CARPIM + VERI_UZUNLUGU - 1 downto KATSAYI_CARPIM);
                r_Filtre_Hesap <= BOSTA; 
	
            when others => NULL;
        end case;
    end if;
end process;	

end Behavioral;