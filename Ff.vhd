Library IEEE;
use IEEE.std_logic_1164.all;

entity Ff_gate is
	port(
	A, B, C, D : in std_logic;
	Cout : out std_logic
	);
	end Ff_gate;
	
architecture Ff_arch of Ff_gate is
begin 
    Cout <= ((NOT(A) AND B AND NOT(C)) OR (A AND C) OR (B AND NOT(D)) OR (NOT(C) AND NOT(D)) OR (A AND NOT(B)) OR (A AND B AND C AND D)) AND NOT(A AND B AND C AND NOT(D)) AND NOT(A AND B AND NOT(C) AND D);
end Ff_arch;