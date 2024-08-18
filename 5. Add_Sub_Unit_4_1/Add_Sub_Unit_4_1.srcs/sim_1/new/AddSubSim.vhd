----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2022 11:37:05 PM
-- Design Name: 
-- Module Name: AddSubSim - Behavioral
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

entity AddSubSim is
--  Port ( );
end AddSubSim;

architecture Behavioral of AddSubSim is
component Add_Sub_Unit_4
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
       B : in STD_LOGIC_VECTOR (3 downto 0);
       AddSubSel : in STD_LOGIC;
       S : out STD_LOGIC_VECTOR (3 downto 0);
       Overflow : out STD_LOGIC;
       Zero : out STD_LOGIC);
end component;

signal A,B,S : STD_LOGIC_VECTOR (3 downto 0);
signal AddSubSel,Overflow,Zero : STD_LOGIC;

begin

UUT : Add_Sub_Unit_4
    PORT MAP(
        A => A,
        B => B,
        AddSubSel => AddSubSel,
        S => S,
        Overflow => Overflow,
        Zero => Zero
    );
    
process
begin

AddSubSel <= '0';
B <= "0001";        --B = 1

A <= "1100";        --Lahiru : 200300A
-- c + 1 = d
wait for 100ns;


A <= "0011";        --Sanjula ; 200323V
-- 3 + 1 = 4
wait for 100ns;

AddSubSel <= '1';
A <= "0001";        --Thejan : 200698X
-- -1 + 1 = 0
wait for 100ns;

A <= "0100";        --Amila : 200196G
-- -4 + 1 = -3 = 1101
wait for 100ns;

AddSubSel <= '0';

A <= "1001";        --Anushna : 200265T
-- 9 + 1 = a

wait;

end process;


end Behavioral;
