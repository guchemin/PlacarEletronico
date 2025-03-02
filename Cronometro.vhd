library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity Cronometro is
	port ( 
		clk: in std_logic; -- Pin connected to P11 (N14)
		clk_1Hz: out std_logic
	);

	end Cronometro;
  
architecture freq_div of Cronometro is
  
signal count: integer:=1;
signal tmp : std_logic := '0';
  
begin
  
process(clk)
	begin
	if(clk'event and clk='1') then
		count <=count+1;
		if (count = 50000000/2000) then
			tmp <= NOT tmp;
			count <= 1;
		end if;
	end if;
	clk_1Hz <= tmp;
end process;
 
end freq_div;