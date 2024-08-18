----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2022 04:06:39 PM
-- Design Name: 
-- Module Name: NanoProcessor - Behavioral
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

entity NanoProcessor is
  Port ( Clk: in STD_LOGIC;
         Res : in STD_LOGIC;
         Halt : in STD_LOGIC;
         Zero : out STD_LOGIC;
         Overflow : out STD_LOGIC;
         OUT_REG : out STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
end NanoProcessor;

architecture Behavioral of NanoProcessor is

component Adder_3_Bit
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (2 downto 0)
           );
end component;

component ProgramCounter
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC;
           Res: in STD_LOGIC;                        -- SIGNAL TO RESET
           Load : in STD_LOGIC;                      -- SIGNAL TO LOAD 
           Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component twoWay_3Bit_Mux
    Port ( AdderIn : in STD_LOGIC_VECTOR (2 downto 0);
           JumpAdd : in STD_LOGIC_VECTOR (2 downto 0);
           Jump : in STD_LOGIC;
           PC_in : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component Reg_Bank
  Port (
        Reg_En: in STD_LOGIC_VECTOR (2 DOWNTO 0);
        A : in STD_LOGIC_VECTOR (3 DOWNTO 0);
        Clk : in STD_LOGIC;
        RESET_REG_BANK : in STD_LOGIC;
        B0 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
        B1 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
        B2 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
        B3 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
        B4 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
        B5 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
        B6 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
        B7 : out STD_LOGIC_VECTOR (3 DOWNTO 0) 
  );
end component;

component Mux_2_to_4
    Port ( 
        S : in STD_LOGIC;
        D_0: in STD_LOGIC_VECTOR (3 downto 0);
        D_1: in STD_LOGIC_VECTOR (3 downto 0);
        Y: out STD_LOGIC_VECTOR (3 downto 0)
    );
end component;

--component Program_ROM
--   Port ( Mem_address : in STD_LOGIC_VECTOR (2 downto 0);
--      Instruction : out STD_LOGIC_VECTOR (11 downto 0));
--end component;

component SAMPLE_CODE_ROM
   Port ( Mem_address : in STD_LOGIC_VECTOR (2 downto 0);
      Instruction : out STD_LOGIC_VECTOR (11 downto 0));
end component;

-- component ProgramRomAdd
--     Port ( Mem_address : in STD_LOGIC_VECTOR (2 downto 0);
--        Instruction : out STD_LOGIC_VECTOR (11 downto 0));
-- end component;

component Instruction_decoder
    Port ( Instruction : in STD_LOGIC_VECTOR (11 downto 0);
           Reg_en : out STD_LOGIC_VECTOR (2 downto 0);
           Load_sel : out STD_LOGIC; -- 4 way to 4 bit mux needed
           Imd_val : out STD_LOGIC_VECTOR (3 downto 0);
           Reg_selA : out STD_LOGIC_VECTOR (2 downto 0);
           Reg_selB : out STD_LOGIC_VECTOR (2 downto 0);
           Add_sub_sel : out STD_LOGIC;
           Jump : out STD_LOGIC;
           Jump_address : out STD_LOGIC_VECTOR (2 downto 0);
           -- HALT THE INSTRUCTION
           HALT : out STD_LOGIC;
           -- SELECT IF WE HAVE TO JUMP
           JMP_SEL : in STD_LOGIC
           );
end component;

component RCA_4
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Ctrl: in STD_LOGIC;
           Zero : out STD_LOGIC;
           Overflow : out STD_LOGIC);
end component;

component MUX_8_way_4_bit is
    Port ( D0 : in STD_LOGIC_VECTOR (3 downto 0);
           D1 : in STD_LOGIC_VECTOR (3 downto 0);
           D2 : in STD_LOGIC_VECTOR (3 downto 0);
           D3 : in STD_LOGIC_VECTOR (3 downto 0);
           D4 : in STD_LOGIC_VECTOR (3 downto 0);
           D5 : in STD_LOGIC_VECTOR (3 downto 0);
           D6 : in STD_LOGIC_VECTOR (3 downto 0);
           D7 : in STD_LOGIC_VECTOR (3 downto 0);
           Y_out : out STD_LOGIC_VECTOR (3 downto 0);
           S : in STD_LOGIC_VECTOR (2 downto 0));
