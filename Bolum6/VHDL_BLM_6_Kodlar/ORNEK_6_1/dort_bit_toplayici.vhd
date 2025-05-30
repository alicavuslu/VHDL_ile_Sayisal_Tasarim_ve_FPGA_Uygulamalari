library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dort_bit_toplayici is
  Port( 
    in_giris_elde : in std_logic;
    in_giris_1 : in std_logic_vector(3 downto 0);
    in_giris_2 : in std_logic_vector(3 downto 0);
    out_cikis : out std_logic_vector(3 downto 0);
    out_cikis_elde : out std_logic
  );
end dort_bit_toplayici;
	
architecture Behavioral of dort_bit_toplayici is
	
  component tam_toplayici
  Port ( 
    in_giris_elde : in std_logic;
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    out_cikis : out std_logic;
    out_cikis_elde : out std_logic
  );    
  end component;
	
  signal r_elde : std_logic_vector(1 to 3) ;

begin
	
  adim_0: tam_toplayici port map (in_giris_elde, in_giris_1(0),
          in_giris_2(0), out_cikis(0), r_elde(1) ) ;
  adim_1: tam_toplayici port map (r_elde(1), in_giris_1(1),
          in_giris_2(1), out_cikis(1), r_elde(2) ) ;
  adim_2: tam_toplayici port map (r_elde(2), in_giris_1(2),
          in_giris_2(2), out_cikis(2), r_elde(3) ) ;
  adim_3: tam_toplayici port map (
          in_giris_elde => r_elde(3), 
          in_giris_1 => in_giris_1(3), 
          in_giris_2 => in_giris_2(3), 
          out_cikis => out_cikis(3), 
          out_cikis_elde => out_cikis_elde) ;
	
end Behavioral;