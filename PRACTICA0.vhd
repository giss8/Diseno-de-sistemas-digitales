library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PRACTICA0 is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           B : in STD_LOGIC_VECTOR (2 downto 0);
           REF : in STD_LOGIC_VECTOR (2 downto 0);
           SEL : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR(9 downto 0);
           AN : out STD_LOGIC_VECTOR(7 downto 0);
           DISPLAY : out STD_LOGIC_VECTOR (6 downto 0));
end PRACTICA0;

architecture PRACTICA of PRACTICA0 is
SIGNAL SENSOR, CONDICION : STD_LOGIC_VECTOR(2 DOWNTO 0);
CONSTANT SIM_MAY : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000111";
CONSTANT SIM_MEN : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110001";
CONSTANT SIM_IGL : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110111";

begin
    AN <= "11111110";
    LED(2 DOWNTO 0) <= A;
    LED(5 DOWNTO 3) <= B;
    LED(8 DOWNTO 6) <= REF;
    LED(9) <= SEL;
    
    with SEL select
        SENSOR <= A when '0',
                  B when others;
                  
    COMP : PROCESS(SENSOR, REF)
    BEGIN
        IF( SENSOR > REF )THEN
            CONDICION <= "001";
        ELSIF( SENSOR = REF )THEN
            CONDICION <= "010";
        ELSE
            CONDICION <= "100";
        END IF;
    END PROCESS COMP;
    
    DISPLAY <= SIM_MAY WHEN( CONDICION = "001")ELSE
               SIM_IGL WHEN( CONDICION = "010")ELSE  
               SIM_MEN;   

end PRACTICA;
