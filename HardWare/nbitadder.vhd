library IEEE;
use IEEE.std_logic_1164.all;

entity nbitsAdder is
    generic (n: integer := 16);
    port (
        a, b : in std_logic_vector ( n-1 downto 0);
        cin : in std_logic;
        s : out std_logic_vector ( n-1 downto 0);
        cout : out std_logic);
end entity nbitsAdder;


architecture nbitsAdderArch of nbitsAdder is

    signal temp: std_logic_vector (n-1 downto 0);

    begin

        f0: entity work.fullAdder port map (a(0), b(0), cin, s(0), temp(0));

        loop1: for i in 1 to n-1 generate
            fx: entity work.fullAdder port map (a(i), b(i), temp(i-1), s(i), temp(i));
        end generate;

        cout <= temp(n-1);

end architecture;