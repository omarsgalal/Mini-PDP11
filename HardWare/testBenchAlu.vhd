library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
entity testALU is

end entity;
ARCHITECTURE testAluArch of testALU is

component alu is
    generic(n: integer := 16;
            m: integer := 5);

    port(
        A, B: in std_logic_vector(n-1 downto 0);
        F: out std_logic_vector(n-1 downto 0);
        operationControl: in std_logic_vector(m-1 downto 0);
        flagIn: in std_logic_vector(n-1 downto 0);
        flagOut: out std_logic_vector(n-1 downto 0));
end component;

	signal A, B:  std_logic_vector(15 downto 0);
	signal F:  std_logic_vector(15 downto 0);
	signal operationControl:  std_logic_vector(4 downto 0);
	signal flagIn:  std_logic_vector(15 downto 0);
	signal flagOut:  std_logic_vector(15 downto 0);
begin


c: alu port map(A,B,F,operationControl,flagIn,flagOut);
process
	begin
A<=X"1234";
B<=X"5678";
flagIn<=X"1000";

 for i in 1 to 20 LOOP
	operationControl <= std_logic_vector(to_unsigned(i,5));
	wait  for 100 ps;

end loop;
wait;
end process;

end ARCHITECTURE;





