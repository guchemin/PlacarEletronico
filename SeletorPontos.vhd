library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SeletorPontos is
    Port (
		  pt_seletor : in STD_LOGIC_VECTOR(1 downto 0);
        pt_basquete : in STD_LOGIC_VECTOR(5 downto 0);
        pt_volei : in STD_LOGIC_VECTOR(5 downto 0);
        pt_xadrez : in STD_LOGIC_VECTOR(5 downto 0);
        pt_saida : out STD_LOGIC_VECTOR(5 downto 0)
    );
end SeletorPontos;

architecture Behavioral of SeletorPontos is
begin
    process (pt_seletor, pt_basquete, pt_volei, pt_xadrez)
    begin
        case pt_seletor is
            when "00" => pt_saida <= pt_basquete;
            when "01" => pt_saida <= pt_volei;
            when "10" => pt_saida <= pt_xadrez;
            when others => pt_saida <= (others => '0');
        end case;
    end process;
end Behavioral;