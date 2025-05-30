entity yari_toplayici_bit is
  port (
    in_giris_1 : in bit;
    in_giris_2 : in bit;
    out_cikis : out bit;
    out_cikis_elde : out bit
  );
end yari_toplayici_bit;
	
architecture Behavioral of yari_toplayici_bit is
	
begin
	
  out_cikis <= in_giris_1 xor in_giris_2;
  out_cikis_elde <= in_giris_1 and in_giris_2;
	
end Behavioral;