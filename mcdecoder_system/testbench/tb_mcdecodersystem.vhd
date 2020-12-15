----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2019 11:24:24 AM
-- Design Name: 
-- Module Name: tb_mcdecodersystem - Behavioral
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
use STD.textio.all;
use ieee.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_mcdecodersystem is
--  Port ( );
end tb_mcdecodersystem;

architecture Behavioral of tb_mcdecodersystem is
    component mcdecodersystem 
    Port ( ain : in std_logic_vector (11 downto 0);
           clr : in std_logic;
           clk : in std_logic;
           sout : out std_logic);
    end component;
    
    -- mcdecodersystem signal
    signal ain : std_logic_vector (11 downto 0);
    signal clr : std_logic;
    signal clk : std_logic;
    signal sout_i:std_logic_vector(0 downto 0);
    
    -- testbench signal
    file file_in : text;
    
    -- 48khz clock simulation
    constant clkPeriod : time := 20833ns;
    constant signal_last : time := 20833ns;
begin
    mcdecodersystemt_inst: mcdecodersystem PORT MAP (
        ain=>ain,
        clr=>clr,
        clk=>clk,
        sout=>sout_i(0));

    clocking : process 
    begin   
        clk <= '0';
        wait for clkPeriod / 2;
        clk <= '1';
        wait for clkPeriod / 2;
    end process;

    stimuli : process
        -- Variables for simulation
        variable v_linein : line;
        variable v_auin : std_logic_vector(15 downto 0);
    begin
        -- EDIT Adapt initialization as needed
        ain <= (others => '0');

        -- Reset generation
        clr <= '1';
        wait for 100 ns;
        clr <= '0';
        wait for 100 ns;
        
        -- Stimuli starts here.  DO NOT modify anything above this line

        file_open(file_in, "morse_goodluck.txt",  read_mode);
     
        while not endfile(file_in) loop
          readline(file_in, v_linein);
          read(v_linein, v_auin);
          ain <= v_auin(15 downto 4);
     
          wait until rising_edge(clk);     
        end loop;
     
        file_close(file_in);

        wait;
    end process;
end Behavioral;
