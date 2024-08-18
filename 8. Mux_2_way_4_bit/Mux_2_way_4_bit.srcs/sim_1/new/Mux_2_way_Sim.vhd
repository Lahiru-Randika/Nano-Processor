----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2022 11:28:33 AM
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

component Mux_2_way_4_bit
Port ( R0 : in STD_LOGIC_VECTOR (3 downto 0);
       R1 : in STD_LOGIC_VECTOR (3 downto 0);
       --EN : in STD_LOGIC;
       LS : in STD_LOGIC;
       Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal R0,R1,Y : STD_LOGIC_VECTOR (3 downto 0);
signal LS : STD_LOGIC;
begin

UUT : Mux_2_way_4_bit
    PORT MAP(
        R0 => R0,
        R1 => R1,
        LS => LS,
        Y => Y
    );

process
begin

R0 <= "1010";
R1 <= "1110";

LS <= '0';
wait for 500ns;

LS <= '1';

wait;

end process;


end Behavioral;
