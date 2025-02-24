library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControladorPtVol is
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
end ControladorPtVol;

architecture Behavioral of ControladorPtVol is
    signal tela : STD_LOGIC_VECTOR(1 downto 0); -- Sinal interno para combinar tela0 e tela1
begin
    -- Combina tela0 e tela1 em um vetor de 2 bits
    tela <= tela1 & tela0;

    process(tela)
    begin
        case tela is
            when "00" =>
                pt0 <= '1';
                pt1 <= '1';
                pt2 <= '0';
                pt3 <= '1';
                pt4 <= '0';
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