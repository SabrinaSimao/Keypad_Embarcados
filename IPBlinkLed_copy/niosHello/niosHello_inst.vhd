	component niosHello is
		port (
			but_export     : in  std_logic_vector(5 downto 0) := (others => 'X'); -- export
			clk_clk        : in  std_logic                    := 'X';             -- clk
			keypad_col_out : in  std_logic_vector(2 downto 0) := (others => 'X'); -- out
			keypad_row_in  : out std_logic_vector(3 downto 0);                    -- in
			leds_1_out     : out std_logic_vector(5 downto 0);                    -- out
			reset_reset_n  : in  std_logic                    := 'X'              -- reset_n
		);
	end component niosHello;

	u0 : component niosHello
		port map (
			but_export     => CONNECTED_TO_but_export,     --        but.export
			clk_clk        => CONNECTED_TO_clk_clk,        --        clk.clk
			keypad_col_out => CONNECTED_TO_keypad_col_out, -- keypad_col.out
			keypad_row_in  => CONNECTED_TO_keypad_row_in,  -- keypad_row.in
			leds_1_out     => CONNECTED_TO_leds_1_out,     --     leds_1.out
			reset_reset_n  => CONNECTED_TO_reset_reset_n   --      reset.reset_n
		);

