library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
	
entity saat_frekans_bolucu is
  generic(
    N : integer := 16
  );
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    out_clk_2 : out std_logic;
    out_clk_4 : out std_logic;
    out_clk_8 : out std_logic;
    out_clk_16 : out std_logic;
    out_clk_N : out std_logic                                                     
  );
end saat_frekans_bolucu;
	
architecture Behavioral of saat_frekans_bolucu is
  signal r_sayac : std_logic_vector(3 downto 0) := (others => '0');
  signal r_sayac_N : integer := 0;
begin
	
  out_clk_2  <= r_sayac(0);
  out_clk_4  <= r_sayac(1);
  out_clk_8  <= r_sayac(2);
  out_clk_16 <= r_sayac(3);
  out_clk_N  <= '0' when r_sayac_N < N / 2 else '1';
	
  process(in_clk, in_rst)
  begin
    if in_rst = '1' then
      r_sayac <= (others => '0');
      r_sayac_N <= 0;
	
    elsif rising_edge(in_clk) then
      r_sayac <= r_sayac + 1;        
      if r_sayac_N = N - 1 then
        r_sayac_N <= 0;
      else   
        r_sayac_N <= r_sayac_N + 1;
      end if;                   
    end if;
  end process;
end Behavioral;