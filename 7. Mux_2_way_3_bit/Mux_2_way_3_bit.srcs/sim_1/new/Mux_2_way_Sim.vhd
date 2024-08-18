----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2022 01:23:37 PM
-- Design Name: 
-- Module Name: Mux_2_way_Sim - Behavioral
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

entity Mux_2_way_Sim is
--  Port ( );
end Mux_2_way_Sim;

architecture Behavioral of Mux_2_way_Sim is

component Mux_2_way_3_bit
Port ( R0 : in STD_LOGIC_VECTOR (2 downto 0);
       R1 : in STD_LOGIC_VECTOR (2 downto 0);
       S : in STD_LOGIC;
       Y : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal S : STD_LOGIC;
signal R0,R1,Y : STD_LOGIC_VECTOR (2 downto 0);
begin
UUT : Mux_2_way_3_bit
    PORT MAP(
        R0 => R0,
        R1 => R1,
        S => S,
        Y => Y
    );

process
begin

R0 <= "101";
R1 <= "110";
S <= '0';

wait for 500ns;

S <= '1';

wait;
end process;


end Behavioral;
