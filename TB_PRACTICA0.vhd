library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity PRACTICA0_tb is
end;

architecture bench of PRACTICA0_tb is

  component PRACTICA0
      Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
             B : in STD_LOGIC_VECTOR (2 downto 0);
             REF : in STD_LOGIC_VECTOR (2 downto 0);
             SEL : in STD_LOGIC;
             DISPLAY : out STD_LOGIC_VECTOR (6 downto 0));
  end component;

  signal A: STD_LOGIC_VECTOR (2 downto 0);
  signal B: STD_LOGIC_VECTOR (2 downto 0);
  signal REF: STD_LOGIC_VECTOR (2 downto 0);
  signal SEL: STD_LOGIC;
  signal DISPLAY: STD_LOGIC_VECTOR (6 downto 0);

begin

  uut: PRACTICA0 port map ( A       => A,
                            B       => B,
                            REF     => REF,
                            SEL     => SEL,
                            DISPLAY => DISPLAY );

  stimulus: process
  begin
     
     A <= "101";
     B <= "011";
     REF <= "100";
     SEL <= '0';
     
     WAIT FOR 20ns;
     
     A <= "101";
     B <= "011";
     REF <= "100";
     SEL <= '1';
   
    wait;
  end process;


end;