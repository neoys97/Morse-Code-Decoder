----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2019 09:14:11 AM
-- Design Name: 
-- Module Name: ADC_Controller - Behavioral
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
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADC_Controller is
  Port (clk_6144 : in std_logic;
        data_input : in std_logic;
        rst : in std_logic := '0';
        audio_output : out std_logic_vector (11 downto 0);
        SS : out std_logic := '1';
        clk_3072 : out std_logic;
        clk_48k : out std_logic);
end ADC_Controller;

architecture Behavioral of ADC_Controller is
    signal clk_divider_3072 : unsigned(6 downto 0) := (others=>'0');
    signal clk_divider_48k : unsigned(6 downto 0) := "1111101";
    signal bit_incoming : boolean := false;
    signal index: integer := -4;
    signal tmp_output : std_logic_vector (11 downto 0);
begin
    clk_div: process (clk_6144)
    begin
        if rst = '1' then
            clk_divider_3072 <= (others=>'0');
            clk_divider_48k <= "1111101";
        end if;
        if rising_edge(clk_6144) then
            clk_divider_3072 <= clk_divider_3072 + 1;
            clk_divider_48k <= clk_divider_48k + 1;
        end if;
    end process;
    clk_3072 <= clk_divider_3072(1);
    clk_48k <= clk_divider_48k(6);
    
    SS_controller: process (clk_divider_48k)
    begin
        if rising_edge(clk_divider_48k(6)) or falling_edge(clk_divider_48k(6)) then
            SS <= not clk_divider_48k(6);
            if (clk_divider_48k(6) = '1') then
                bit_incoming <= true;
            else
                bit_incoming <= false;
            end if;
        end if;
    end process;
    
    Serial_to_Parallel: process (clk_divider_3072(1))
    begin
        if (index = -4) then
            audio_output <= tmp_output;
        end if;
        if falling_edge(clk_divider_3072(1)) then
            if (bit_incoming) then
                index <= index + 1;
                if (index >= 0) then 
                    tmp_output(11 - index) <= data_input;
                end if;
            else
                index <= -4;
            end if;
        end if;
    end process;
end Behavioral;
