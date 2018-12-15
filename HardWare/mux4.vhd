library IEEE;
use IEEE.std_logic_1164.all;

entity mux4 is
    generic (n: integer := 16);
    port(a, b, c, d : in std_logic_vector(n-1 downto 0);
        s : in std_logic_vector(1 downto 0);
        z : out std_logic_vector (n-1 downto 0));
end entity mux4;

architecture mux4Arch of mux4 is
    begin
        z <= a when s = "00" 
        else b when s = "01"
        else c when s = "10"
        else d when s = "11";
end architecture;