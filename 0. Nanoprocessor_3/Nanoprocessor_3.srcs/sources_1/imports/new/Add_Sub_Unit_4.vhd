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

entity Add_Sub_Unit_4 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           AddSubSel : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Overflow : out STD_LOGIC;
           Zero : out STD_LOGIC);
end Add_Sub_Unit_4;

architecture Behavioral of Add_Sub_Unit_4 is
component RCA_4
Port ( A0 : in STD_LOGIC;
       A1 : in STD_LOGIC;
       A2 : in STD_LOGIC;
       A3 : in STD_LOGIC;
       B0 : in STD_LOGIC;
       B1 : in STD_LOGIC;
       B2 : in STD_LOGIC;
       B3 : in STD_LOGIC;
       C_in : in STD_LOGIC;
       S0 : out STD_LOGIC;
       S1 : out STD_LOGIC;
       S2 : out STD_LOGIC;
       S3 : out STD_LOGIC;
       C_out : out STD_LOGIC);
end component;

signal RCA_out : STD_LOGIC_VECTOR (3 downto 0);
signal A_in : STD_LOGIC_VECTOR (3 downto 0);
signal RCA_carry : STD_LOGIC;

begin

RCA_4_0 : RCA_4
    PORT MAP(
        A0 => A_in(0),
        A1 => A_in(1),
        A2 => A_in(2),
        A3 => A_in(3),
        B0 => B(0),
        B1 => B(1),
        B2 => B(2),
        B3 => B(3),
        C_in => AddSubSel,
        S0 => RCA_out(0),
        S1 => RCA_out(1),
        S2 => RCA_out(2),
        S3 => RCA_out(3),
        C_out => RCA_carry
        
    );

    
A_in(0) <= A(0) XOR AddSubSel;
A_in(1) <= A(1) XOR AddSubSel;
A_in(2) <= A(2) XOR AddSubSel;
A_in(3) <= A(3) XOR AddSubSel;


S(0) <= RCA_out(0);
S(1) <= RCA_out(1);
S(2) <= RCA_out(2);
S(3) <= RCA_out(3);

Overflow <= RCA_carry AND NOT(AddSubSel);

Zero <= NOT(RCA_out(0)) AND NOT(RCA_out(1)) AND NOT(RCA_out(2)) AND NOT(RCA_out(3));

end Behavioral;
