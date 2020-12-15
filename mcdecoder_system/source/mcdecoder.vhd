----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 10/12/2018 12:44:03 PM
-- Design Name:
-- Module Name: mcdecoder - Behavioral
-- Project Name: Morse Code Decoder for Homework 1
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

entity mcdecoder is
    Port ( dot : in STD_LOGIC;
           dash : in STD_LOGIC;
           lg : in STD_LOGIC;
           wg : in STD_LOGIC;
           valid : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (7 downto 0);
           dvalid : out STD_LOGIC;
           error : out STD_LOGIC;
           clr : in STD_LOGIC;
           clk : in STD_LOGIC);
end mcdecoder;

architecture Behavioral of mcdecoder is

   --Use descriptive names for the states, like st1_reset, st2_search
   type state_type is (st_null, st_null_space, st_err,
                       st_A, st_B, st_C, st_D, st_E, st_F, st_G, st_H, st_I, st_J, st_K, st_L, st_M, st_N, st_O, st_P, st_Q, st_R, st_S, st_T, st_U, st_V, st_W, st_X, st_Y, st_Z, st_0, st_1, st_2, st_3, st_4, st_5, st_6, st_7, st_8, st_9,
                       st_2_r, st_8_r, st_09_r
                       );
   signal state, next_state : state_type;

begin

   --A clock process for state register
   proc_statereg: process (clk, clr)
   begin
      if (clr = '1') then
         -- jump to reset state here
         state <= st_null;
      end if;
      if (clk'event and clk = '1') then
         state <= next_state;
      end if;
   end process;

   --MEALY State-Machine - Outputs based on state and inputs
   proc_output: process (state, dot, dash, wg, lg, valid)
   begin
        dvalid <= '0';
        error <= '0';
      --insert statements to decode internal output signals
      --below is simple example
        if state = st_null_space then
            dout <= "00100000";
            dvalid <= '1';
        elsif state = st_err then
            error <= '1';
        elsif valid = '1' then
            if (dot = '0' and dash = '0' and (wg = '1' or lg = '1')) then
                case (state) is
                    when st_A =>
                        dout <= "01000001";
                        dvalid <= '1';
                    when st_B =>
                        dout <= "01000010";
                        dvalid <= '1';
                    when st_C =>
                        dout <= "01000011";
                        dvalid <= '1';
                    when st_D =>
                        dout <= "01000100";
                        dvalid <= '1';
                    when st_E =>
                        dout <= "01000101";
                        dvalid <= '1';
                    when st_F =>
                        dout <= "01000110";
                        dvalid <= '1';
                    when st_G =>
                        dout <= "01000111";
                        dvalid <= '1';
                    when st_H =>
                        dout <= "01001000";
                        dvalid <= '1';
                    when st_I =>
                        dout <= "01001001";
                        dvalid <= '1';
                    when st_J =>
                        dout <= "01001010";
                        dvalid <= '1';
                    when st_K =>
                        dout <= "01001011";
                        dvalid <= '1';
                    when st_L =>
                        dout <= "01001100";
                        dvalid <= '1';
                    when st_M =>
                        dout <= "01001101";
                        dvalid <= '1';
                    when st_N =>
                        dout <= "01001110";
                        dvalid <= '1';
                    when st_O =>
                        dout <= "01001111";
                        dvalid <= '1';
                    when st_P =>
                        dout <= "01010000";
                        dvalid <= '1';
                    when st_Q =>
                        dout <= "01010001";
                        dvalid <= '1';
                    when st_R =>
                        dout <= "01010010";
                        dvalid <= '1';
                    when st_S =>
                        dout <= "01010011";
                        dvalid <= '1';
                    when st_T =>
                        dout <= "01010100";
                        dvalid <= '1';
                    when st_U =>
                        dout <= "01010101";
                        dvalid <= '1';
                    when st_V =>
                        dout <= "01010110";
                        dvalid <= '1';
                    when st_W =>
                        dout <= "01010111";
                        dvalid <= '1';
                    when st_X =>
                        dout <= "01011000";
                        dvalid <= '1';
                    when st_Y =>
                        dout <= "01011001";
                        dvalid <= '1';
                    when st_Z =>
                        dout <= "01011010";
                        dvalid <= '1';
                    when st_0 =>
                        dout <= "00110000";
                        dvalid <= '1';
                    when st_1 =>
                        dout <= "00110001";
                        dvalid <= '1';
                    when st_2 =>
                        dout <= "00110010";
                        dvalid <= '1';
                    when st_3 =>
                        dout <= "00110011";
                        dvalid <= '1';
                    when st_4 =>
                        dout <= "00110100";
                        dvalid <= '1';
                    when st_5 =>
                        dout <= "00110101";
                        dvalid <= '1';
                    when st_6 =>
                        dout <= "00110110";
                        dvalid <= '1';
                    when st_7 =>
                        dout <= "00110111";
                        dvalid <= '1';
                    when st_8 =>
                        dout <= "00111000";
                        dvalid <= '1';
                    when st_9 =>
                        dout <= "00111001";
                        dvalid <= '1'; 
                    when others =>
                        error <= '0';
                        dvalid <= '0';
                end case;   
            end if;
        end if;
   end process;
   
   -- Next State Logic.  This corresponds to your next state logic table
   proc_ns: process (state, dot, dash, wg, lg, valid)
   begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
        when st_null =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_E;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_T;
            end if;
            
        when st_null_space =>
            next_state <= st_null;  
        
        when st_err =>
            next_state <= st_null;
            
        when st_E =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_I;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_A;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_I =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_S;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_U;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_S =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_H;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_V;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_H =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_5;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_4;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_5 =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_4 =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_V =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_3;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_3 =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_U =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_F;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_2_r;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_F =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_2_r =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_2;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_err;
            end if;
        
        when st_2 =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_A =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_R;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_W;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_R =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_L;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_L =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_W =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_P;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_J;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_P =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_J =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_1;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_1 =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_T =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_N;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_M;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_N =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_D;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_K;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_D =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_B;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_X;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_B =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_6;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_6 =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_X =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_K =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_C;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_Y;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_C =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_Y =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_M =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_G;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_O;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_G =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_Z;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_Q;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_Z =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_7;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_7 =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_Q =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_O =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_8_r;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_09_r;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_8_r =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_8;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_err;
            end if;
        
        when st_8 =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
        
        when st_09_r =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_9;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_0;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_err;
            end if;
            
        when st_9 =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when st_0 =>
            if (dot = '1' and dash = '0' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '1' and lg = '0' and wg = '0' and valid = '1') then
                next_state <= st_err;
            elsif (dot = '0' and dash = '0' and lg = '0' and wg = '1' and valid = '1') then
                next_state <= st_null_space;
            elsif (dot = '0' and dash = '0' and lg = '1' and wg = '0' and valid = '1') then
                next_state <= st_null;
            end if;
            
        when others =>
            next_state <= state;
            
      end case;
   end process;

end Behavioral;