----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2022 07:21:49 PM
-- Design Name: 
-- Module Name: ProgramRomSim - Behavioral
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

entity ProgramRomSim is
--  Port ( );
end ProgramRomSim;

architecture Behavioral of ProgramRomSim is
component ProgramRom
 Port ( Ins : out STD_LOGIC_VECTOR (11 downto 0);
       MemSel : in STD_LOGIC_VECTOR (2 downto 0));
end component;
signal Ins : STD_LOGIC_VECTOR (11 downto 0);
signal MemSel : STD_LOGIC_VECTOR (2 downto 0);
begin
UUT : ProgramRom
    PORT MAP(
        Ins => Ins,
        MemSel => MemSel
    );

process
begin

MemSel <= "000";
wait for 100ns;

MemSel <= "101";
wait for 100ns;

MemSel <= "001";
wait for 100ns;

wait;

end process;

end Behavioral;
