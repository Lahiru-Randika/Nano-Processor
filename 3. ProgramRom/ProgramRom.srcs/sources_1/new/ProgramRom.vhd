----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2022 07:24:52 AM
-- Design Name: 
-- Module Name: ProgramRom - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramRom is
    Port ( Ins : out STD_LOGIC_VECTOR (11 downto 0);
           MemSel : in STD_LOGIC_VECTOR (2 downto 0));
end ProgramRom;

architecture Behavioral of ProgramRom is

type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
signal program_ROM : rom_type := (
"000000011101", --ROM 0, MOVI R7,0 ; R7 <- 0        : R7=0              :101110000000
"100000010001", --ROM 1, MOVI R1,1 ; R1 <- 1        : R7=0,R1=1         :100010000001
"100000001001", --ROM 2, MOVI R2,1 ; R2 <- 1        : R7=0,R1=1,R2=1    :100100000001
"000001011100", --ROM 3, ADD R7,R2 ; R7 <- R7 + R2  : R7=1,R1=1,R2=1    :001110100000
"000010001000", --ROM 4, ADD R2,R1 ; R2 <- R2 + R1  : R7=1,R1=1,R2=2    :000100010000
"000001011100", --ROM 5, ADD R7,R2 ; R7 <- R7 + R2  : R7=3,R1=1,R2=2    :001110100000
"000010001000", --ROM 6, ADD R2,R1 ; R2 <- R2 + R1  : R7=3,R1=1,R2=3    :000100010000
"000001011100"  --ROM 7, ADD R7,R2 ; R7 <- R7 + R2  : R7=6,R1=1,R2=3    :001110100000

);

begin

Ins <= program_ROM(to_integer(unsigned(MemSel)));


end Behavioral;
