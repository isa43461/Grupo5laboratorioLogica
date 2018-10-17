library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_1164.all;

entity lab is
port(
	a,b: in integer range 0 to 7;
	comp: out std_logic;
	suma: out integer range 0 to 15
	);
end entity;

architecture lab_arc of lab is
begin
p1: process(a,b) is
	begin
	if(a>b) then
		comp <= '1';
	else
		comp <= '0';
	end if;
	suma <= a+b;
	end process;
end architecture;
	