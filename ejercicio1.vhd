library ieee;
use ieee.std_logic_1164.all;

entity ejercicio1 is
port(
	d, k, h: in std_logic;
	b: out std_logic
);
end entity;

architecture ejercicio1_arc of ejercicio1 is
begin

b <= (d and (k or h));

end architecture;