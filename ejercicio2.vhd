library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_1164.all;

entity ejercicio2 is

generic(
	long_entrada : natural := 15
);

port(
	a: in std_logic_vector(long_entrada downto 0);
	y: out std_logic
	);
end entity;

architecture ejercicio2_arc of ejercicio2 is
begin
p2: process(a) is
	variable par : std_logic;
	begin
	par := '1';
	for i in a'range loop
		if(a(i) = '1') then
			par := not par;	
		end if;
	end loop;
	y <= par;
end process;
end architecture;