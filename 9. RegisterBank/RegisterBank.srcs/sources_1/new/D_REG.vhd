----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/09/2022 11:44:29 PM
-- Design Name: 
-- Module Name: D_REG - Behavioral
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

entity D_REG is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           EN : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0);
           Res : in STD_LOGIC);
end D_REG;

architecture Behavioral of D_REG is
component Reg_D_FF
    Port ( D : in STD_LOGIC;
       Res : in STD_LOGIC;
       Clk : in STD_LOGIC;
       En : in STD_LOGIC;
       Q : out STD_LOGIC;
       Qbar : out STD_LOGIC);
end component;

begin
D_FF_0 : Reg_D_FF
    PORT MAP(
    D => D(0),
    Clk => Clk,
    Res => Res,
    Q => Q(0),
    En => EN
    
    );

D_FF_1 : Reg_D_FF
    PORT MAP(
    D => D(1),
    Clk => Clk,
    Res => Res,
    Q => Q(1),
    En => EN
    
    );

D_FF_2 : Reg_D_FF
    PORT MAP(
    D => D(2),
    Clk => Clk,
    Res => Res,
    Q => Q(2),
    En => EN
    
    );

D_FF_3 : Reg_D_FF
    PORT MAP(
    D => D(3),
    Clk => Clk,
    Res => Res,
    Q => Q(3),
    En => EN
    
    );






end Behavioral;
