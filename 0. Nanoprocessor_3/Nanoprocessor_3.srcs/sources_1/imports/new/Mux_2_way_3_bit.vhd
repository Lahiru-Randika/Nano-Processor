----------------------------------------------------------------------------------
-- Company: Lahiru Randika & Pamudu Nayanga
-- Engineer: 
-- 
-- Create Date:
-- Design Name: 
-- Module Name:
-- Project Name: Nano-Processor 
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

entity Mux_2_way_3_bit is
    Port ( R0 : in STD_LOGIC_VECTOR (2 downto 0);
           R1 : in STD_LOGIC_VECTOR (2 downto 0);
           S : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (2 downto 0));
end Mux_2_way_3_bit;

architecture Behavioral of Mux_2_way_3_bit is
component Mux_2_to_1
    Port ( D : in STD_LOGIC_VECTOR (1 downto 0);
       S : in STD_LOGIC;
       Y : out STD_LOGIC);
end component;


begin

Mux_2_to_1_0 : Mux_2_to_1
    PORT MAP(
     D(0) => R0(0),
     D(1) => R1(0),
     S => S,
     Y => Y(0)
    );

Mux_2_to_1_1 : Mux_2_to_1
    PORT MAP(
     D(0) => R0(1),
     D(1) => R1(1),
     S => S,
     Y => Y(1)
    );

Mux_2_to_1_2 : Mux_2_to_1
    PORT MAP(
     D(0) => R0(2),
     D(1) => R1(2),
     S => S,
     Y => Y(2)
    );




end Behavioral;
