library IEEE;
use IEEE.std_logic_1164.all;

entity LED_peripheral is
	 generic (MaxFrequency : integer := 50000000);
    port (
        -- Gloabals
        clock     : in  std_logic;             -- clock.clk
		  
        -- I/Os
		  led       : out std_logic_vector(5 downto 0);
		  switch		: in std_logic_vector(3 downto 0);
		  key 		: in std_logic_vector(1 downto 0)

	);
end entity LED_peripheral;

architecture rtl of LED_peripheral is

-- signal
signal blink : std_logic := '0';
signal EN    : std_logic := '0';

begin

  process(key)
  --switch ON/OFF
  begin
		if (falling_edge(KEY(0))) then
			EN <= NOT EN;
		end if;		
  end process;

  process(clock, switch) 
      variable counter : integer range 0 to MaxFrequency := 0;
		variable fq		  : integer range 0 to MaxFrequency := 10000000;
		
		begin
		
		--frequencias variando de 10kk a 41kk (ainda vou melhorar os valores)
		if (switch = "0000")  then fq := MaxFrequency/1; end if;
		if (switch = "0001")  then fq := MaxFrequency/2; end if;
		if (switch = "0010")  then fq := MaxFrequency/3; end if;
		if (switch = "0011")  then fq := MaxFrequency/4; end if;
		if (switch = "0100")  then fq := MaxFrequency/5; end if;
		if (switch = "0101")  then fq := MaxFrequency/6; end if;
		if (switch = "0110")  then fq := MaxFrequency/7; end if;
		if (switch = "0111")  then fq := MaxFrequency/8; end if;
		if (switch = "1000")  then fq := MaxFrequency/9; end if;
		if (switch = "1001")  then fq := MaxFrequency/10; end if;
		if (switch = "1010")  then fq := MaxFrequency/11; end if;
		if (switch = "1011")  then fq := MaxFrequency/12; end if;
		if (switch = "1100")  then fq := MaxFrequency/13; end if;
		if (switch = "1101")  then fq := MaxFrequency/14; end if;
		if (switch = "1110")  then fq := MaxFrequency/15; end if;
		if (switch = "1111")  then fq := MaxFrequency/16; end if;
		
		
      --blink led
		if (rising_edge(clock)) then
					if (counter < fq) then
						 counter := counter + 1;
					else
						 blink <= not blink;
						 counter := 0;
					end if;	
		end if;
  end process;

  led(0) <= blink AND EN;
  led(1) <= blink AND EN;
  led(2) <= blink AND EN;
  led(3) <= blink AND EN;
  led(4) <= blink AND EN;
  led(5) <= blink AND EN;
  
  end architecture;