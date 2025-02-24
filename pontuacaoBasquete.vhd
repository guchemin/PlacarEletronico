library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pontuacaoBasquete is
    Port (
        comandos: in std_logic_vector(7 downto 0);
        exec: in std_logic;
        clk: in std_logic;
        pontos_t1, pontos_t2: out integer range 0 to 999
    );
end pontuacaoBasquete;

architecture Comportamento of pontuacaoBasquete is
    signal pontos_t1_reg, pontos_t2_reg: integer range 0 to 999 := 0;
    signal exec_anterior: std_logic := '1';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if exec = '0' and exec_anterior = '1' then
                if comandos(5) = '1' then
                    -- Resetar pontuação
                    pontos_t1_reg <= 0;
                    pontos_t2_reg <= 0;
                else
                    case comandos(3 downto 2) is
                        when "00" => -- Adicionar pontos
                            if comandos(4) = '0' then
                                pontos_t1_reg <= pontos_t1_reg + conv_integer(comandos(1 downto 0));
                            else
                                pontos_t2_reg <= pontos_t2_reg + conv_integer(comandos(1 downto 0));
                            end if;
                        when others => null;
                    end case;
                end if;
            end if;
        end if;
        exec_anterior <= exec;
    end process;

    -- Saídas
    pontos_t1 <= pontos_t1_reg;
    pontos_t2 <= pontos_t2_reg;
end Comportamento;
