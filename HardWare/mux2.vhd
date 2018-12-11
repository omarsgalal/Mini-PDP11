library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is
    generic (n: integer := 16);
    port(a, b : in std_logic_vector(n-1 downto 0);
        s : in std_logic;
        z : out std_logic_vector (n-1 downto 0));
end entity mux2;

architecture mux2Arch of mux2 is
    begin
        z <= a when s = '0' else b;
end architecture;