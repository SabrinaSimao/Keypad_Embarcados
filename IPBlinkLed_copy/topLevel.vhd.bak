library IEEE;
use IEEE.std_logic_1164.all;

entity topLevel is
    port (
        -- Gloabals
        fpga_clk_50        : in  std_logic;             -- clock.clk
		  
        -- I/Os
        fpga_led_pio       : out std_logic_vector(5 downto 0);
		  fpga_key_pio			: in std_logic_vector(5 downto 0)
	);
end entity topLevel;

architecture rtl of topLevel is

component niosHello is port (
  clk_clk       : in  std_logic                    := 'X'; -- clk
  reset_reset_n : in  std_logic                    := 'X'; -- reset_n
  leds_export   : out std_logic_vector(5 downto 0);        -- export leds
  but_export    : in  std_logic_vector(5 downto 0)			  -- export buttons
);
end component niosHello;

begin
 
u0 : component niosHello port map (
  clk_clk       => fpga_clk_50,    --  clk.clk
  reset_reset_n => '1',            --  reset.reset_n
  leds_export   => fpga_led_pio,    --  leds.export
  but_export    => fpga_key_pio    --  leds.export
);
	
end rtl;