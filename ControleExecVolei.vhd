library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControleExecVolei is
    Port (
        exec        : in std_logic;  -- Botão como clock
        seletor     : in std_logic_vector(1 downto 0);  -- Vetor seletor
        sw0         : in std_logic;  -- Ação de somar ponto ou tempo técnico
        sw1         : in std_logic;  -- Escolhe o time
        pontos_t1_out, pontos_t2_out : out integer range 0 to 999;  -- Pontos de cada time
        sets_t1_out, sets_t2_out   : out integer range 0 to 5;  -- Sets ganhos por cada time
        tempos_t1_out, tempos_t2_out : out integer range 0 to 2; -- Sinal de reset para a posse de bola
		  vencedor    : out integer range 0 to 2 -- 0 se nao tem vencedor ainda, 1 se o time 1 venceu, 2 se o time 2 venceu
	 );
end ControleExecVolei;

architecture Comportamento of ControleExecVolei is
    signal pontos_t1, pontos_t2 : integer range 0 to 999 := 0;
    signal sets_t1, sets_t2 : integer range 0 to 5 := 0;
    signal tempos_t1, tempos_t2 : integer range 0 to 2 := 2;
    signal set_limite : integer := 25;  -- Limite de pontos por set (inicialmente 25)
	 signal venc : integer range 0 to 2 := 0;
begin

    process(exec)
    begin
        if falling_edge(exec) then  -- Botão tratado como clock
            if seletor = "01" then  -- Só processa se o seletor for "01"
                -- Se sw0 for 0, soma ponto; Se sw0 for 1, tempo técnico
                if sw0 = '0' then
                    if sw1 = '0' then  -- Time 1
                        pontos_t1 <= pontos_t1 + 1;
                    else  -- Time 2
                        pontos_t2 <= pontos_t2 + 1;
                    end if;
                elsif sw0 = '1' then  -- Tempo técnico
                    if sw1 = '0' and tempos_t1 > 0 then  -- Time 1
                        tempos_t1 <= tempos_t1 - 1;
                    elsif sw1 = '1' and tempos_t2 > 0 then  -- Time 2
                        tempos_t2 <= tempos_t2 - 1;
                    end if;
                end if;
            else
                -- Se o seletor for diferente de "01", zera tudo
                pontos_t1 <= 0;
                pontos_t2 <= 0;
                sets_t1 <= 0;
                sets_t2 <= 0;
                tempos_t1 <= 2;
                tempos_t2 <= 2;
					 venc <= 0;
            end if;

            -- Verificar se algum time venceu o set
            if pontos_t1 >= set_limite and pontos_t1 - pontos_t2 >= 2 then
                sets_t1 <= sets_t1 + 1;
                pontos_t1 <= 0;
                pontos_t2 <= 0;
                tempos_t1 <= 2;
                tempos_t2 <= 2;
					 
					 if sets_t1 >= 3 then
						  venc <= 1;
					 end if;
            elsif pontos_t2 >= set_limite and pontos_t2 - pontos_t1 >= 2 then
                sets_t2 <= sets_t2 + 1;
                pontos_t1 <= 0;
                pontos_t2 <= 0;
                tempos_t1 <= 2;
                tempos_t2 <= 2;
					 
					 if sets_t1 >= 3 then
						  venc <= 2;
					 end if;
            end if;

            -- Verificar se o set vai até 15 pontos (em caso de empate 2x2)
            if sets_t1 = 2 and sets_t2 = 2 then
                set_limite <= 15;
            end if;
        end if;
    end process;

    -- Atribuições das saídas
    pontos_t1_out <= pontos_t1;
    pontos_t2_out <= pontos_t2;
    sets_t1_out <= sets_t1;
    sets_t2_out <= sets_t2;
    tempos_t1_out <= tempos_t1;
    tempos_t2_out <= tempos_t2;
	 vencedor <= venc;

end Comportamento;
