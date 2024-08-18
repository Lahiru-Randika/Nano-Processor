----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2022 12:25:54 PM
-- Design Name: 
-- Module Name: Instruction_decoder - Behavioral
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

entity Instruction_decoder is
    Port ( Instruction : in STD_LOGIC_VECTOR (11 downto 0);
           Reg_en : out STD_LOGIC_VECTOR (2 downto 0);
           Load_sel : out STD_LOGIC;
           Imd_val : out STD_LOGIC_VECTOR (3 downto 0);
           Reg_selA : out STD_LOGIC_VECTOR (2 downto 0);
           Reg_selB : out STD_LOGIC_VECTOR (2 downto 0);
           Add_sub_sel : out STD_LOGIC;
           Jump : out STD_LOGIC;
           Jump_address : out STD_LOGIC_VECTOR (2 downto 0);
           HALT : out STD_LOGIC;
           JMP_SEL : in STD_LOGIC
           );
--     -- NEWLY ADDED CODE
--     ATTRIBUTE  use_dsp : string;
--     ATTRIBUTE  use_dsp of Instruction_decoder : entity is "yes";
end Instruction_decoder;

architecture Behavioral of Instruction_decoder is
    
--    SIGNAL DEC_OUT : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL OP_ADD, OP_NEG, OP_JZR, OP_MOV : STD_LOGIC;
  
begin
    
    PROCESS (Instruction(11 DOWNTO 10))
    BEGIN
        OP_ADD <= '0';
        OP_NEG <= '0';
        OP_MOV <= '0';
        OP_JZR <= '0';
        CASE Instruction(11 DOWNTO 10) IS
            WHEN "00" => 
                OP_ADD <= '1';
            WHEN "01" =>
                OP_NEG <= '1';
            WHEN "10" => 
                OP_MOV <= '1';
            WHEN OTHERS => 
                OP_JZR <= '1';
        END CASE;
    END PROCESS;
    
    Reg_en <= Instruction(9 DOWNTO 7);
    Imd_val <= Instruction(3 downto 0); 
    Load_sel    <= OP_MOV;
    Add_sub_sel <= OP_NEG;
    
    -- REGISTER A, REGISTER B ADDRESS VALUES
    PROCESS (Instruction(9 DOWNTO 4), OP_NEG) 
    BEGIN
        IF (OP_NEG = '0') THEN 
            Reg_selA <= Instruction(9 DOWNTO 7);
            Reg_selB <= Instruction(6 DOWNTO 4);
        ELSE
            Reg_selA <= "000";
            Reg_selB <= Instruction(9 DOWNTO 7);
        END IF;
    END PROCESS;
    
    PROCESS (JMP_SEL, OP_JZR)
    BEGIN
        IF OP_JZR = '1' THEN
            Jump <= JMP_SEL;
        ELSE
            Jump <= '0';
        END IF;
    END PROCESS;
    
    Jump_address <= Instruction(2 DOWNTO 0);
    
    PROCESS (OP_MOV, Instruction(6))
    BEGIN
        IF OP_MOV = '1' AND Instruction(6) = '1' THEN
            HALT <= '1';
        ELSE 
            HALT <= '0';
        END IF;
    END PROCESS;

end Behavioral;