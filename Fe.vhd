Library IEEE;
use IEEE.std_logic_1164.all;

entity Fe_gate is
	port(
	A, B, C, D : in std_logic;
	Cout : out std_logic
	);
	end Fe_gate;
	
architecture Fe_arch of Fe_gate is
begin 
    Cout <= ((C AND NOT(D)) OR (NOT(B) AND NOT(D)) OR (A AND B) OR (A AND C) OR (A AND B AND C AND D)) AND NOT(A AND B AND C AND NOT(D)) AND NOT(A AND B AND NOT(C) AND D);
end Fe_arch;