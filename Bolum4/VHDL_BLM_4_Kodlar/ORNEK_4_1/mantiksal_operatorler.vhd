library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
entity mantiksal_operatorler is
  Port ( 
    in_giris_1 : in std_logic;
    in_giris_2 : in std_logic;
    out_cikis_and : out std_logic;
    out_cikis_or : out std_logic;
    out_cikis_nand : out std_logic;
    out_cikis_nor : out std_logic;    
    out_cikis_xor : out std_logic;
    out_cikis_xnor : out std_logic
  );
end mantiksal_operatorler;

architecture Behavioral of mantiksal_operatorler is
	
begin
	
  out_cikis_and   <= in_giris_1 and in_giris_2;
  out_cikis_or    <= in_giris_1 or in_giris_2;
  out_cikis_nand  <= in_giris_1 nand in_giris_2;
  out_cikis_nor   <= in_giris_1 nor in_giris_2;    
  out_cikis_xor   <= in_giris_1 xor in_giris_2;
  out_cikis_xnor  <= in_giris_1 xnor in_giris_2;
	
end Behavioral;