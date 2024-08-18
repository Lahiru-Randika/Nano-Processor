----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/10/2022 03:21:17 PM
-- Design Name: 
-- Module Name: Ins_Decoder - Behavioral
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

entity Ins_Decoder is
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
end Ins_Decoder;

architecture Behavioral of Ins_Decoder is
component Decoder_2_to_4
Port ( I : in STD_LOGIC_VECTOR (1 downto 0);
       EN : in STD_LOGIC;
       Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal op_codes : STD_LOGIC_VECTOR (3 downto 0);
signal MOV,ADD,NEG,JZR : STD_LOGIC;
begin
Decoder_2_to_4_0:Decoder_2_to_4
    PORT MAP(
        I => InsBus(1 downto 0),
        EN => '1',
        Y => op_codes        
    );

ADD <= op_codes(0);
NEG <= op_codes(2);
MOV <= op_codes(1);
JZR <= op_codes(3);

Reg_En <= InsBus(4 downto 2);
RegSel_A <= InsBus(4 downto 2);
RegSel_B <= InsBus(7 downto 5);
ImdVal <= InsBus(11 downto 8);
JmpAdd <= InsBus(11 downto 9);

AddSub_Sel <= NEG;
LD_Sel <= MOV;
JmpFlag <= NOT(Reg_Jmp(0) OR Reg_Jmp(1) OR Reg_Jmp(2) OR Reg_Jmp(3)) AND JZR;


end Behavioral;
