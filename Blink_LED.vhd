-- The following code blinks LED every second


library IEEE;
use IEEE.STD_Logic_1164.ALL;

-- Define Clock as Input and LED_0 as Output
entity Blink_LED is
	Port(	clk: in STD_LOGIC;
			LED_0: out STD_LOGIC);
	end Blink_LED;

-- Signals Blink('0' or '1') and Counter(integer) are defined and initialized
architecture Behavioral of Blink_LED is

	signal blink:	std_LOGIC :='0';
	signal counter:	integer range 0 to 50000000 :=0; -- Since the clock speed is 50Mhz, 50,000,000 clock cycles are need to wait 1 second
	
begin

-- Instructions are executed sequencilly with the process
	process(clk)
	begin
			if clk' event and clk='1' then  	-- The IF condition is executed during the rising edge of the clock
			
				if counter=49999999 then		-- After completion of 1 second, the counter is reset to 0 and the LED is toggled
						counter <=0;
						blink <= not blink;
				
				else
						counter <=counter+1;		-- increments counter for every clock cycle
						
				end if;
				
			end if;
			
	end process;
	
	LED_0 <= blink;	-- Maps "blink" signal to LED_0

end Behavioral;

