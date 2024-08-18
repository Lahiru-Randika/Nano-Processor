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

entity Nanoprocessor is
    Port ( Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           Reg7_out : out STD_LOGIC_VECTOR (3 downto 0);
           S_7Seg : out STD_LOGIC_VECTOR (6 downto 0);
           Anode : out STD_LOGIC_VECTOR (3 downto 0);
           overflow : out STD_LOGIC;
           zero : out STD_LOGIC);
end Nanoprocessor;

architecture Behavioral of Nanoprocessor is

component Slow_Clk
Port ( Clk_in : in STD_LOGIC;
       Clk_out : out STD_LOGIC);
end component;


component ProgramCounter
Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
       Clk : in STD_LOGIC;
       Res : in STD_LOGIC;
       M : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component Mux_2_way_3_bit
Port ( R0 : in STD_LOGIC_VECTOR (2 downto 0);
       R1 : in STD_LOGIC_VECTOR (2 downto 0);
       S : in STD_LOGIC;
       Y : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component RCA_3
Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
       S : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component ProgramRom
Port ( Ins : out STD_LOGIC_VECTOR (11 downto 0);
       MemSel : in STD_LOGIC_VECTOR (2 downto 0));
end component;

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

component Mux_2_way_4_bit
Port ( R0 : in STD_LOGIC_VECTOR (3 downto 0);
       R1 : in STD_LOGIC_VECTOR (3 downto 0);
       LS : in STD_LOGIC;
       Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component RegisterBank
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
end component;

component Mux_8_way_4_bit
Port ( R0 : in STD_LOGIC_VECTOR (3 downto 0);
       R1 : in STD_LOGIC_VECTOR (3 downto 0);
       R2 : in STD_LOGIC_VECTOR (3 downto 0);
       R3 : in STD_LOGIC_VECTOR (3 downto 0);
       R4 : in STD_LOGIC_VECTOR (3 downto 0);
       R5 : in STD_LOGIC_VECTOR (3 downto 0);
       R6 : in STD_LOGIC_VECTOR (3 downto 0);
       R7 : in STD_LOGIC_VECTOR (3 downto 0);
       S : in STD_LOGIC_VECTOR (2 downto 0);
       Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Add_Sub_Unit_4
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
       B : in STD_LOGIC_VECTOR (3 downto 0);
       AddSubSel : in STD_LOGIC;
       S : out STD_LOGIC_VECTOR (3 downto 0);
       Overflow : out STD_LOGIC;
       Zero : out STD_LOGIC);
end component;

component LUT_16_7
Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
       data : out STD_LOGIC_VECTOR (6 downto 0));
end component;



signal slow_Clk_out : STD_LOGIC;
signal RegSel_A_out,RegSel_B_out : STD_LOGIC_VECTOR (2 downto 0);
signal R0_out,R1_out,R2_out,R3_out,R4_out,R5_out,R6_out,R7_out : STD_LOGIC_VECTOR (3 downto 0);
signal M_out,RCA_3_out,Mux_out_3bit,Jmp_Add_out,Reg_En_out : STD_LOGIC_VECTOR (2 downto 0);
signal Jmp_flag_out,LD_Sel_out,AddSub_Sel_out : STD_LOGIC;
signal Ins_out : STD_LOGIC_VECTOR (11 downto 0);
signal Mux_out_4bit_8way_A,Mux_out_4bit_8way_B,Mux_out_4bit_2way,AddSub_out,ImdVal_out : STD_LOGIC_VECTOR (3 downto 0);

begin

Slow_Clk_0:Slow_Clk
    PORT MAP(
        Clk_in => Clk,
        Clk_out => slow_Clk_out
    );

ProgramCounter_0:ProgramCounter
    PORT MAP(
        D => Mux_out_3bit,
        Clk => slow_Clk_out,
        Res => Res,
        M => M_out
    );
Mux_2_way_3_bit_0:Mux_2_way_3_bit
    PORT MAP(
        R0 => RCA_3_out,
        R1 => Jmp_Add_out,
        S => Jmp_flag_out,
        Y => Mux_out_3bit
    );
RCA_3_0 :RCA_3
    PORT MAP(
        A => M_out,
        S => RCA_3_out
    );
    
ProgramRom_0:ProgramRom
    PORT MAP(
        Ins => Ins_out,
        MemSel => M_out
    );
    
Ins_Decoder_0:Ins_Decoder
    PORT MAP(
        InsBus => Ins_out,
        Reg_Jmp => Mux_out_4bit_8way_A,
        JmpAdd => Jmp_Add_out,
        JmpFlag => Jmp_flag_out,
        ImdVal => ImdVal_out,
        LD_Sel => LD_Sel_out,
        Reg_En => Reg_En_out,
        RegSel_A => RegSel_A_out,
        RegSel_B => RegSel_B_out,
        AddSub_Sel => AddSub_Sel_out
    );
Mux_2_way_4_bit_0:Mux_2_way_4_bit
    PORT MAP(
        R0 => AddSub_out,
        R1 => ImdVal_out,
        LS => LD_Sel_out,
        Y => Mux_out_4bit_2way        
    );
RegisterBank_0:RegisterBank
    PORT MAP(
        Clk => slow_Clk_out,
        Res => Res,
        D => Mux_out_4bit_2way,
        RegSel => Reg_En_out,
        R0 => R0_out,
        R1 => R1_out,
        R2 => R2_out,
        R3 => R3_out,
        R4 => R4_out,
        R5 => R5_out,
        R6 => R6_out,
        R7 => R7_out        
    );
    
Mux_8_way_4_bit_A : Mux_8_way_4_bit
    PORT MAP(
        R0 => R0_out,
        R1 => R1_out,
        R2 => R2_out,
        R3 => R3_out,
        R4 => R4_out,
        R5 => R5_out,
        R6 => R6_out,
        R7 => R7_out,
        S => RegSel_A_out,
        Y => Mux_out_4bit_8way_A
    );
Mux_8_way_4_bit_B : Mux_8_way_4_bit
        PORT MAP(
            R0 => R0_out,
            R1 => R1_out,
            R2 => R2_out,
            R3 => R3_out,
            R4 => R4_out,
            R5 => R5_out,
            R6 => R6_out,
            R7 => R7_out,
            S => RegSel_B_out,
            Y => Mux_out_4bit_8way_B
        );
Add_Sub_Unit_4_0:Add_Sub_Unit_4
    PORT MAP(
        A => Mux_out_4bit_8way_A,
        B => Mux_out_4bit_8way_B,
        AddSubSel => AddSub_Sel_out,
        S => AddSub_out,
        overflow => overflow,
        zero => zero
        
    );
    
LUT_16_7_0:LUT_16_7
    PORT MAP(
        address => R7_out,
        data => S_7Seg
    );

    
Reg7_out <= R7_out;
Anode <= "1110";

end Behavioral;
