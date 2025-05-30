library IEEE;
use IEEE.STD_LOGIC_1164.all;
	
entity port_map_for_if_generate is
  Port ( 
    in_giris_1 : in std_logic_vector(7 downto 0);
    in_giris_2 : in std_logic_vector(7 downto 0);
    out_cikis_elde : out std_logic;
    out_cikis : out std_logic_vector(7 downto 0)
  );
end port_map_for_if_generate;
	
architecture Behavioral of port_map_for_if_generate is
	
  component yari_toplayici
  port(
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    out_cikis : out std_logic;
    out_cikis_elde : out std_logic
  );
  end component;
	
  component tam_toplayici
    port(
      in_giris_elde : in std_logic;
      in_giris_1 : in std_logic;
      in_giris_2 : in std_logic;
      out_cikis : out std_logic;
      out_cikis_elde : out std_logic
    );
  end component;

  signal r_toplam : std_logic_vector(8 downto 1);
	
begin
	
  for_kontrol : for n_i in 0 to 7 generate
    if_kontrol_EAB : if n_i = 0 generate 
      yari_toplayici_map : yari_toplayici
      port map(
        in_giris_1 => in_giris_1(n_i),
        in_giris_2 => in_giris_2(n_i),
        out_cikis => out_cikis(n_i),
        out_cikis_elde => r_toplam(n_i + 1)              
      );                                
    end generate if_kontrol_EAB;
	
    if_kontrol_DB : if n_i > 0 generate
      tam_toplayici_map : tam_toplayici
      port map(
        in_giris_elde => r_toplam(n_i),
        in_giris_1 => in_giris_1(n_i),
        in_giris_2 => in_giris_2(n_i),
        out_cikis => out_cikis(n_i),
        out_cikis_elde => r_toplam(n_i + 1)              
      );    
    end generate if_kontrol_DB;       
  end generate for_kontrol;

  out_cikis_elde <= r_toplam(8);
	
end Behavioral;