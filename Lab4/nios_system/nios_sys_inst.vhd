	component nios_sys is
		port (
			clk_clk                             : in  std_logic                    := 'X';             -- clk
			leds_external_connection_export     : out std_logic_vector(7 downto 0);                    -- export
			reset_reset_n                       : in  std_logic                    := 'X';             -- reset_n
			switches_external_connection_export : in  std_logic_vector(7 downto 0) := (others => 'X')  -- export
		);
	end component nios_sys;

	u0 : component nios_sys
		port map (
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                          clk.clk
			leds_external_connection_export     => CONNECTED_TO_leds_external_connection_export,     --     leds_external_connection.export
			reset_reset_n                       => CONNECTED_TO_reset_reset_n,                       --                        reset.reset_n
			switches_external_connection_export => CONNECTED_TO_switches_external_connection_export  -- switches_external_connection.export
		);

