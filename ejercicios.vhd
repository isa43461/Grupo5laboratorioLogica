library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

entity ejercicios is
port(
	d, k, h : in std_logic;
	b : out std_logic
);
end entity;
architecture ejercicios_arc of ejercicios is
begin
	b <= (k or h) and d;
end architecture;



