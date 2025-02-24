library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControleExec is
    Port (
        exec: in std_logic; -- Botão como clock
        seletor: in std_logic_vector(1 downto 0);
        comandos: in std_logic_vector(7 downto 0);
  zera_faltas: in std_logic;
        pontos_t1_out, pontos_t2_out: out integer range 0 to 999;
        faltas_t1_out, faltas_t2_out: out integer range 0 to 5;
        reset_posse: out std_logic
    );
end ControleExec;

architecture Comportamento of ControleExec is
    signal pontos_t1, pontos_t2: integer range 0 to 999 := 0;
    signal faltas_t1, faltas_t2: integer range 0 to 5 := 0;
    signal reset_posse_signal: std_logic := '0';

begin
    process(seletor, exec, zera_faltas)
    begin
if seletor = "00" then
     if zera_faltas = '1' then
      faltas_t1 <= 0;
            faltas_t2 <= 0;
reset_posse_signal <= '0';
        elsif falling_edge(exec) then  -- Botão tratado como clock
            if seletor /= "00" then
                pontos_t1 <= 0;
                pontos_t2 <= 0;
                faltas_t1 <= 0;
                faltas_t2 <= 0;
                reset_posse_signal <= '0';
            elsif comandos(5) = '1' then
                -- Resetar todas as condições do jogo
                pontos_t1 <= 0;
                pontos_t2 <= 0;
                faltas_t1 <= 0;
                faltas_t2 <= 0;
                reset_posse_signal <= '0';
            else
                reset_posse_signal <= '0'; -- Evita latch
                case comandos(3 downto 2) is
                    when "00" => -- Adicionar pontos
reset_posse_signal <= '0';
                        if comandos(4) = '0' then
                            pontos_t1 <= pontos_t1 + conv_integer(comandos(1 downto 0));
                        else
                            pontos_t2 <= pontos_t2 + conv_integer(comandos(1 downto 0));
                        end if;
                    when "01" => -- Adicionar falta
reset_posse_signal <= '0';
                        if comandos(4) = '0' and faltas_t1 < 5 then
                            faltas_t1 <= faltas_t1 + 1;
                        elsif comandos(4) = '1' and faltas_t2 < 5 then
                            faltas_t2 <= faltas_t2 + 1;
                        end if;
                    when "10" => -- Resetar tempo de posse
                        reset_posse_signal <= '1';
                    when others => null;
                end case;
            end if;
  end if;
else
  pontos_t1 <= 0;
  pontos_t2 <= 0;
  faltas_t1 <= 0;
  faltas_t2 <= 0;
  reset_posse_signal <= '0';
end if;
    end process;
    
    -- Atribuir saídas
    pontos_t1_out <= pontos_t1;
    pontos_t2_out <= pontos_t2;
    faltas_t1_out <= faltas_t1;
    faltas_t2_out <= faltas_t2;
    reset_posse <= reset_posse_signal;

end Comportamento;
