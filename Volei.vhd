library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Volei is
    Port (
		  seletor       : in std_logic_vector(1 downto 0);
        seletor_tela  : in std_logic_vector(1 downto 0);  -- Seletor para escolher a tela (usando vetor 2 bits)
        pontos_t1     : in integer range 0 to 999;        -- Pontos do time 1
        pontos_t2     : in integer range 0 to 999;        -- Pontos do time 2
        sets_t1       : in integer range 0 to 5;          -- Sets ganhos do time 1
        sets_t2       : in integer range 0 to 5;          -- Sets ganhos do time 2
        tempos_t1     : in integer range 0 to 2;          -- Tempos do time 1
        tempos_t2     : in integer range 0 to 2;          -- Tempos do time 2
		  vencedor      : in integer range 0 to 2;
        hex0, hex1, hex2, hex3, hex4, hex5 : out std_logic_vector(3 downto 0)  -- Display
    );
end Volei;

architecture Comportamento of Volei is
    signal set_atual : integer range 0 to 5 := 0;
begin
    process(seletor, seletor_tela, pontos_t1, pontos_t2, sets_t1, sets_t2, tempos_t1, tempos_t2, vencedor)
    begin
		  if seletor = "01" then
			  case seletor_tela is
					when "00" =>  -- Tela 00: Pontos do time 1, time 2, e set atual
						 -- Pontos do time 1
						 hex5 <= conv_std_logic_vector((pontos_t1 / 10) mod 10, 4);
						 hex4 <= conv_std_logic_vector(pontos_t1 mod 10, 4);
						 hex3 <= "1111";
						 
						 -- Pontos do time 2
						 hex1 <= conv_std_logic_vector((pontos_t2 / 10) mod 10, 4);
						 hex0 <= conv_std_logic_vector(pontos_t2 mod 10, 4);
						 
						 set_atual <= sets_t1 + sets_t2 + 1;
						 
						 -- Set atual (no hex2)
						 hex2 <= conv_std_logic_vector(set_atual, 4);

					when "01" =>  -- Tela 01: Sets ganhos e tempos restantes
						 -- Sets ganhos do time 1
						 hex5 <= conv_std_logic_vector(sets_t1, 4);
						 
						 hex4 <= "1101";
						 
						 -- Sets ganhos do time 2
						 hex0 <= conv_std_logic_vector(sets_t2, 4);
						 
						 -- Tempos do time 1
						 hex3 <= conv_std_logic_vector(tempos_t1, 4);
						 
						 -- Tempos do time 2
						 hex2 <= conv_std_logic_vector(tempos_t2, 4);
						 
						 hex1 <= "1101";

					when others =>  -- Caso não haja seleção, limpa os displays
						 hex5 <= "1101";
						 hex4 <= "1101";
						 hex3 <= "1101";
						 hex2 <= "1101";
						 hex1 <= "1101";
						 hex0 <= "1101";
			  end case;
			  if sets_t1 >= 3 then
					hex5 <= "0001";
					hex4 <= "1110";
					hex3 <= "1110";
					hex2 <= "1110";
					hex1 <= "1110";
					hex0 <= "0000";
			  elsif sets_t2 >= 3 then
					hex5 <= "0000";
					hex4 <= "1110";
					hex3 <= "1110";
					hex2 <= "1110";
					hex1 <= "1110";
					hex0 <= "0001";
			  end if;
		  end if;
    end process;

end Comportamento;
