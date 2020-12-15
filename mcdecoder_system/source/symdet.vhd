-- ELEC3342 symdet Hardware Design

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity symdet is
port( clr, clk: in std_logic;
	d_bin: in std_logic;
	dot,dash,lg,wg,valid: out std_logic
	--debugging
	--baseT: out integer;
	--lastInput: out std_logic;
	
	-- for debug
	--highOne,highTwo,highThr,highFou,highFiv,highSix,highSev,highEig: out integer;
	--lowOne,lowTwo,lowThr,lowFou,lowFiv,lowSix,lowSev,lowEig,longestL: out integer
	
);
end symdet;

architecture Behavioral of symdet is
SIGNAL longestBreak: integer:=0;--the longest among 8 low signals
SIGNAL high1,high2,high3,high4,high5,high6,high7,high8: integer:=0; --length of the high bits
SIGNAL low1,low2,low3,low4,low5,low6,low7,low8: integer:=0; -- length of the low bits
SIGNAL u: integer; --base unit time
SIGNAL calculated: std_logic; --shows whether u is calculated or not
SIGNAL lastIn: std_logic; --shows what was the previous input(1 or 0)
SIGNAL counter: integer:=0; --counts how many consecutive bits are incoming
SIGNAL counterForData: integer:=1; --it will count how many data we have. We will calculate u after we get 10 data
SIGNAL started: std_logic:='0'; --it will be 1 when the first transition from 0 to 1 happens
SIGNAL nxtDot,nxtDash,nxtLG,nxtWG,nxtValid: std_logic:='0'; --the next status of each signal
SIGNAL counterForEnd: integer:=0; -- count till we end the program
SIGNAL ended: std_logic:='0'; -- it will be 1 if theres long low signal (more than 10 u)



--SIGNAL Carry : std_logic_vector (32 downto 0);


begin
   output: process(clk,clr)
    begin
    if (clr = '1') then
        dot <= '0';
        dash <='0';
        lg <='0';
        wg <='0';
        valid <='0';
     --   baseT <=0;
      --  lastInput<='0';
        
       elsif rising_edge(clk) then
            Dot<=nxtDot;
            
            Dash<=nxtDash;
            lg<=nxtLG;
            wg<=nxtWG;
            valid<=nxtValid;
         --   baseT <= u;
         --   lastInput<=lastIn;
           
            --for debug
        --    highOne<=high1;
        --    highTwo<=high2;
        --    highThr<=high3;
       --     highFou<=high4;
        --    highFiv<=high5;
        --    highSix<=high6;
       --   highSev<=high7;
       --     highEig<=high8;
        --    lowOne<=low1;
        --    lowTwo<=low2;
         --   lowThr<=low3;
        --    lowFou<=low4;
        --    lowFiv<=low5;
        --    lowSix<=low6;
         --   lowSev<=low7;
       --     lowEig<=low8;
      --     longestL<=longestbreak;
        end if;
      end process;
        
