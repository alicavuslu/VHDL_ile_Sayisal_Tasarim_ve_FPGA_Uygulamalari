library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity procedure_ornek is
  Port ( 
    in_giris_elde : in std_logic;
    in_giris_1 : in std_logic_vector(3 downto 0);
    in_giris_2 : in std_logic_vector(3 downto 0);
    out_cikis : out std_logic_vector(3 downto 0);
    out_cikis_elde : out std_logic 
  );
end procedure_ornek;
	
architecture Behavioral of procedure_ornek is
	
  procedure toplayici_4_bit(
    in_giris_elde : in std_logic;
    in_giris_1 : in std_logic_vector(3 downto 0);
    in_giris_2 : in std_logic_vector(3 downto 0);
    out_cikis : out std_logic_vector(3 downto 0);
    out_cikis_elde : out std_logic ) is

    variable v_elde: std_logic_vector(4 downto 0);
	
  begin
	
    v_elde(0) := in_giris_elde;
    for n_i in 0 to 3 loop      
      out_cikis (n_i) := in_giris_1(n_i) xor in_giris_2(n_i) xor   v_elde(n_i);
      v_elde(n_i + 1) := (in_giris_1(n_i) and in_giris_2(n_i)) or  (in_giris_2(n_i) and v_elde(n_i)) or (in_giris_2(n_i) and v_elde(n_i));
    end loop;

    out_cikis_elde := v_elde(4);

  end toplayici_4_bit;
	
begin
	
  process(in_giris_elde, in_giris_1, in_giris_2)
    variable v_cikis : std_logic_vector(3 downto 0);
    variable v_cikis_elde : std_logic;                
  begin
	
    toplayici_4_bit(in_giris_elde, in_giris_1, in_giris_2, v_cikis, v_cikis_elde );
    out_cikis <= v_cikis;
    out_cikis_elde <= v_cikis_elde;
  end process;

end Behavioral;