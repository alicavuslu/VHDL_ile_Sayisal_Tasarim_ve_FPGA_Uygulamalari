library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_yakma is
  Port ( 
    in_clk : in std_logic;
    in_rst : in std_logic;
    out_clk_1Hz : out std_logic;
    out_clk_1_2Hz : out std_logic;
    out_clk_1_4Hz : out std_logic;
    out_clk_1_8Hz : out std_logic;
    out_clk_1_16Hz : out std_logic;
    out_clk_1_NHz : out std_logic
  );
end led_yakma;

architecture Behavioral of led_yakma is

  component saat_frekans_bolucu
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
  end component;
  
  signal r_clk_1Hz_d : std_logic := '0';
  signal r_clk_1Hz : std_logic_vector(3 downto 0) := (others => '0');
  signal r_clk_1_2Hz : std_logic := '0';
  signal r_clk_1_4Hz : std_logic := '0';
  signal r_clk_1_8Hz : std_logic := '0';
  signal r_clk_1_16Hz : std_logic := '0';
  signal r_clk_1_NHz : std_logic := '0';    

begin

  out_clk_1Hz <= r_clk_1Hz(3);
  out_clk_1_2Hz <= r_clk_1_2Hz;
  out_clk_1_4Hz <= r_clk_1_4Hz;
  out_clk_1_8Hz <= r_clk_1_8Hz;
  out_clk_1_16Hz <= r_clk_1_16Hz;
  out_clk_1_NHz <= r_clk_1_NHz;
    
  saat_frekans_bolucu1_map : saat_frekans_bolucu
  generic map( N => 100000000  )
  port map ( 
    in_clk => in_clk,
    in_rst => in_rst,
    out_clk_2 => open,
    out_clk_4 => open,
    out_clk_8 => open,
    out_clk_16 => open,
    out_clk_N => r_clk_1Hz_d 
  );
     
  process(in_clk, in_rst)
  begin
    if in_rst = '1' then
        r_clk_1Hz <= (others => '0');
    elsif rising_edge(in_clk) then
        r_clk_1Hz <= r_clk_1Hz(2 downto 0) & r_clk_1Hz_d;
    end if;
  end procesS;
       
  saat_frekans_bolucu2_map : saat_frekans_bolucu
  generic map( N => 32  )
  port map ( 
    in_clk => r_clk_1Hz(3),
    in_rst => in_rst,
    out_clk_2 => r_clk_1_2Hz,
    out_clk_4 => r_clk_1_4Hz,
    out_clk_8 => r_clk_1_8Hz,
    out_clk_16 => r_clk_1_16Hz,
    out_clk_N => r_clk_1_NHz 
  );  

end Behavioral;
