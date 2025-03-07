Library IEEE;
use IEEE.std_logic_1164.all;

entity Fg_gate is
	port(
	A, B, C, D : in std_logic;
	Cout : out std_logic
	);
	end Fg_gate;
	
architecture Fg_arch of Fg_gate is
begin 
    Cout <= ((NOT(B) AND C) OR (A AND D) OR (C AND NOT(D)) OR (A AND NOT(B)) OR (NOT(A) AND B AND NOT(C)) OR (A AND B AND C AND NOT(D))) AND NOT(A AND B AND NOT(C) AND D);
end Fg_arch;
