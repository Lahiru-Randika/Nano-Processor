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

entity RCA_3 is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (2 downto 0));
end RCA_3;

architecture Behavioral of RCA_3 is
component FA
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           S : out STD_LOGIC;
           C_out : out STD_LOGIC);
end component;

component HA
Port ( A : in STD_LOGIC;
       B : in STD_LOGIC;
       S : out STD_LOGIC;
       C : out STD_LOGIC);
end component;

signal HA0_C,FA1_C,FA2_C : STD_LOGIC;

begin

HA_0 : HA
    PORT MAP(
        A => A(0),
        B => '1',
        S => S(0),
        C => HA0_C
         
    );
FA_1 : FA
    PORT MAP(
        A => A(1),
        B => '0',
        C_in => HA0_C,
        S => S(1),
        C_out => FA1_C
    
    );
FA_2 : FA
    PORT MAP(
        A => A(2),
        B => '0',
        S => S(2),
        C_in => FA1_C,
        C_out => FA2_C
    );

--C_out <= FA2_C;

end Behavioral;
