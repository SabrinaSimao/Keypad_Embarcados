library IEEE;
use IEEE.std_logic_1164.all;

entity topLevel is
    port (
      -- Gloabals
      fpga_clk_50        : in  std_logic;         -- clock.clk
      fpga_clk_rst	     : in  std_logic;				  -- rst
      -- I/Os
		  
		  -- LED do periferico LED
      fpga_led_pio       : out std_logic_vector(5 downto 0);
		  
		  -- KEY do periferico PIO_1
		  fpga_key_pio		   : in std_logic_vector(5 downto 0);
	
		  -- ROW do periferico KEYPAD
		  fpga_key_row		   : out std_logic_vector(3 downto 0);
		  
		  -- COL do periferico KEYPAD
		  fpga_key_col		   : in std_logic_vector(2 downto 0);
      
      --IRQ do periferico KEYPAD
      keypad_0_interrupt_sender_irq : out std_logic
);
	
end entity topLevel;

architecture rtl of topLevel is

component niosHello is
        port (
            but_export                      : in  std_logic_vector(5 downto 0) := (others => 'X'); -- BUT export
            clk_clk                         : in  std_logic                    := 'X';             -- clk
            leds_1_out     	    	      	  : out std_logic_vector(5 downto 0);    
            reset_reset_n                   : in  std_logic                    := 'X';             -- reset_n
            keypad_row_in                   : out std_logic_vector(3 downto 0);                    -- in
            keypad_col_out                  : in  std_logic_vector(2 downto 0) := (others => 'X')  -- out
        );
end component niosHello;
	 
begin
    u0 : component niosHello
        port map (
            but_export                      => fpga_key_pio,                    -- but.export
            clk_clk                         => fpga_clk_50,                     -- clk.clk
            leds_1_out					            => fpga_led_pio,				            -- leds.writeresponsevalid_n
            reset_reset_n                   => fpga_clk_rst,                    -- reset.reset_n
            keypad_row_in                   => fpga_key_row,                    -- keypad_row.in
            keypad_col_out                  => fpga_key_col                    -- keypad_col.out
        );
	
end rtl;