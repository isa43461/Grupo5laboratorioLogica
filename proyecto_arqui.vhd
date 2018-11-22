library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity proyecto_arqui is
	port
	(
		clk, enable , reset 	 : in	std_logic;
		clk_new : inout std_logic; 	
		address : in std_logic_vector(3 downto 0);
		m0, m1, m2, m3 : in std_logic;
		devuelta_final_esta_si : out std_logic := '0';
		dinero ,devuelta : out integer range 0 to 2800;
		mayor, menor, igual ,producto: out std_logic;
		-------- ELEMENTOS RAM-----------
		wr : in std_logic;
		data_in : in std_logic_vector(3 downto 0);
		data_out : inout std_logic_vector(3 downto 0);
		-------ELEMENTOS ROM-------------
		data_out_rom : inout integer range 0 to 2800;
		----ELEMENTOS SIP NOP-----------
		s,i,p,espacio: out std_logic_vector(6 downto 0)
		
	);
end entity;

architecture proyecto_arqui_arc of proyecto_arqui is

	type Def_Estados is (inicial, revision_cantidad, revision_dinero);
	signal estado_actual: Def_Estados;
	signal mayorSignal : std_logic := '0';
	signal menorSignal : std_logic := '0';
	signal igualSignal : std_logic := '0';
	signal clock_sig : std_logic; 
	signal contador : integer range 0 to 15;  
	
	signal valor : integer range 0 to 2800; 
	signal dinero_act : integer range 0 to 2800 := 0; 
	signal cambio : integer range 0 to 2800 := 0; 
			
	
	-----SEÑALES RAM
	type ram_type is array (15 downto 0) of std_logic_vector(3 downto 0);
	signal my_ram: ram_type := (
											0 => "0000",
											1 => "1100",
											2 => "1101",
											3 => "1110",
											4 => "1111",
											5 => "1111",
											6 => "1101",
											7 => "1111",
											8 => "1111",
											9 => "1111",
											10 => "1101",
											11 => "1101",
											12 => "1111",
											13 => "1111",
											14 => "1110",
											15 => "1110");
	
	-----SEÑALES ROM
	type rom_type is array (15 downto 0) of integer range 0 to 2800;
	signal my_rom: rom_type := (
		0 => 1700,
		1 => 1200,
		2 => 1300,
		3 => 1400,
		4 => 1800,
		5 => 1700,
		6 => 1100,
		7 => 1000,
		8 => 1600,
		9 => 1300,
		10 => 1100,
		11 => 1000,
		12 => 2800,
		13 => 1800,
		14 => 2100,
		15 => 1400
	);

