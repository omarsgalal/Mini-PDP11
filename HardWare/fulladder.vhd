library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder is

    port(
        a, b, cin : in std_logic;
        sum, cout : out std_logic);
end entity fullAdder;

architecture fullAdderArch of fullAdder is
    begin
        sum <= (a xor b) xor cin;
        cout <= ((a xor b) and cin ) or (a and b);
end architecture;