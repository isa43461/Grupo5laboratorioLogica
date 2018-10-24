library ieee;
use ieee.std_logic_1164.all;

entity tarea is
port(
	b1, b0: in std_logic;
	f0, f1, f2, f3: out std_logic
);
end entity;

architecture tarea_arc of tarea is
begin

f0 <= (not b1 and not b0);
f1 <= (not b1 and b0);
f2 <= (b1 and not b0);
f3 <= (b1 and b0);


end architecture;