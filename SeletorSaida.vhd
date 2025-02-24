library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SeletorSaida is
    Port (
		  seletor : in STD_LOGIC_VECTOR(1 downto 0);
        basquete : in STD_LOGIC_VECTOR(23 downto 0);
        volei : in STD_LOGIC_VECTOR(23 downto 0);
        xadrez : in STD_LOGIC_VECTOR(23 downto 0);
        saida : out STD_LOGIC_VECTOR(23 downto 0)
    );
end SeletorSaida;

architecture Behavioral of SeletorSaida is
begin
    process (seletor, basquete, volei, xadrez)
    begin
        case seletor is
            when "00" => saida <= basquete;
            when "01" => saida <= volei;
            when "10" => saida <= xadrez;
            when others => saida <= (others => '0');
        end case;
    end process;
end Behavioral;