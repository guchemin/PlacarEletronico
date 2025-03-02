Library IEEE;
use IEEE.std_logic_1164.all;

entity Fc_gate is
	port(
	A, B, C, D : in std_logic;
	Cout : out std_logic
	);
	end Fc_gate;
	
architecture Fc_arch of Fc_gate is
begin 
    Cout <= ((A AND NOT(B)) OR (NOT(A) AND B) OR (NOT(C) AND D) OR (NOT(A) AND D) OR (NOT(A) AND NOT(C))) AND NOT(A AND B AND NOT(C) AND D);
end Fc_arch;