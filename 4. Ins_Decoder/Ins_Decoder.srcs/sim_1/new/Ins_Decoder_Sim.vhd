----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2022 03:46:24 PM
-- Design Name: 
-- Module Name: Ins_Decoder_Sim - Behavioral
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

entity Ins_Decoder_Sim is
--  Port ( );
end Ins_Decoder_Sim;

architecture Behavioral of Ins_Decoder_Sim is
component Ins_Decoder

Port ( InsBus : in STD_LOGIC_VECTOR (11 downto 0);
       Reg_Jmp : in STD_LOGIC_VECTOR (3 downto 0);
       Reg_En : out STD_LOGIC_VECTOR (2 downto 0);
       RegSel_A : out STD_LOGIC_VECTOR (2 downto 0);
       RegSel_B : out STD_LOGIC_VECTOR (2 downto 0);
       ImdVal : out STD_LOGIC_VECTOR (3 downto 0);
       JmpAdd : out STD_LOGIC_VECTOR (2 downto 0);
       JmpFlag : out STD_LOGIC;
       LD_Sel : out STD_LOGIC;
       AddSub_Sel : out STD_LOGIC);

end component;

signal InsBus : STD_LOGIC_VECTOR (11 downto 0);
signal Reg_Jmp,ImdVal : STD_LOGIC_VECTOR (3 downto 0);
signal Reg_En,RegSel_A,RegSel_B,JmpAdd : STD_LOGIC_VECTOR (2 downto 0);
signal JmpFlag,LD_Sel,AddSub_Sel : STD_LOGIC;

begin

UUT : Ins_Decoder
    PORT MAP(
        InsBus => InsBus,
        Reg_Jmp => Reg_Jmp,
        Reg_En => Reg_En,
        RegSel_A => RegSel_A,
        RegSel_B => RegSel_B,
        ImdVal => ImdVal,
        JmpAdd => JmpAdd,
        JmpFlag => JmpFlag,
        LD_Sel => LD_Sel,
        AddSub_Sel => AddSub_Sel
        
    );

process
begin 

    InsBus <= "000000011001";--MOVI R3,0    100110000000
    wait for 100ns;

    InsBus <= "001100010001";--MOVI R1,12   100010001100
    wait for 100ns;

    InsBus <= "010000001001";--MOVI R2,2    100100000010
    wait for 100ns;
    
    InsBus <= "000010001000";--ADD R2,R1    000100010000
    wait for 100ns;

    InsBus <= "000000001010";--NEG R2       010100000000
    wait for 100ns;
    
    Reg_Jmp <= "0000";
    InsBus <= "110000011011";--JZR R3,3     110110000011
    wait for 100ns;
    
    wait;

end process;

end Behavioral;
