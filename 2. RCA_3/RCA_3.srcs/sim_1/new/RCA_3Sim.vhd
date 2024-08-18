----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2022 01:39:25 PM
-- Design Name: 
-- Module Name: RCA_3Sim - Behavioral
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

entity RCA_3Sim is
--  Port ( );
end RCA_3Sim;

architecture Behavioral of RCA_3Sim is

component RCA_3
Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
       S : out STD_LOGIC_VECTOR (2 downto 0));
       
end component;

signal A,S : STD_LOGIC_VECTOR (2 downto 0);

begin
UUT : RCA_3
    PORT MAP(
       A => A,
       S => S
    );

process
begin

A <= "000";
wait for 100ns;

A <= "101";
wait for 100ns;

A <= "011";
wait for 100ns;

A <= "111";

wait;

end process;

end Behavioral;
