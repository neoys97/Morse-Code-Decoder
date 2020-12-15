----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2019 10:42:06 AM
-- Design Name: 
-- Module Name: mcdecodersystem - Behavioral
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

entity mcdecodersystem is
  Port ( ain : in std_logic_vector (11 downto 0);
         clr : in std_logic;
         clk : in std_logic;
         sout : out std_logic);
end mcdecodersystem;

architecture Behavioral of mcdecodersystem is
    
    component simpuart
    Port ( din : in STD_LOGIC_VECTOR (7 downto 0);
           wen : in STD_LOGIC;
           sout : out STD_LOGIC;
           clr : in STD_LOGIC;
           clk_48k : in STD_LOGIC);
    end component;
    
    component symdet
    Port ( d_bin : in STD_LOGIC;
           dot : out STD_LOGIC;
           dash : out STD_LOGIC;
           lg : out STD_LOGIC;
           wg : out STD_LOGIC;
           valid : out STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC);
    end component;
    
    component mcdecoder is
      port( clk : in std_logic;
            valid : in std_logic;
            clr : in std_logic;
            dash : in std_logic;
            dot : in std_logic;
            lg :in std_logic;
            wg : in std_logic;
            dvalid :  out std_logic;
            error : out std_logic;
            dout : out std_logic_vector(7 downto 0));
    end component;
    
    component uart_wren
    Port ( clr : in std_logic;
           clk : in STD_LOGIC;
           wr_valid : in STD_LOGIC;
           dout : out STD_LOGIC;
           data_in : in std_logic_vector(7 downto 0);
           data_out : out std_logic_vector(7 downto 0));
    end component;
   
    component au2mc
    Port ( ain : in STD_LOGIC_VECTOR (11 downto 0);
           d_bin : out STD_LOGIC;
           clk_48k : in STD_LOGIC;
           clr : in STD_LOGIC;
           debug_audio_input : out integer);
    end component;
  
    signal uart_wr: std_logic;
 
    --Decorder signal
    signal dot : std_logic;
    signal dash : std_logic;
    signal lg : std_logic;
    signal wg : std_logic;
    signal valid : std_logic;  
    signal d_bin : std_logic;
    signal dvalid: std_logic;
    signal error: std_logic;
    signal decoder_out : std_logic_vector(7 downto 0);
    
    --FIFO signal
    signal uartFIFO_out : std_logic_vector(7 downto 0);
    signal empty : std_logic;
    signal empty_out : std_logic;
    signal read_out :  STD_logic;
begin

    simpuart_inst: simpuart PORT MAP (
        din=>uartFIFO_out,
        wen=>uart_wr,
        sout=>sout,
        clr=>clr,
        clk_48k=>clk);
    
    uart_wren_inst: uart_wren PORT MAP (
        clr => clr,
        clk => clk,
        wr_valid => dvalid,
        dout => uart_wr,
        data_in => decoder_out,
        data_out => uartFIFO_out);
       
    symdet_inst: symdet PORT MAP (
        d_bin=>d_bin,
        dot=>dot,
        dash=>dash,
        lg=>lg,
        wg=>wg,
        valid=>valid,
        clr=>clr,
        clk=>clk);

    au2mc_inst : au2mc PORT MAP (
        clk_48k => clk,
        clr => clr,
        d_bin => d_bin,
        ain => ain);
         
    mcdecoder_inst: mcdecoder PORT MAP (
         clk => clk,
         valid => valid,
         clr =>clr,
         dash=>dash,
         dot=>dot,
         lg=>lg,
         wg=>wg,
         dvalid=>dvalid,
         error=> error,
         dout => decoder_out); 

end Behavioral;
