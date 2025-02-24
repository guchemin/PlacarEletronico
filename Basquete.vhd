library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Basquete is
    Port (
        seletor: in std_logic_vector(1 downto 0);
        comandos: in std_logic_vector(7 downto 0);
        pontos_t1_in, pontos_t2_in: in integer range 0 to 999;
        faltas_t1_in, faltas_t2_in: in integer range 0 to 5;
        reset_posse: in std_logic;
        pausa: in std_logic;
        clk: in std_logic;
        hex0, hex1, hex2, hex3, hex4, hex5: out std_logic_vector(3 downto 0);
		  zera_faltas: out std_logic
    );
end Basquete;

architecture Comportamento of Basquete is
    signal pontos_t1, pontos_t2: integer range 0 to 999 := 0;
    signal faltas_t1, faltas_t2: integer range 0 to 5 := 0;
    signal periodo: integer range 1 to 4 := 1;
    signal minutos: integer range 0 to 10 := 10;
    signal segundos: integer range 0 to 59 := 0;
    signal posse: integer range 0 to 24 := 24;
    signal cronometro_pausado: std_logic := '1';
    signal pausa_invertida: std_logic := '1';
    signal clk_counter: integer range 0 to 999 := 0;
    signal posse_zerada: std_logic := '0';
	 signal mudou_quarto: std_logic := '0';

begin
    process(clk)
    begin
        if falling_edge(clk) then
            if seletor /= "00" then
                pontos_t1 <= 0;
                pontos_t2 <= 0;
                faltas_t1 <= 0;
                faltas_t2 <= 0;
                periodo <= 1;
                minutos <= 10;
                segundos <= 0;
                posse <= 24;
                cronometro_pausado <= '1';
                pausa_invertida <= '0';
                clk_counter <= 0;
                posse_zerada <= '0';
            else
                pontos_t1 <= pontos_t1_in;
                pontos_t2 <= pontos_t2_in;
                faltas_t1 <= faltas_t1_in;
                faltas_t2 <= faltas_t2_in;
                
                if reset_posse = '1' then
                    posse <= 24;
                end if;
            end if;

            if posse = 0 then
                if posse_zerada = '0' then
                    posse <= 24;
                    cronometro_pausado <= '1';
                    pausa_invertida <= not pausa_invertida;
                    posse_zerada <= '1';
                end if;
            else
                posse_zerada <= '0';
            end if;

            if (pausa_invertida = '0' and pausa = '0') or (pausa_invertida = '1' and pausa = '1') then
                cronometro_pausado <= '0';
            else
                cronometro_pausado <= '1';
            end if;
				
				mudou_quarto <= '0';

            if cronometro_pausado = '0' then
                clk_counter <= clk_counter + 1;
                if clk_counter = 999 then
                    clk_counter <= 0;
						  if posse > 0 then
						 	  posse <= posse - 1;
						  end if;
                    if minutos > 0 or segundos > 0 then
                        if segundos = 0 then
                            minutos <= minutos - 1;
                            segundos <= 59;
                        else
                            segundos <= segundos - 1;
                        end if;
                    elsif periodo < 4 then
						      mudou_quarto <= '1';
                        periodo <= periodo + 1;
                        minutos <= 10;
                        segundos <= 0;
                        cronometro_pausado <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;

    process(comandos(7 downto 6))
    begin
        case comandos(7 downto 6) is
            when "00" => -- Tela de pontuação
                hex5 <= conv_std_logic_vector(pontos_t1 / 100, 4);
                hex4 <= conv_std_logic_vector((pontos_t1 / 10) mod 10, 4);
                hex3 <= conv_std_logic_vector(pontos_t1 mod 10, 4);
                hex2 <= conv_std_logic_vector(pontos_t2 / 100, 4);
                hex1 <= conv_std_logic_vector((pontos_t2 / 10) mod 10, 4);
                hex0 <= conv_std_logic_vector(pontos_t2 mod 10, 4);
            when "01" => -- Tela de cronômetro
                hex5 <= conv_std_logic_vector(minutos / 10, 4);
                hex4 <= conv_std_logic_vector(minutos mod 10, 4);
                hex3 <= conv_std_logic_vector(segundos / 10, 4);
                hex2 <= conv_std_logic_vector(segundos mod 10, 4);
                hex1 <= conv_std_logic_vector(posse / 10, 4);
                hex0 <= conv_std_logic_vector(posse mod 10, 4);
            when "10" => -- Tela de faltas
                hex5 <= conv_std_logic_vector(faltas_t1, 4);
                hex4 <= "1101";
                hex3 <= "1111";
                hex2 <= conv_std_logic_vector(periodo, 4);
                hex1 <= "1101";
                hex0 <= conv_std_logic_vector(faltas_t2, 4);
            when others =>
                hex5 <= "1101";
                hex4 <= "1101";
                hex3 <= "1101";
                hex2 <= "1101";
                hex1 <= "1101";
                hex0 <= "1101";
        end case;
    end process;
	 
	 zera_faltas <= mudou_quarto;

end Comportamento;