library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_1164.all;

entity ejercicioParcial is
port(
	sensor : in std_logic;
	Temp : in std_logic;
	Reloj : in std_logic;
	semaforo1: out std_logic;
	semaforo2: out std_logic;
	tempF : out std_logic
	);
end entity;
architecture ejercicioParcial_arc of ejercicioParcial is
type def_states is (rojo, verde);
signal estadoActual, estadoSig : def_states;

begin
p: process(Reloj) is
	begin
		if(rising_edge(Reloj)) then
			estadoActual <= estadoSig;
		end if;	
	end process p;	
	
p0: process(sensor, estadoActual) is
	begin
		tempF <= '0';
		case estadoActual is
			when rojo =>
					if(sensor = '0' and temp = '0') then
						estadoSig <= verde;
						semaforo1 <= '1';
						semaforo2 <= '0';
					end if;		
			when verde =>
					if(sensor = '1') then
						tempF <= '1';
						estadoSig <= rojo; 
						semaforo1 <= '0';
						semaforo2 <= '1';
					end if;
		end case;
	end process p0;
end architecture;