----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2022 10:55:01 AM
-- Design Name: 
-- Module Name: Mux_8_way_Sim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux_8_way_Sim is
--  Port ( );
end Mux_8_way_Sim;

architecture Behavioral of Mux_8_way_Sim is

component Mux_8_way_4_bit
Port ( R0 : in STD_LOGIC_VECTOR (3 downto 0);
       R1 : in STD_LOGIC_VECTOR (3 downto 0);
       R2 : in STD_LOGIC_VECTOR (3 downto 0);
       R3 : in STD_LOGIC_VECTOR (3 downto 0);
       R4 : in STD_LOGIC_VECTOR (3 downto 0);
       R5 : in STD_LOGIC_VECTOR (3 downto 0);
       R6 : in STD_LOGIC_VECTOR (3 downto 0);
       R7 : in STD_LOGIC_VECTOR (3 downto 0);
       S : in STD_LOGIC_VECTOR (2 downto 0);
       Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal S : STD_LOGIC_VECTOR (2 downto 0);
signal R0,R1,R2,R3,R4,R5,R6,R7,Y : STD_LOGIC_VECTOR (3 downto 0);

begin
UUT : Mux_8_way_4_bit
    PORT MAP(
        R0 => R0,
        R1 => R1,
        R2 => R2,
        R3 => R3,
        R4 => R4,
        R5 => R5,
        R6 => R6,
        R7 => R7,
        S => S,
        Y => Y
    );

process
begin

R0 <= "0000";   -- read only                    : 0
R1 <= "1100";   -- Lahiru - 200300A : ....1100  : c
R2 <= "0011";   -- Sanjula - 200323V : ....0011 : 3
R3 <= "1010";   -- Thejan - 200698X : ....1010  : a
R4 <= "0100";   -- Amila - 200196G : ....0100   : 4
R5 <= "1001";   -- Anushna - 200265T : ....1001 : 9
R6 <= "1111";   --                              : f
R7 <= "0111";   --                              : 7


S <= "000";
wait for 100ns;

S <= "001";
wait for 100ns;

S <= "010";
wait for 100ns;

S <= "011";
wait for 100ns;

S <= "100";
wait for 100ns;

S <= "101";
wait for 100ns;

S <= "110";
wait for 100ns;

S <= "111";

wait;
end process;

end Behavioral;
