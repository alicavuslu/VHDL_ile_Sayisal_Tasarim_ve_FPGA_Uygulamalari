library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
	
entity function_ornek is
  Port ( 
    in_giris_elde : in std_logic;
    in_giris_1 : in std_logic_vector(3 downto 0);
    in_giris_2 : in std_logic_vector(3 downto 0);
    out_cikis : out std_logic_vector(3 downto 0);
    out_cikis_elde : out std_logic
  );
end function_ornek;
	
architecture Behavioral of function_ornek is
	
  function toplayici_4_bit (in_giris_1, in_giris_2 : std_logic_vector(3 downto 0); in_giris_elde: std_logic) 
  return std_logic_vector is
    variable v_elde : std_logic;
    variable v_toplam : std_logic_vector(4 downto 0);
	
  begin

    v_elde := in_giris_elde;
    v_toplam := (others => '0');
	
    for n_i in 0 to 3 loop
      v_toplam(n_i) := in_giris_1(n_i) xor in_giris_2(n_i) xor v_elde;
      v_elde := (in_giris_1(n_i) and in_giris_2(n_i)) or 
                (in_giris_1(n_i) and v_elde) or 
                (in_giris_2(n_i) and v_elde);
    end loop;

    v_toplam (4) := v_elde;
    return v_toplam;
  end toplayici_4_bit;
	
  signal r_toplama_sonuc : std_logic_vector(4 downto 0) := (others => '0'); 
	
begin
	
  r_toplama_sonuc <= toplayici_4_bit(in_giris_1, in_giris_2, in_giris_elde);
	
  out_cikis <= r_toplama_sonuc(3 downto 0);
  out_cikis_elde <= r_toplama_sonuc(4);
	
end Behavioral;