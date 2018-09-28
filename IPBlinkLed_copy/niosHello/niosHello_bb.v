
module niosHello (
	but_export,
	clk_clk,
	keypad_col_out,
	keypad_row_in,
	leds_1_out,
	reset_reset_n);	

	input	[5:0]	but_export;
	input		clk_clk;
	input	[2:0]	keypad_col_out;
	output	[3:0]	keypad_row_in;
	output	[5:0]	leds_1_out;
	input		reset_reset_n;
endmodule
