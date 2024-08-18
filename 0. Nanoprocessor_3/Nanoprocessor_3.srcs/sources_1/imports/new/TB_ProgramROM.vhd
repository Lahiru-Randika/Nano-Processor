
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Rom_TB is
    --port()
end Program_Rom_TB;

architecture Behavioral of Program_Rom_TB is
 component ProgramRom is
    Port ( MemSel : in STD_LOGIC_VECTOR (2 downto 0);
            Ins : out STD_LOGIC_VECTOR (11 downto 0));
 end component;
 
 signal address : STD_LOGIC_VECTOR (2 downto 0);
 signal data : STD_LOGIC_VECTOR (11 downto 0);
 
begin
 UUT: ProgramRom
    port map (
        MemSel => address,
        Ins => data
 );
 
 process
    begin
    address <= "000";
    wait for 100 ns;
 
    address <= "001";
    wait for 100 ns;
 
    address <= "010";
    wait for 100 ns;
 
    address <= "011";
    wait for 100 ns;
 
    address <= "100";
    wait for 100 ns;
 
 end process;
 
end Behavioral;
