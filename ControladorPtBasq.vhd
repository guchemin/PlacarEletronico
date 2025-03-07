library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControladorPtBasq is
    Port (
        tela1 : in STD_LOGIC; 
        tela0 : in STD_LOGIC; 
        pt0 : out STD_LOGIC;  -- Saída pt0
        pt1 : out STD_LOGIC;  -- Saída pt1
        pt2 : out STD_LOGIC;  -- Saída pt2
        pt3 : out STD_LOGIC;  -- Saída pt3
        pt4 : out STD_LOGIC;  -- Saída pt4
        pt5 : out STD_LOGIC   -- Saída pt5
    );
end ControladorPtBasq;

architecture Behavioral of ControladorPtBasq is
    signal tela : STD_LOGIC_VECTOR(1 downto 0); -- Sinal interno para combinar tela0 e tela1
begin
    -- Combina tela0 e tela1 em um vetor de 2 bits
    tela <= tela1 & tela0;

    process(tela)
    begin
        case tela is
            when "00" =>
                -- Se tela for "00", apenas pt3 será '0', o resto '1'
                pt0 <= '1';
                pt1 <= '1';
                pt2 <= '1';
                pt3 <= '0';
                pt4 <= '1';
                pt5 <= '1';
            when "01" =>
                -- Se tela for "01", pt2 e pt4 serão '0', o resto '1'
                pt0 <= '1';
                pt1 <= '1';
                pt2 <= '0';
                pt3 <= '1';
                pt4 <= '0';
                pt5 <= '1';
            when "10" =>
                -- Se tela for "10", todos os pts serão '1'
                pt0 <= '1';
                pt1 <= '1';
                pt2 <= '1';
                pt3 <= '1';
                pt4 <= '1';
                pt5 <= '1';
            when others =>
                -- Para qualquer outro valor de tela, todos os pts serão '1' (opcional)
                pt0 <= '1';
                pt1 <= '1';
                pt2 <= '1';
                pt3 <= '1';
                pt4 <= '1';
                pt5 <= '1';
        end case;
    end process;
end Behavioral;