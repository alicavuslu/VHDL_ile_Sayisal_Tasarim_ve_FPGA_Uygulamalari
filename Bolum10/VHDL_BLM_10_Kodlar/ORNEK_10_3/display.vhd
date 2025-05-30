library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity display is
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    in_giris : in std_logic_vector(3 downto 0);
    out_disp_sec : out std_logic_vector(7 downto 0);
    out_cikis : out std_logic_vector(7 downto 0)
  );
end display;

architecture Behavioral of display is

    type t_display_ekran is array (0 to 15) of std_logic_vector(7 downto 0);
    constant DISP_EKRAN : t_display_ekran := ("10000001", "11001111", "10010010",
    "10000110", "11001100", "10100100", "10100000", "10001111", "10000000", 
    "10000100", "10001000", "11100000", "10110001", "11000010", "10110000", 
    "10111000");
    
    signal r_giris : std_logic_vector(3 downto 0) := (others => '0');
    signal r_cikis : std_logic_vector(7 downto 0) := (others => '0');
    
    attribute syn_keep : string;
    attribute mark_debug : string;

    attribute syn_keep of r_giris : signal is "true";
    attribute mark_debug of r_giris : signal is "true";    
    
    attribute syn_keep of r_cikis : signal is "true";
    attribute mark_debug of r_cikis : signal is "true";    
    
begin

    out_disp_sec <= "00000000";
    out_cikis <= r_cikis;
    
    process(in_clk, in_rst, in_giris)
    begin
        if in_rst = '1' then
            r_giris <= (others => '0');
            r_cikis <= (others => '0');
            
        elsif rising_edge(in_clk) then
            r_giris <= in_giris;
            r_cikis <= DISP_EKRAN(conv_integer(r_giris));
        end if;
    end process;
end Behavioral;
