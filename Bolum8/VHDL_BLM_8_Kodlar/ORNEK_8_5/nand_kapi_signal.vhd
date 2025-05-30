library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nand_kapi_signal is
  port(
    in_giris : in std_logic_vector(7 downto 0);
    out_cikis : out std_logic     
  );
end nand_kapi_signal;

architecture Behavioral of nand_kapi_signal is

  signal r_nand_sonuc : std_logic := '0';
	
begin
	 
  out_cikis <= r_nand_sonuc;
	  
  process(in_giris)
    variable v_nand_sonuc : std_logic := '0';
	
  begin
    r_nand_sonuc <= in_giris(0);
    for n_i in 1 to 7 loop
      r_nand_sonuc <= not(r_nand_sonuc and in_giris(n_i));
    end loop; 
	
  end process;
end Behavioral;