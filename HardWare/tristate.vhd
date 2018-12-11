LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity triState is
    generic (n: integer := 16);

    port(A: in std_logic_vector(n-1 downto 0);
        B: out std_logic_vector(n-1 downto 0);
        enable: in std_logic);

end triState;


architecture triStateArch of triState is


    begin

        B <= A when enable = '1'
        else (OTHERS=>'Z');

end architecture;