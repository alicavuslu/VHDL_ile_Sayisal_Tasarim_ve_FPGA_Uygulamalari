library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package ornekler_paket is
  function log2_int(in_giris : integer) return integer;
end ornekler_paket;

package body ornekler_paket is

  function log2_int(in_giris : integer) return integer is
    variable sonuc : integer;
  begin
    for n_i in 0 to 31 loop
      if (in_giris <= (2 ** n_i)) then
        sonuc := n_i;
        exit;
      end if;
    end loop;
    return sonuc;
  end log2_int;
end package body;