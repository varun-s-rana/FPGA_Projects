-- The following code flashes 10x leds one at a time till it reached the end. It then reverses direction and repeats the process indefinitely

library IEEE;
use IEEE.STD_Logic_1164.ALL;

-- Define Clock as Input and 10xLEDs as Output
entity Ping_Pong_LED is
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
	end Ping_Pong_LED;

-- Pulse signals are defined and initialized. They will hold the state of each led.	
architecture Behavioral of Ping_Pong_LED is

	signal pulse_0:	std_LOGIC :='1';
	signal pulse_1:	std_LOGIC :='0';
	signal pulse_2:	std_LOGIC :='0';
	signal pulse_3:	std_LOGIC :='0';
	signal pulse_4:	std_LOGIC :='0';
	signal pulse_5:	std_LOGIC :='0';
	signal pulse_6:	std_LOGIC :='0';
	signal pulse_7:	std_LOGIC :='0';
	signal pulse_8:	std_LOGIC :='0';
	signal pulse_9:	std_LOGIC :='0';	
	
begin

	process(clk)
	
-- Variables are declared below. Variables are used instead of signals because they update instantaneously	

	variable direction: bit :='0';
	variable led_num:	integer range 0 to 9 :=0;
	variable count: integer range 0 to 50000000 :=0;
	
	begin
			if rising_edge(clk) then
			
				if count=10000000 then						-- 10,000,000 clock cyles will produce a 200 ms delay
						
							if direction='0' then			-- Direction=0 is assumed to be positive direction. Hence Led_num increases
									led_num := led_num+1;
							elsif direction='1' then		-- Direction=1 is assumed to be negative direction. Hence Led_num decreases
									led_num := led_num-1;
							end if;
				
							count :=0;							-- Count is initialized to zero
							
-- For a Split second all leds are turned off. This makes sure that only the led of interest is turned on later

							pulse_0 <= '0';				
							pulse_1 <= '0';
							pulse_2 <= '0';
							pulse_3 <= '0';
							pulse_4 <= '0';
							pulse_5 <= '0';
							pulse_6 <= '0';
							pulse_7 <= '0';
							pulse_8 <= '0';
							pulse_9 <= '0';
							
							
								case led_num is
								when 0 => pulse_0<='1';
											 direction := not direction;	-- Reverses direction
								when 1 => pulse_1<='1';
								when 2 => pulse_2<='1';
								when 3 => pulse_3<='1';
								when 4 => pulse_4<='1';
								when 5 => pulse_5<='1';
								when 6 => pulse_6<='1';
								when 7 => pulse_7<='1';
								when 8 => pulse_8<='1';
								when 9 => pulse_9<='1';
											 direction := not direction;	-- Reverses direction
								
								end case;

								
					end if;
				count :=count+1;					-- Increments count
			end if;
			
	end process;
	
-- All leds are mapped to the pulse signals

	LED_0 <= pulse_0;
	LED_1 <= pulse_1;
	LED_2 <= pulse_2;
	LED_3 <= pulse_3;
	LED_4 <= pulse_4;
	LED_5 <= pulse_5;
	LED_6 <= pulse_6;
	LED_7 <= pulse_7;
	LED_8 <= pulse_8;
	LED_9 <= pulse_9;

end Behavioral;

