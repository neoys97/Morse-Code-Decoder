----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2019 09:51:50 AM
-- Design Name: 
-- Module Name: ADC_tb - Behavioral
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

entity ADC_tb is
--  Port ( );
end ADC_tb;

architecture Behavioral of ADC_tb is
    component ADC_simulator
    Port(XCS : in std_logic;
         SCLK : in std_logic;
         SDATA: out std_logic);
    end component;
    
    component ADC_Controller
    Port(clk_6144 : in std_logic;
         data_input : in std_logic;
         rst : in std_logic := '0';
         SS : out std_logic;
         audio_output : out std_logic_vector (11 downto 0);
         clk_3072 : out std_logic;
         clk_48k : out std_logic);
    end component;
    
    component au2mc is
    Port ( ain : in STD_LOGIC_VECTOR (11 downto 0);
           d_bin : out STD_LOGIC;
           clk_48k : in STD_LOGIC;
           clr : in STD_LOGIC;
           debug_audio_input : out integer);
    end component;
    
    -- ADC_simulator signal
    signal XCS : std_logic;
    signal SDATA : std_logic;
    
    -- ADC_Controller signal
    signal clk_3072 : std_logic;
    signal data_input : std_logic;
    signal audio_output : std_logic_vector (11 downto 0);
    signal rst : std_logic := '0';
    
    signal clk_48k : std_logic;  
    
    signal d_bin:std_logic;
    
    -- clock
    signal clk : std_logic := '0';
    constant clk_period : time := 162760ps;
--    constant clk_period : time := 325521ps;
begin
    ADC_simulator_inst: ADC_simulator port map(XCS => XCS,
                                               SCLK => clk_3072,
                                               SDATA => SDATA);
    
    ADC_Controller_inst: ADC_Controller port map(clk_6144 => clk,
                                                 clk_3072 => clk_3072,
                                                 data_input => data_input,
                                                 audio_output => audio_output,
                                                 SS => XCS,
                                                 rst => rst,
                                                 clk_48k => clk_48k);
                                                 
    au2mc_inst: au2mc port map(ain => audio_output,
                               clk_48k => clk_48k,
                               clr => rst,
                               d_bin => d_bin);
                                                 
    clocking: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;
    
    data_input <= SDATA;
end Behavioral;
