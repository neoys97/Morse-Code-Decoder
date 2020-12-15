----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2019 09:14:12 AM
-- Design Name: 
-- Module Name: ADC_simulator - Behavioral
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

entity ADC_simulator is
  Port (XCS : in std_logic;
        SCLK : in std_logic := '1';
        SDATA : out std_logic);
end ADC_simulator;

architecture Behavioral of ADC_simulator is
    type audio is array (0 to 23) of std_logic_vector(14 downto 0);
    signal next_SDATA : std_logic := '0';
    constant audio_signal : audio := ("010011011101000",
                                      "011101111010000",
                                      "000001111011000",
                                      "000001111001000",
                                      "000001110011000",
                                      "000000011011000",
                                      "011101111011000",
                                      "010001111011000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000",
                                      "000000000001000");
    signal index : integer := 0;
    signal audio_index: integer := 0;
begin

    clock_input: process (SCLK)
    begin
        if falling_edge(SCLK) then
            if (XCS = '0') then
                if (index < 15) then
                    report "index " & integer'image(index);
                    next_SDATA <= audio_signal(audio_index)(index);
                    index <= index + 1;
                    if index = 14 then
                        audio_index <= (audio_index + 1) mod 24;
                    end if;
                end if;
            else
                index <= 0;
            end if;
        end if;
    end process;
    
    output: process (XCS, next_SDATA)
    begin
        if (XCS = '0') then
            SDATA <= next_SDATA;
        end if;
    end process;
end Behavioral;
