library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ChessClock is
    Port (
        clk : in STD_LOGIC; -- Clock de 1kHz
        seletor : in STD_LOGIC_VECTOR(1 downto 0); -- Seletor de funcionamento
        modo : in STD_LOGIC_VECTOR(3 downto 0); -- Modo de jogo
        set_config : in STD_LOGIC; -- Sinal para configurar o tempo
        jogador : in STD_LOGIC; -- Jogador atual (0 ou 1)
        hex0 : out STD_LOGIC_VECTOR(3 downto 0); -- Centésimos de segundo
        hex1 : out STD_LOGIC_VECTOR(3 downto 0); -- Décimos de segundo
        hex2 : out STD_LOGIC_VECTOR(3 downto 0); -- Segundos (unidade)
        hex3 : out STD_LOGIC_VECTOR(3 downto 0); -- Segundos (dezena)
        hex4 : out STD_LOGIC_VECTOR(3 downto 0); -- Minutos (unidade)
        hex5 : out STD_LOGIC_VECTOR(3 downto 0)  -- Minutos (dezena)
    );
end ChessClock;

architecture Behavioral of ChessClock is
    signal minutos_jogador0 : integer range 0 to 99 := 1;
    signal segundos_jogador0 : integer range 0 to 59 := 0;
    signal decimos_jogador0 : integer range 0 to 9 := 0;
    signal centesimos_jogador0 : integer range 0 to 9 := 0;

    signal minutos_jogador1 : integer range 0 to 99 := 1;
    signal segundos_jogador1 : integer range 0 to 59 := 0;
    signal decimos_jogador1 : integer range 0 to 9 := 0;
    signal centesimos_jogador1 : integer range 0 to 9 := 0;

    signal incremento : integer range 0 to 30 := 0;
    signal contador : integer range 0 to 999 := 0;
    signal jogador_anterior : STD_LOGIC := '0'; -- Armazena o jogador anterior
    signal tempo_zerado_jogador0 : STD_LOGIC := '0'; -- Indica se o tempo do jogador 0 zerou
    signal tempo_zerado_jogador1 : STD_LOGIC := '0'; -- Indica se o tempo do jogador 1 zerou
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if seletor = "10" then
                if set_config = '1' then
                    -- Configura o tempo e o incremento com base no modo
                    case modo is
                        when "0000" => minutos_jogador0 <= 1; incremento <= 0;
                        when "0001" => minutos_jogador0 <= 1; incremento <= 1;
                        when "0010" => minutos_jogador0 <= 3; incremento <= 0;
                        when "0011" => minutos_jogador0 <= 3; incremento <= 2;
                        when "0100" => minutos_jogador0 <= 5; incremento <= 0;
                        when "0101" => minutos_jogador0 <= 5; incremento <= 3;
                        when "0110" => minutos_jogador0 <= 10; incremento <= 0;
                        when "0111" => minutos_jogador0 <= 10; incremento <= 5;
                        when "1000" => minutos_jogador0 <= 15; incremento <= 0;
                        when "1001" => minutos_jogador0 <= 15; incremento <= 7;
                        when "1010" => minutos_jogador0 <= 30; incremento <= 0;
                        when "1011" => minutos_jogador0 <= 30; incremento <= 10;
                        when "1100" => minutos_jogador0 <= 60; incremento <= 0;
                        when "1101" => minutos_jogador0 <= 60; incremento <= 20;
                        when "1110" => minutos_jogador0 <= 90; incremento <= 0;
                        when "1111" => minutos_jogador0 <= 90; incremento <= 30;
                        when others => null;
                    end case;
                    minutos_jogador1 <= minutos_jogador0;
                    segundos_jogador0 <= 0;
                    segundos_jogador1 <= 0;
                    decimos_jogador0 <= 0;
                    decimos_jogador1 <= 0;
                    centesimos_jogador0 <= 0;
                    centesimos_jogador1 <= 0;
                    jogador_anterior <= jogador; -- Atualiza o jogador anterior
                    tempo_zerado_jogador0 <= '0'; -- Reseta o sinal de tempo zerado
                    tempo_zerado_jogador1 <= '0'; -- Reseta o sinal de tempo zerado
                else
                    -- Verifica se o jogador mudou
                    if jogador /= jogador_anterior then
                        -- Aplica o incremento ao jogador que acabou de jogar
                        if jogador_anterior = '0' then
                            segundos_jogador0 <= segundos_jogador0 + incremento;
                        else
                            segundos_jogador1 <= segundos_jogador1 + incremento;
                        end if;
                        jogador_anterior <= jogador; -- Atualiza o jogador anterior
                    end if;

                    -- Ajusta os segundos e minutos se ultrapassarem 59
                    if segundos_jogador0 >= 60 then
                        segundos_jogador0 <= segundos_jogador0 - 60;
                        minutos_jogador0 <= minutos_jogador0 + 1;
                    end if;
                    if segundos_jogador1 >= 60 then
                        segundos_jogador1 <= segundos_jogador1 - 60;
                        minutos_jogador1 <= minutos_jogador1 + 1;
                    end if;

                    -- Verifica se o tempo de algum jogador zerou
                    if minutos_jogador0 = 0 and segundos_jogador0 = 0 and decimos_jogador0 = 0 and centesimos_jogador0 = 0 then
                        tempo_zerado_jogador0 <= '1'; -- Tempo do jogador 0 zerou
                    end if;
                    if minutos_jogador1 = 0 and segundos_jogador1 = 0 and decimos_jogador1 = 0 and centesimos_jogador1 = 0 then
                        tempo_zerado_jogador1 <= '1'; -- Tempo do jogador 1 zerou
                    end if;

                    -- Tempo está correndo
                    if contador = 9 then
                        contador <= 0;
                        if jogador = '0' then
                            if centesimos_jogador0 = 0 then
                                if decimos_jogador0 = 0 then
                                    if segundos_jogador0 = 0 then
                                        if minutos_jogador0 = 0 then
                                            -- Tempo esgotado para o jogador 0
                                        else
                                            minutos_jogador0 <= minutos_jogador0 - 1;
                                            segundos_jogador0 <= 59;
                                            decimos_jogador0 <= 9;
                                            centesimos_jogador0 <= 9;
                                        end if;
                                    else
                                        segundos_jogador0 <= segundos_jogador0 - 1;
                                        decimos_jogador0 <= 9;
                                        centesimos_jogador0 <= 9;
                                    end if;
                                else
                                    decimos_jogador0 <= decimos_jogador0 - 1;
                                    centesimos_jogador0 <= 9;
                                end if;
                            else
                                centesimos_jogador0 <= centesimos_jogador0 - 1;
                            end if;
                        else
                            if centesimos_jogador1 = 0 then
                                if decimos_jogador1 = 0 then
                                    if segundos_jogador1 = 0 then
                                        if minutos_jogador1 = 0 then
                                            -- Tempo esgotado para o jogador 1
                                        else
                                            minutos_jogador1 <= minutos_jogador1 - 1;
                                            segundos_jogador1 <= 59;
                                            decimos_jogador1 <= 9;
                                            centesimos_jogador1 <= 9;
                                        end if;
                                    else
                                        segundos_jogador1 <= segundos_jogador1 - 1;
                                        decimos_jogador1 <= 9;
                                        centesimos_jogador1 <= 9;
                                    end if;
                                else
                                    decimos_jogador1 <= decimos_jogador1 - 1;
                                    centesimos_jogador1 <= 9;
                                end if;
                            else
                                centesimos_jogador1 <= centesimos_jogador1 - 1;
                            end if;
                        end if;
                    else
                        contador <= contador + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Conversão para os displays
    process(minutos_jogador0, segundos_jogador0, decimos_jogador0, centesimos_jogador0,
            minutos_jogador1, segundos_jogador1, decimos_jogador1, centesimos_jogador1, jogador,
            tempo_zerado_jogador0, tempo_zerado_jogador1)
    begin
        if tempo_zerado_jogador0 = '1' then
            -- Exibe "000001" quando o tempo do jogador 0 zerar
            hex5 <= "0000";
            hex4 <= "1110";
            hex3 <= "1110";
            hex2 <= "1110";
            hex1 <= "1110";
            hex0 <= "0001";
        elsif tempo_zerado_jogador1 = '1' then
            -- Exibe "100000" quando o tempo do jogador 1 zerar
            hex5 <= "0001";
            hex4 <= "1110";
            hex3 <= "1110";
            hex2 <= "1110";
            hex1 <= "1110";
            hex0 <= "0000";
        else
            -- Exibe o tempo normal
            if jogador = '0' then
                hex5 <= conv_std_logic_vector(minutos_jogador0 / 10, 4);
                hex4 <= conv_std_logic_vector(minutos_jogador0 mod 10, 4);
                hex3 <= conv_std_logic_vector(segundos_jogador0 / 10, 4);
                hex2 <= conv_std_logic_vector(segundos_jogador0 mod 10, 4);
                hex1 <= conv_std_logic_vector(decimos_jogador0, 4);
                hex0 <= conv_std_logic_vector(centesimos_jogador0, 4);
            else
                hex5 <= conv_std_logic_vector(minutos_jogador1 / 10, 4);
                hex4 <= conv_std_logic_vector(minutos_jogador1 mod 10, 4);
                hex3 <= conv_std_logic_vector(segundos_jogador1 / 10, 4);
                hex2 <= conv_std_logic_vector(segundos_jogador1 mod 10, 4);
                hex1 <= conv_std_logic_vector(decimos_jogador1, 4);
                hex0 <= conv_std_logic_vector(centesimos_jogador1, 4);
            end if;
        end if;
    end process;

end Behavioral;