begin
	contador <= to_integer(unsigned(data_out));
	estados : process(clk_new, enable) is
	begin
		if(rising_edge(clk_new)) then
			valor <= data_out_rom;
			case estado_actual is
				when inicial =>	
						
					if(enable = '1' )then
						estado_actual <= revision_cantidad;
					else
						case address is
							when "0000" =>
								s<="0001000";
								espacio <= "1111001";
								i<="1111111";
								p<="1111111";
							when "0001" =>
								s<="0001000";
								espacio <= "0100100";
								i<="1111111";
								p<="1111111";
							when "0010" =>
								s<="0001000";
								espacio <= "0110000";
								i<="1111111";
								p<="1111111";
							when "0011" =>
								s<="0001000";
								espacio <= "0011001";
								i<="1111111";
								p<="1111111";
							when "0100" =>
								s<="0000011";
								espacio <= "1111001";
								i<="1111111";
								p<="1111111";
							when "0101" =>
								s<="0000011";
								espacio <= "0100100";
								i<="1111111";
								p<="1111111";
							when "0110" =>
								s<="0000011";
								espacio <= "0110000";
								i<="1111111";
								p<="1111111";
							when "0111" =>
								s<="0000011";
								espacio <= "0011001";
								i<="1111111";
								p<="1111111";
							when "1000" =>
								s<="1000110";
								espacio <= "1111001";
								i<="1111111";
								p<="1111111";
							when "1001" =>
								s<="1000110";
								espacio <= "0100100";
								i<="1111111";
								p<="1111111";
							when "1010" =>
								s<="1000110";
								espacio <= "0110000";
								i<="1111111";
								p<="1111111";
							when "1011" =>
								s<="1000110";
								espacio <= "0011001";
								i<="1111111";
								p<="1111111";
							when "1100" =>
								s<="0100001";
								espacio <= "1111001";
								i<="1111111";
								p<="1111111";
							when "1101" =>
								s<="0100001";
								espacio <= "0100100";
								i<="1111111";
								p<="1111111";
							when "1110" =>
								s<="0100001";
								espacio <= "0110000";
								i<="1111111";
								p<="1111111";
							when "1111" =>
								s<="0100001";
								espacio <= "0011001";
								i<="1111111";
								p<="1111111";
							when others =>
								null;

						end case;
						estado_actual <= inicial;
					end if;
					producto <= '0';
					devuelta <= 0;
					devuelta_final_esta_si <= '0';
				when revision_cantidad => 
					if(contador > 0 and enable = '1')then
						--y <= '1';
						s<="0010010"; --S
						espacio  <= "1111111";
						i<="1111001"; --i
						p<="0001100";  --p
						estado_actual <= revision_dinero;		
					else
						--y <= '0';
						espacio  <= "1111111";
						s<="0101011"; --N
						i<="1000000"; -- o
						p<="0001100"; --p
						estado_actual <= inicial;	
					end if;
					producto <= '0';
					devuelta_final_esta_si <= '0';
					
				when revision_dinero =>
					if(mayorSignal = '1' or igualSignal = '1')then
						producto <= '1';
						cambio <= dinero_act - valor;
						if(cambio > 0)then
							devuelta_final_esta_si <= '1';
						else
							devuelta_final_esta_si <= '0';
						end if;
						estado_actual <= inicial;
					elsif(menorSignal = '1')then
						estado_actual <= revision_dinero;
						producto <= '0';
						devuelta_final_esta_si <= '0';
					end if;					
			end case;
		end if;
		
		dinero <= dinero_act;
		devuelta <= cambio;
	end process;
	
	--------------------------------------MEMORIA RAM PROFE PONGANOS 5----------------------------------
		
	memory_ram: process(clk_new)
		begin
			if(rising_edge(clk_new)) then
				if(wr = '1') then
					my_ram(to_integer(unsigned(address))) <= data_in;			
				end if;
			end if;
			data_out <= my_ram(to_integer(unsigned(address)));
	end process;
		
	--------------------------------------MEMORIA ROM----------------------------------
	
	memory_rom: process(address)
	begin
		case address is
			when "0000" => 
								data_out_rom <= my_rom(0);
			when "0001" => 
								data_out_rom <= my_rom(1);
			when "0010" => 
								data_out_rom <= my_rom(2);
			when "0011" => 
								data_out_rom <= my_rom(3);
			when "0100" => 
								data_out_rom <= my_rom(4);
			when "0101" => 
								data_out_rom <= my_rom(5);
			when "0110" => 
								data_out_rom <= my_rom(6);
			when "0111" => 
								data_out_rom <= my_rom(7);
			when "1000" => 
								data_out_rom <= my_rom(8);
			when "1001" => 
								data_out_rom <= my_rom(9);
			when "1010" => 
								data_out_rom <= my_rom(10);
			when "1011" => 
								data_out_rom <= my_rom(11);
			when "1100" => 
								data_out_rom <= my_rom(12);
			when "1101" => 
								data_out_rom <= my_rom(13);
			when "1110" => 
								data_out_rom <= my_rom(14);
			when "1111" => 
								data_out_rom <= my_rom(15);
		end case;
	end process;
	
	------------------------SUMADOR-----------------------
	
	sumar : process(m0, m1, m2, m3, clk_new) is
	begin
		case estado_actual is
			when revision_dinero =>
				if(rising_edge(clk_new))then
					if(m0 = '0')then
						dinero_act <= dinero_act + 0;
					elsif(m1 = '0') then
						dinero_act <= dinero_act + 100;
					elsif(m2 = '0') then 
						dinero_act <= dinero_act + 200;
					elsif(m3 = '0') then 
						dinero_act <= dinero_act + 500;
					elsif(mayorSignal = '1' or igualSignal = '1') then
						dinero_act <= 0;
					end if;
				end if;
				
			when inicial => 
				null;
			
			when revision_cantidad=>
				null;
			when others => 
				null;
		end case;
	end process;
	
	-------------------------CLOCK----------------------------
	
	clock_nuevito : process(clk) is 
	variable cn:integer := 0;
	begin 
		if(reset ='0') then
			clock_sig <= '0';
			cn := 0;
		elsif(rising_edge(clk)) then
			if(cn = 30000000) then
				clock_sig <= not(clock_sig);
				cn := 0;
			else 
				cn := cn + 1;
			end if;
		end if;
	end process;
	
	clk_new <= clock_sig;
	
	----------------------COMPARADOR-----------------------
	
	comparador : process(clk_new) is
	begin
		if(rising_edge(clk_new))then
			case estado_actual is 
				when revision_dinero=>
					mayorSignal <= '0';
					menorSignal <= '0';
					igualSignal <= '0';
					if(dinero_act > valor)then
						mayorSignal <= '1';
						menorSignal <= '0';
						igualSignal <= '0';
					elsif(dinero_act < valor)then
						mayorSignal <= '0';
						menorSignal <= '1';
						igualSignal <= '0';
					elsif(dinero_act = valor)then
						mayorSignal <= '0';
						menorSignal <= '0';
						igualSignal <= '1';
					end if;

				when inicial =>
					mayorSignal <= '0';
					igualSignal <= '0';
				when revision_cantidad =>  
					null;
				
			end case;
		end if;
		mayor <= mayorSignal;
		menor <= menorSignal;
		igual <= igualSignal;	
	end process; 

end architecture;