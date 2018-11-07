library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cajafuerte is
port(
	e, e0, clock: in std_logic;
	s : out std_logic
);
end entity;
architecture cajafuerte_arc of cajafuerte is
type def_states is (q0, q1);
signal estadoActual, estadoSig : def_states;
begin
clk: process(clock) is
	begin
		if(rising_edge(clock)) then
			estadoActual <= estadoSig;
		end if;	
	end process clk;	
	
p : process(estadoActual, e, e0) is
begin
	case estadoActual is
		when q0 =>
			if(e = '0' and e0 = '0') then
				estadoSig <= q0;
				s <= '1';
			elsif(e = '1' and e0 = '0') then
				estadoSig <= q1;
				s <= '0';
			end if;
		when q1 => 
			if(e = '1' and e0 = '1') then
				estadoSig <= q1;
				s <= '0';
			elsif(e = '0' and e0 = '0') then
				estadoSig <= q0;
				s <= '0';
			end if;	
		end case;
end process p;
end architecture;
