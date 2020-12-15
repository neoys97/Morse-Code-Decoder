----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/20/2018 12:19:52 PM
-- Design Name:
-- Module Name: au2mc - rtl
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity au2mc is
    Port ( ain : in STD_LOGIC_VECTOR (11 downto 0);
           d_bin : out STD_LOGIC;
           clk_48k : in STD_LOGIC;
           clr : in STD_LOGIC;
           debug_audio_input : out integer);
end au2mc;

architecture rtl of au2mc is
    type audio is array (0 to 7) of integer;
    signal previous_audio : audio := (others => 0);
    signal audio_buffer : std_logic_vector (11 downto 0):= (others => '0');
    signal index : integer := 0;
    signal sum : integer;
    constant threshold : integer := 1024; -- Third quartile of range (0 - 2048)
    signal dout_buffer : std_logic;
begin
    getting_input : process (clk_48k)
    begin
        sum <= previous_audio(0) + 
               previous_audio(1) +
               previous_audio(2) +
               previous_audio(3) +
               previous_audio(4) +
               previous_audio(5) +
               previous_audio(6) +
               previous_audio(7);
        if clr = '1' then
            dout_buffer <= '0';
            audio_buffer <= (others => '0');
        end if;
        if ((sum / 7) > threshold) then
            dout_buffer <= '1';
        else
            dout_buffer <= '0';
        end if;
        if rising_edge(clk_48k) then
            if (ain(11) = '1') then
                audio_buffer <= '0' & ain(10 downto 0);
            else
                audio_buffer <= '1' & ain(10 downto 0);
            end if;
            index <= (index + 1) mod 8;
        end if;
    end process;
    
    buffer_process : process (clk_48k, audio_buffer)
    begin
        if clr = '1' then
            previous_audio <= (others => 0);
        end if;
        previous_audio(index) <= to_integer(abs(signed(audio_buffer)));
        debug_audio_input <= previous_audio(index);
    end process;
    
    d_bin <= dout_buffer;
end rtl;