--The following code lights up 4x leds with decreasing brightness. The 4 lit leds move back and forth on a row of 10X leds.
--
--In order to understand the code better, let me explain the underlying concept.
--The following "pulse" array  shows 18 elements : 0000LLLLLLLLLL0000. "0" represents elements which are not mapped to leds. "L"
--represents the elements that are mapped to leds. 4 elements on the left are set to '1' first. After every 100 ms, the group of
--4 moves 1 element to the right. The first element (leftmost) is set to the lowest duty cycle, which results in the least
--brightness when the led hits the mapped elements. When the group reaches the last 4 (rightmost) elements, it changes direction 
--and the leftmost becomes the brightest. This process continues indefinitely. 

library IEEE;
use IEEE.STD_Logic_1164.ALL;

-- Define Clock as Input and 10xLEDs as Output
entity Ghost_LED is
	Port(	clk: in STD_LOGIC;
			LED_0: out STD_LOGIC;
			LED_1: out STD_LOGIC;
			LED_2: out STD_LOGIC;
			LED_3: out STD_LOGIC;
			LED_4: out STD_LOGIC;
			LED_5: out STD_LOGIC;
			LED_6: out STD_LOGIC;
			LED_7: out STD_LOGIC;
			LED_8: out STD_LOGIC;
			LED_9: out STD_LOGIC);
	end Ghost_LED;
	
	
architecture Behavioral of Ghost_LED is	
	
	
begin

	process(clk)
	
-- Variables are declared below. Variables are used instead of signals because they update instantaneously	

	variable direction: bit :='0';											-- '0' represents the right to left direction
	variable state:	integer range 0 to 14 :=0;							-- represents 15 different states the group can take at a time
	variable count: integer range 0 to 50000 :=0;						-- count is designed to set a PWM frequency of 1000 Hz
	variable count_1: integer range 0 to 5000000 :=0;
	variable pulse: STD_LOGIC_VECTOR (17 DOWNTO 0) :="000000000000000000";	-- pulse vector is initialized to zero
	
	begin
			if rising_edge(clk) then
			
					if (count=1000 and direction='0') then								-- 2% Brightness
						pulse(state):='0';
					elsif (count=1000 and direction='1') then							-- Brightness order reversed when direction is changed
						pulse(state+3):='0';
					
					
					elsif (count=5000 and direction='0')then							-- 10% Brightness
						pulse(state+1):='0';
					elsif (count=5000 and direction='1')then							-- Brightness order reversed when direction is changed
						pulse(state+2):='0';
						
					elsif (count=25000 and direction='0')then							-- 50% Brightness
						pulse(state+2):='0';
					elsif (count=25000 and direction='1')then							-- Brightness order reversed when direction is changed
						pulse(state+1):='0';
						
					elsif count = 49999 then												-- 100% Brightness
						pulse(state):='1';
						pulse(state+1):='1';
						pulse(state+2):='1';
						pulse(state+3):='1';
						count:=0;																-- Count initialized
				
					end if;
					
-- Since the clock speed is 50Mhz, a count_1 value of 5,000,000 is equivalent to 100 ms of delay between each led increment
				
					if (count_1=5000000 and direction='0') then			-- Direction=0 is assumed to be positive direction. Hence State increases
						state := state+1;
						count_1:=0;
						pulse:="000000000000000000";
						
								if state=14 then									-- Direction revered when maximum state value is reached
								direction:='1';
								end if;
								
					elsif (count_1=5000000 and direction='1') then		-- Direction=1 is assumed to be negative direction. Hence State decreases
						state := state-1;
						count_1:=0;
						pulse:="000000000000000000";
						
								if state=0 then									-- Direction revered when minimum state value is reached
								direction:='0';
								end if;
						
					end if;
	
				
				count 	:=count+1;												-- Increments count
				count_1 	:=count_1+1;											-- Increments count
				
			end if;

-- All leds are mapped to the pulse signals	

	LED_0 <= pulse(4);
	LED_1 <= pulse(5);
	LED_2 <= pulse(6);
	LED_3 <= pulse(7);
	LED_4 <= pulse(8);
	LED_5 <= pulse(9);
	LED_6 <= pulse(10);
	LED_7 <= pulse(11);
	LED_8 <= pulse(12);
	LED_9 <= pulse(13);

	
	end process;


end Behavioral;
