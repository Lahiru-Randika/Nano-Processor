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

entity NanoprocessorSim is
--  Port ( );
end NanoprocessorSim;

architecture Behavioral of NanoprocessorSim is

component Nanoprocessor
Port ( Clk : in STD_LOGIC;
       Res : in STD_LOGIC;
       Reg7_out : out STD_LOGIC_VECTOR (3 downto 0);
       S_7Seg : out STD_LOGIC_VECTOR (6 downto 0);
       Anode : out STD_LOGIC_VECTOR (3 downto 0);
       overflow : out STD_LOGIC;
       zero : out STD_LOGIC);
end component;

signal Clk : STD_LOGIC := '0';
signal Res,overflow,zero : STD_LOGIC;
signal Reg7_out,Anode : STD_LOGIC_VECTOR (3 downto 0);
signal S_7Seg : STD_LOGIC_VECTOR (6 downto 0);

begin
UUT : Nanoprocessor
    PORT MAP(
        Clk => Clk,
        Res => Res,
        Reg7_out => Reg7_out,
        S_7Seg => S_7Seg,
        Anode => Anode,
        overflow => overflow,
        zero => zero        
    );
    
process
    begin
        wait for 5ns; --100MHz
        Clk <= NOT(Clk);
end process;

process
begin
    Res <= '1';
    wait for 80ns;
    Res <= '0';
    wait for 80ns;
    Res <= '1';
    wait for 80ns;
    Res <= '0';
    wait;
end process;


end Behavioral;
