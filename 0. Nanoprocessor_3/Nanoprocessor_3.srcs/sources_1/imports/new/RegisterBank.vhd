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

entity RegisterBank is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           Clk : in STD_LOGIC;
           RegSel : in STD_LOGIC_VECTOR (2 downto 0);
           Res : in STD_LOGIC;
           R0 : out STD_LOGIC_VECTOR (3 downto 0);
           R1 : out STD_LOGIC_VECTOR (3 downto 0);
           R2 : out STD_LOGIC_VECTOR (3 downto 0);
           R3 : out STD_LOGIC_VECTOR (3 downto 0);
           R4 : out STD_LOGIC_VECTOR (3 downto 0);
           R5 : out STD_LOGIC_VECTOR (3 downto 0);
           R6 : out STD_LOGIC_VECTOR (3 downto 0);
           R7 : out STD_LOGIC_VECTOR (3 downto 0));
end RegisterBank;

architecture Behavioral of RegisterBank is

--component Slow_Clk
--Port ( Clk_in : in STD_LOGIC;
--       Clk_out : out STD_LOGIC);
--end component;

component D_REG
        Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
       EN : in STD_LOGIC;
       Clk : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR (3 downto 0);
       Res : in STD_LOGIC);
end component;

component Decoder_3_to_8
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal Y_out : STD_LOGIC_VECTOR (7 downto 0);

begin


Decoder_0 : Decoder_3_to_8
    PORT MAP (
        I => RegSel,
        EN => '1',
        Y => Y_out
        
    
    );

D_REG_0 : D_REG
    PORT MAP (
        D => "0000",
        EN => '0',--read only Register
        Clk => Clk,
        Q => R0,
        Res => Res

    );

D_REG_1 : D_REG
    PORT MAP (
        D => D,
        EN => Y_out(1),
        Clk => Clk,
        Q => R1,
        Res => Res

    );


D_REG_2 : D_REG
    PORT MAP (
        D => D,
        EN => Y_out(2),
        Clk => Clk,
        Q => R2,
        Res => Res
    
    );

D_REG_3 : D_REG
    PORT MAP (
        D => D,
        EN => Y_out(3),
        Clk => Clk,
        Q => R3,
        Res => Res

    );

D_REG_4 : D_REG
    PORT MAP (
        D => D,
        EN => Y_out(4),
        Clk => Clk,
        Q => R4,
        Res => Res

    );
    
D_REG_5 : D_REG
        PORT MAP (
            D => D,
            EN => Y_out(5),
            Clk => Clk,
            Q => R5,
            Res => Res
    
        );

D_REG_6 : D_REG
    PORT MAP (
        D => D,
        EN => Y_out(6),
        Clk => Clk,
        Q => R6,
        Res => Res

    );


D_REG_7 : D_REG
    PORT MAP (
        D => D,
        EN => Y_out(7),
        Clk => Clk,
        Q => R7,
        Res => Res

    );



end Behavioral;
