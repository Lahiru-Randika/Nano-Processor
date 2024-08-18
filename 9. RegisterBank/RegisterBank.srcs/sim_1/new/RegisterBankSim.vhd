----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/11/2022 09:20:57 PM
-- Design Name: 
-- Module Name: RegisterBankSim - Behavioral
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

entity RegisterBankSim is
--  Port ( );
end RegisterBankSim;

architecture Behavioral of RegisterBankSim is
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

signal Clk : STD_LOGIC := '0';
signal R0 : STD_LOGIC_VECTOR (3 downto 0) := "0000"; --read only register
signal Res : STD_LOGIC;
signal D,R1,R2,R3,R4,R5,R6,R7 : STD_LOGIC_VECTOR (3 downto 0);
signal RegSel : STD_LOGIC_VECTOR (2 downto 0);

begin
UUT : RegisterBank
    PORT MAP(
        D => D,
        Clk => Clk,
        Res => Res,
        RegSel => RegSel,
        R0 => R0,
        R1 => R1,
        R2 => R2,
        R3 => R3,
        R4 => R4,
        R5 => R5,
        R6 => R6,
        R7 => R7
    );
    
process
begin
 wait for 5ns; --100MHz
 Clk <= NOT(Clk);
end process;
    
process
begin

Res <= '1';
wait for 100ns;

Res <= '0';
RegSel <= "000";
D <= "1100";            -- Lahiru - 200300A : ....1100 ,    read only register, cannot write data
wait for 100ns;

RegSel <= "001";
D <= "0011";            --Sanjula - 200323V : ....0011
wait for 100ns;

RegSel <= "010";
D <= "1010";            --Thejan - 200698X : ....1010
wait for 100ns;

RegSel <= "011";
D <= "0100";            --Amila - 200196G : ....0100
wait for 100ns;

RegSel <= "100";
D <= "1001"; --         --Anushna - 200265T : ....1001
wait for 100ns;

RegSel <= "101";
D <= "1100";            -- Lahiru - 200300A : ....1100 
wait for 100ns;

Res <= '1';
wait for 100ns;

Res <= '0';
RegSel <= "110";
D <= "0111";
wait for 100ns;

RegSel <= "111";
D <= "1111";
wait for 100ns;

wait;

end process;


end Behavioral;
