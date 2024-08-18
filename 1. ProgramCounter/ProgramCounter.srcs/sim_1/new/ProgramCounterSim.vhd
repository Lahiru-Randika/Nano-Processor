----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2022 10:22:44 PM
-- Design Name: 
-- Module Name: ProgramCounterSim - Behavioral
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

entity ProgramCounterSim is
--  Port ( );
end ProgramCounterSim;

architecture Behavioral of ProgramCounterSim is

component ProgramCounter
Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
       Clk : in STD_LOGIC;
       Res : in STD_LOGIC;
       M : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal D,M : STD_LOGIC_VECTOR (2 downto 0);
signal Clk : STD_LOGIC := '0';
signal Res : STD_LOGIC;
begin

UUT : ProgramCounter
    PORT MAP(
        D => D,
        M => M,
        Clk => Clk,
        Res => Res
    );

process
begin
 wait for 5ns; --100MHz
 Clk <= NOT(Clk);
end process;

process
begin

Res <= '1';
wait for 100ns;

Res <= '0';
D <= "010";
wait for 100ns;

D <= "011";
wait for 100ns;

Res <= '1';
wait;

end process;

end Behavioral;
