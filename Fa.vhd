Library IEEE;
use IEEE.std_logic_1164.all;

entity Fa_gate is
	port(
	A, B, C, D : in std_logic;
	Cout : out std_logic
	);
	end Fa_gate;
	
architecture Fa_arch of Fa_gate is
begin
    Cout <= ((NOT(A) AND B AND D) OR (A AND NOT(B) AND NOT(C)) OR (NOT(B) AND NOT(D)) OR (NOT(A) AND C) OR (A AND NOT(D)) OR (B AND C)) AND NOT(A AND B AND C AND NOT(D)) AND NOT(A AND B AND NOT(C) AND D);
end Fa_arch;