end component;

--SIGNAL slowClk: std_logic;
SIGNAL S0, S1, S2, ProgCount_Input: STD_LOGIC_VECTOR(2 DOWNTO 0);

-- PROGRAM ROM
SIGNAL PR_OUT : STD_LOGIC_VECTOR (11 DOWNTO 0);

-- INSTRUCTION DECODER
SIGNAL Reg_en0, Reg_selA0, Reg_selB0, Jump_address0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL Load_sel0, Add_sub_sel0, JMP : STD_LOGIC;
SIGNAL Imd_val0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL mux_a_en, mux_b_en, MUX_EN_2TO4 : STD_LOGIC;
SIGNAL haltInsDec : STD_LOGIC;
SIGNAL ZERO_FLAG : STD_LOGIC;

-- REGISTER BANK
SIGNAL A0 : STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL B00, B01, B02, B03, B04, B05, B06, B07 : STD_LOGIC_VECTOR (3 DOWNTO 0);

-- ADD/SUB
SIGNAL add_out, A, B : STD_LOGIC_VECTOR (3 DOWNTO 0);

-- PROGRAM COUNTER
SIGNAL LoadProgRom : STD_LOGIC;


SIGNAL cout : STD_LOGIC;

begin
        
    Adder3Bit0: Adder_3_Bit
        port map(
            A => S0,        -- INPUT FROM THE PC
            S => S1         -- INCREMENTED VALUE
        );
        
    mux2to10: twoWay_3Bit_Mux
        port map(
            AdderIn => S1,        
            JumpAdd => Jump_address0,    
            Jump => JMP,                      
            PC_in => ProgCount_Input
        );
        
     Mux_2_to_4_0: Mux_2_to_4
        port map(
            S => Load_sel0,
            D_0 => add_out,
            D_1 => Imd_val0,
            Y => A0
        );
    
    ProgramCounter0: ProgramCounter
        port map(
            D => ProgCount_Input,          -- input
            Clk => Clk,
            Q => S0,                       -- output
            Res => Res,                    -- RESET THE VALUE TO 000
            Load => LoadProgRom
        );
    
    Program_ROM0: SAMPLE_CODE_ROM
        port map(
           Mem_address => S2,
           Instruction => PR_OUT
        );
    
    Instruction_decoder0: Instruction_decoder
        port map(
            Instruction => PR_OUT,        
            Reg_en => Reg_en0,
            Load_sel => Load_sel0,
            Imd_val => Imd_val0,
            Reg_selA => Reg_selA0,
            Reg_selB => Reg_selB0,
            Add_sub_sel => Add_sub_sel0,
            Jump_address => Jump_address0,
            Jump => JMP,
            HALT => haltInsDec,
            JMP_SEL => ZERO_FLAG
        );
        
     Reg_Bank0: Reg_Bank
        port map(
            Reg_En => Reg_en0,
            A => A0,
            Clk => Clk,
            RESET_REG_BANK => Res,
            B0 => B00,
            B1 => B01, 
            B2 => B02,
            B3 => B03,
            B4 => B04, 
            B5 => B05, 
            B6 => B06, 
            B7 => B07
        );
        
     RCA_40: RCA_4
        port map(
            A => A,
            B => B,
            Ctrl => Add_sub_sel0,
            S => add_out,
            Zero => ZERO_FLAG,
            Overflow => Overflow
        );
        
     MUX_8_way_4_bit0: MUX_8_way_4_bit
        port map(D0 => B00,
                D1 => B01,
                D2 => B02,
                D3 => B03,
                D4 => B04,
                D5 => B05,
                D6 => B06,
                D7 => B07,
                Y_out =>a,
                S =>Reg_selA0 
        );
    MUX_8_way_4_bit1: MUX_8_way_4_bit
        port map(D0 => B00,
                D1 => B01,
                D2 => B02,
                D3 => B03,
                D4 => B04,
                D5 => B05,
                D6 => B06,
                D7 => B07,
                Y_out =>b,
                S =>Reg_selB0 
        );
     
    Zero <= ZERO_FLAG;
        
    S2 <= S0;
    LoadProgRom <= NOT (Halt OR haltInsDec);
    OUT_REG <= B07;
    
    
end Behavioral;