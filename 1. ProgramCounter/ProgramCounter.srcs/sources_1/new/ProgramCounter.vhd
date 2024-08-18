----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2022 11:28:56 PM
-- Design Name: 
-- Module Name: ProgramCounter - Behavioral
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

entity ProgramCounter is
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           M : out STD_LOGIC_VECTOR (2 downto 0));
end ProgramCounter;

architecture Behavioral of ProgramCounter is

component D_FF
    Port ( D : in STD_LOGIC;
       Res : in STD_LOGIC;
       Clk : in STD_LOGIC;
       Q : out STD_LOGIC;
       Qbar : out STD_LOGIC);
end component;

signal D0,D1,D2 : STD_LOGIC;

begin

D_FF_0 : D_FF
    PORT MAP(
        D => D(0),
        Res => Res,
        Clk => Clk,
        Q => D0
    );
    
 D_FF_1 : D_FF
    PORT MAP(
        D => D(1),
        Res => Res,
        Clk => Clk,
        Q => D1
    );
    
 D_FF_2 : D_FF
    PORT MAP(
        D => D(2),
        Res => Res,
        Clk => Clk,
        Q => D2
    );

M(0) <= D0;
M(1) <= D1;
M(2) <= D2;


end Behavioral;