nxt_state: process ( clr, clk)
    begin
    if (clr = '1') then
        high1<= 0;
        high2<= 0;
        high3<= 0;
        high4<= 0;
        high5<= 0;
        high6<= 0;
        high7<= 0;
        high8<= 0;
        low1<=0;
        low2<=0;
        low3<=0;
        low4<=0;
        low5<=0;
        low6<=0;
        low7<=0;
        low8<=0;
        calculated <= '0';
        u<=0;
        longestBreak<=0;
        lastIn<='0';
        nxtDot<='0';
        nxtDash<='0';
        nxtLG<='0';
        nxtWG<='0';
        nxtValid<='0';
        counterForData<=0;
     elsif rising_edge(clk) then
        lastIn<=d_bin;
        nxtDot<='0';
        nxtDash<='0';
        nxtLG<='0';
        nxtWG<='0';
        nxtValid<='0';
        --consecutive low input
        if( lastIn='0' AND d_bin='0')then
            counter <= counter + 1; --count how many consecutive bits of low
            --lastIn is still 0          
            --when the program ended, push the left over inputs to output
            if( started = '1' AND calculated = '1' AND counter > u*10 ) then
                ended <= '1';
            end if;
            if (ended = '1' AND counterForEnd < 16) then 
                if( counterForEnd mod 2 = 0 ) then
                    if( (low1*100)/u >= (100*3*19)/21 AND (low1*100)/u<=(100*3*21)/19) then -- 0.95/1.05 = 19/21. multiply 100 to do decimals
                        nxtLG <= '1';
                        nxtValid <= '1'; 
                    elsif ((low1*100)/u >= (100*7*19)/21 AND (low1*100)/u <= (100*7*21)/19) then  --handle later
                        nxtWG <= '1';
                        nxtValid <= '1'; 
                    else
                    end if;
                    low1 <= low2;
                    low2 <= low3;
                    low3 <= low4;
                    low4 <= low5;
                    low5 <= low6;
                    low6 <= low7;
                    low7 <= low8;
                    counter<=1;
                    counterForEnd <= counterForEnd + 1;
                elsif( counterForEnd mod 2 = 1 ) then
                    if((high1*100)/u >= (100*1*19)/21 AND (high1*100)/u<=(100*1*21)/19) then -- handle later (precision)
                        nxtDot <= '1';
                        nxtValid <= '1'; 
                    elsif ((high1*100)/u >= (100*3*19)/21 AND (high1*100)/u<=(100*3*21)/19) then  --handle later
                        nxtDash <= '1';
                        nxtValid <= '1'; 
                    else
                    end if;
                    high1 <= high2;
                    high2 <= high3;
                    high3 <= high4;
                    high4 <= high5;
                    high5 <= high6;
                    high6 <= high7;
                    high7 <= high8;
                    counter<=1;
                    counterForEnd <= counterForEnd + 1;
                end if;
            elsif (ended='1') then
                nxtWG <= '1';
                nxtValid <= '1'; 
            end if;
                    
                 
                    
            
            
        --consecutive high input
        elsif ( lastIn='1' AND d_bin='1') then
            counter <= counter +1; --count how many consecutive bits of high
            
            
        elsif ( lastIn='0' AND d_bin='1') then
        --when it is the first 0 to 1 (program starting)
            if( started = '0' ) then
                started<='1';
                counter<=1;
            
          --otherwise
            else 
            --print out the low1 ( whether letter gap or word gap)
                if( calculated = '1' ) then
                    if( (low1*100)/u >= (100*3*19)/21 AND (low1*100)/u<=(100*3*21)/19) then -- handle later (precision)
                        nxtLG <= '1';
                        nxtValid <= '1'; 
                    elsif ((low1*100)/u >= (100*7*19)/21 AND (low1*100)/u<=(100*7*21)/19) then  --handle later
                        nxtWG <= '1';
                        nxtValid <= '1'; 
                    else
                    end if;
               end if;
               --push the data 
               low1 <= low2;
               low2 <= low3;
               low3 <= low4;
               low4 <= low5;
               low5 <= low6;
               low6 <= low7;
               low7 <= low8;
               low8 <= counter;
               -- find the longest break to use later in finding base unit
               if(counter > longestBreak) then
                    longestBreak <= counter;
               end if;
               
               counter<=1; --start counting again
               
               -- if started, start counting the number of data
               if (started = '1') then
                   counterForData<= counterForData + 1;
               end if;
               
              
               
               -- calculate the base unit after we get 10 samples (5 lows) 
               if( counterForData = 5) then
                -- to do 
                    if( (longestBreak*100)/high8 >= (100*3*19)/21 AND (longestBreak*100)/high8<=(100*3*21)/19 ) then --(1,3) 
                        u <= high8; --because high8 is one
                        calculated <= '1';
                    elsif ( (longestBreak*100)/high8 >= (100*7*19)/21 AND (longestBreak*100)/high8 <=(100*7*21)/19 ) then -- (1,7)
                        u <= high8; -- because high8 is one
                        calculated <= '1';
                    elsif ( (longestBreak*100)/high8 >= (100*1*19)/21 AND (longestBreak*100)/high8 <=(100*1*21)/19 ) then -- (3,3)
                        u <= high8/3; --because high8 is 3
                        calculated <= '1';
                    elsif ( (longestBreak*100)/high8 >= (100*7*19)/21/3 AND (longestBreak*100)/high8 <=(100*7*21)/19/3 ) then -- (3,7)
                        u <= high8 / 3; --because high8 is 3
                        calculated <= '1';
                    else
                        --recalculate u here
                        calculated<='0';
                    end if;
               end if;
                    
               --lastIn <= '1'; --update last bit
             end if; --for if(started)
          elsif( lastIn='1' AND d_bin='0' ) then 
                  --print out the high1 ( whether dot or dash)
                if( calculated = '1' ) then
                    if((high1*100)/u >= (100*1*19)/21 AND (high1*100)/u<=(100*1*21)/19) then -- handle later (precision)
                        nxtDot <= '1';
                        nxtValid <= '1'; 
                    elsif ((high1*100)/u >= (100*3*19)/21 AND (high1*100)/u<=(100*3*21)/19) then  --handle later
                        nxtDash <= '1';
                        nxtValid <= '1'; 
                    else
                        -- recalculate u here and print again
                    end if;
                end if;
               --push the data 
               high1 <= high2;
               high2 <= high3;
               high3 <= high4;
               high4 <= high5;
               high5 <= high6;
               high6 <= high7;
               high7 <= high8;
               high8 <= counter;
            
               counter<=1; --start counting again
               --lastIn <= '0'; -- update last bit
             else --del
            end if; --for different last bit & current bit if cases

    end if;
    end process;
    
  
        
  end Behavioral;