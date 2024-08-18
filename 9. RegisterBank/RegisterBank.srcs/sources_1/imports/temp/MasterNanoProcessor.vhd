----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2022 03:28:01 PM
-- Design Name: 
-- Module Name: MasterNanoProcessor - Behavioral
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

entity MasterNanoProcessor is
  Port ( Clk: in STD_LOGIC;
       Res : in STD_LOGIC;
       Halt : in STD_LOGIC;
       Zero : out STD_LOGIC;
       Overflow : out STD_LOGIC;
       S_LED : out STD_LOGIC_VECTOR (3 DOWNTO 0);
       S_7Seg : out STD_LOGIC_VECTOR (6 downto 0);
       Anode : out STD_LOGIC_VECTOR (3 downto 0)
);

end MasterNanoProcessor;

architecture Behavioral of MasterNanoProcessor is

    component NanoProcessor 
      Port ( Clk: in STD_LOGIC;
           Res : in STD_LOGIC;
           Halt : in STD_LOGIC;
           Zero : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           OUT_REG : out STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
    end component;
    
    component LUT_16_7
        Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    component Slow_Clk is
        Port ( Clk_in : in STD_LOGIC;
               Clk_out : out STD_LOGIC);
    end component;
    
    SIGNAL slowClk : std_logic;
    signal address :STD_LOGIC_VECTOR (3 downto 0);
    
begin

    Clk0: Slow_Clk
        port map(
        Clk_in => Clk,
        Clk_out => slowClk
        );
        
    NanoProcessor0: NanoProcessor
        port map(
                Clk=> slowClk,
                Res => Res,
                Halt => Halt,
                Zero => Zero,
                Overflow => Overflow,
                OUT_REG => address
        );
LUT_16_7_0: LUT_16_7
        port map( address => address,
        data => S_7Seg);

    -- to only switch on last 7 seg display
    Anode <= "1110";
    S_LED <= address;


end Behavioral;