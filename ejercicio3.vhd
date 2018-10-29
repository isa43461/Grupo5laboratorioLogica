library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_1164.all;

entity ejercicio3 is
generic(
	long : natural := 3 
);
port(
	w : in std_logic_vector(long downto 0);
	y : out std_logic_vector(long downto 0);
	shift: in std_logic;
	k: out std_logic
);
end entity;

architecture ejercicio3_arc of ejercicio3 is
begin
p3: process(shift, w) is
	begin
	if(shift = '1')then
		y(3) <= '0';
		y(2) <= w(3);
		y(1) <= w(2);
		y(0) <= w(1);
		k <= w(0);
	elsif(shift = '0') then
		y <= w;
		k <= '0';
	end if;
end process;
end architecture;