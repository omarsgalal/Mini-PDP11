LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity decoder is

    generic(n: integer := 3);

    port(enable: in std_logic;
        A: in std_logic_vector(n-1 downto 0);
        B: out std_logic_vector((2**n) -1 downto 0));

end decoder;


architecture myDecoder of decoder is

    begin

        process (A, enable) is
            begin
                    
                B <= (others => '0');
                if (enable = '1') then
                    B(to_integer(unsigned(A))) <= '1'; 
                end if;

        end process;

end architecture;