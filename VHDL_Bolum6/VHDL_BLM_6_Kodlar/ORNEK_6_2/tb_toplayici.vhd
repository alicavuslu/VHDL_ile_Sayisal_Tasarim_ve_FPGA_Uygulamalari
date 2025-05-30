library IEEE;
use IEEE.STD_LOGIC_1164.all;
	
entity tb_toplayici is
end tb_toplayici;
	
architecture Behavioral of tb_toplayici is

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
  
  signal in_giris4_1 : std_logic_vector(3 downto 0) := X"2"; 
  signal in_giris4_2 : std_logic_vector(3 downto 0) := X"1"; 
  signal out_cikis4 : std_logic_vector(3 downto 0);
  Signal out_cikis_elde4 : std_logic;

  signal in_giris8_1 : std_logic_vector(7 downto 0) := X"12"; 
  signal in_giris8_2 : std_logic_vector(7 downto 0) := X"22";
  signal out_cikis8 : std_logic_vector(7 downto 0);
    
begin
	
  generic_toplayici_4_bit : generic_toplayici
  Generic map( n_bit => 4 )
  Port map (  
    in_giris_elde => '0',
    in_giris_1 =>in_giris4_1,
    in_giris_2 => in_giris4_2,
    out_cikis => out_cikis4,
    out_cikis_elde => out_cikis_elde4      
  );   
	
  generic_toplayici_8_bit : generic_toplayici
  Port map (  
    in_giris_elde => '0',
    in_giris_1 => in_giris8_1,
    in_giris_2 => in_giris8_2,
    out_cikis => out_cikis8,
    out_cikis_elde => open      
  );
	
end Behavioral;