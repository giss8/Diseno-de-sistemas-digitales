library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REGISTRO is
    GENERIC(N: INTEGER := 8);
    Port ( D : in STD_LOGIC_VECTOR (N-1 downto 0);
           ES : in STD_LOGIC;
           OPER : in STD_LOGIC_VECTOR (1 downto 0);
           OSC_CLK, CLR : in STD_LOGIC;
           LCLR, LES: out STD_LOGIC;
           LOPER: out STD_LOGIC_VECTOR(1 downto 0);
           Q : inout STD_LOGIC_VECTOR (N-1 downto 0));
end REGISTRO;

architecture PROGRAMA of REGISTRO is
SIGNAL CONT: INTEGER RANGE 0 TO 104857600 - 1;
SIGNAL CLK: STD_LOGIC;

begin
    LCLR <= CLR;
    LES <= ES;
    LOPER <= OPER;

    PDIV: PROCESS(OSC_CLK, CLR)
    BEGIN
        IF(CLR = '1') THEN
            CLK <= '0';
            CONT <= 0;
        ELSIF(OSC_CLK'EVENT AND OSC_CLK = '1') THEN
            CONT <= CONT + 1;
            IF(CONT = 0) THEN
                CLK <= NOT CLK;
            END IF;
        END IF;
    END PROCESS PDIV;

    PREG: PROCESS(CLK,CLR)
    BEGIN
        IF(CLR = '1') THEN
            Q <= (OTHERS=>'0');
        ELSIF(CLK'EVENT AND CLK = '1')THEN
            FOR I IN 0 TO N-1 LOOP
                IF(I=0)THEN
                    Q(I) <= (Q(I) AND NOT OPER(1) AND NOT OPER(0)) OR
                            (D(I) AND NOT OPER(1) AND OPER(0)) OR
                            (ES AND OPER(1) AND NOT OPER(0)) OR
                            (Q(I+1) AND OPER(1) AND OPER(0));
                ELSIF (I=N-1)THEN
                    Q(I) <= (Q(I) AND NOT OPER(1) AND NOT OPER(0)) OR
                            (D(I) AND NOT OPER(1) AND OPER(0)) OR
                            (Q(I-1) AND OPER(1) AND NOT OPER(0)) OR
                            (ES AND OPER(1) AND OPER(0));
                ELSE
                    Q(I) <= (Q(I) AND NOT OPER(1) AND NOT OPER(0)) OR
                            (D(I) AND NOT OPER(1) AND OPER(0)) OR
                            (Q(I-1) AND OPER(1) AND NOT OPER(0)) OR
                            (Q(I+1) AND OPER(1) AND OPER(0));
                END IF;
            END LOOP;
        END IF;
    END PROCESS PREG;
         

end PROGRAMA;
