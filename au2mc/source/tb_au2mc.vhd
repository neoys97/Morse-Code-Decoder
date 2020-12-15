-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net

library ieee;
use ieee.std_logic_1164.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity tb_au2mc is
end tb_au2mc;

architecture tb of tb_au2mc is

    component au2mc
        port (ain     : in  std_logic_vector (11 downto 0);
              d_bin   : out std_logic;
              clk_48k : in  std_logic;
              clr     : in  std_logic;
              debug_audio_input: out integer);
    end component;

    signal ain     : std_logic_vector (11 downto 0);
    signal d_bin   : std_logic;
    signal clk_48k : std_logic;
    signal clr     : std_logic;
    signal debug_audio_input : integer;
    
    constant TbPeriod : time := 20.833 us; -- for 48k Hz clk
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    
    file file_in : text;
    
begin

    dut : au2mc
    port map (ain     => ain,
              d_bin   => d_bin,
              clk_48k => clk_48k,
              clr     => clr,
              debug_audio_input => debug_audio_input);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    clk_48k <= TbClock;

    stimuli : process
        -- Variables for simulation
        variable v_linein     : line;
        variable v_auin       : std_logic_vector(15 downto 0);
        
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
     
          wait until rising_edge(clk_48k);     
        end loop;
     
        file_close(file_in);

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_au2mc of tb_au2mc is
    for tb
    end for;
end cfg_tb_au2mc;