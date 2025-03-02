Library IEEE;
use IEEE.std_logic_1164.all;

entity Fb_gate is
	port(
	A, B, C, D : in std_logic;
	Cout : out std_logic
	);
	end Fb_gate;
	
architecture Fb_arch of Fb_gate is
begin
    Cout <= (((A AND NOT(C) AND D) OR (NOT(A) AND C AND D) OR (NOT(A) AND NOT(C) AND NOT(D)) OR (NOT(B) AND NOT(D)) OR (NOT(A) AND NOT(B))) AND NOT(A AND B AND NOT(C) AND D)) OR (A AND B AND C AND D);
end Fb_arch;