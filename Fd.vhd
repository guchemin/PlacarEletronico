Library IEEE;
use IEEE.std_logic_1164.all;

entity Fd_gate is
	port(
	A, B, C, D : in std_logic;
	Cout : out std_logic
	);
	end Fd_gate;
	
architecture Fd_arch of Fd_gate is
begin 
    Cout <= ((B AND NOT(C) AND D) OR (A AND NOT(C)) OR (NOT(B) AND C AND D) OR (NOT(A) AND NOT(B) AND NOT(D)) OR (B AND C AND NOT(D))) AND NOT(A AND B AND C AND NOT(D)) AND NOT(A AND B AND NOT(C) AND D);
end Fd_arch;