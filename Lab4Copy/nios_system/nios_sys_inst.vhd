	component nios_sys is
		port (
			char_received_external_connection_export   : in  std_logic                    := 'X';             -- export
			char_sent_external_connection_export       : in  std_logic                    := 'X';             -- export
			clk_clk                                    : in  std_logic                    := 'X';             -- clk
			hex0_external_connection_export            : out std_logic_vector(7 downto 0);                    -- export
			hex1_external_connection_export            : out std_logic_vector(7 downto 0);                    -- export
			hex2_external_connection_export            : out std_logic_vector(7 downto 0);                    -- export
			hex3_external_connection_export            : out std_logic_vector(7 downto 0);                    -- export
			hex4_external_connection_export            : out std_logic_vector(7 downto 0);                    -- export
			hex5_external_connection_export            : out std_logic_vector(7 downto 0);                    -- export
			leds_external_connection_export            : out std_logic_vector(7 downto 0);                    -- export
			load_external_connection_export            : out std_logic;                                       -- export
			parallel_input_external_connection_export  : out std_logic_vector(7 downto 0);                    -- export
			parallel_output_external_connection_export : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			reset_reset_n                              : in  std_logic                    := 'X';             -- reset_n
			switches_external_connection_export        : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			transmit_enable_external_connection_export : out std_logic                                        -- export
		);
	end component nios_sys;

	u0 : component nios_sys
		port map (
			char_received_external_connection_export   => CONNECTED_TO_char_received_external_connection_export,   --   char_received_external_connection.export
			char_sent_external_connection_export       => CONNECTED_TO_char_sent_external_connection_export,       --       char_sent_external_connection.export
			clk_clk                                    => CONNECTED_TO_clk_clk,                                    --                                 clk.clk
			hex0_external_connection_export            => CONNECTED_TO_hex0_external_connection_export,            --            hex0_external_connection.export
			hex1_external_connection_export            => CONNECTED_TO_hex1_external_connection_export,            --            hex1_external_connection.export
			hex2_external_connection_export            => CONNECTED_TO_hex2_external_connection_export,            --            hex2_external_connection.export
			hex3_external_connection_export            => CONNECTED_TO_hex3_external_connection_export,            --            hex3_external_connection.export
			hex4_external_connection_export            => CONNECTED_TO_hex4_external_connection_export,            --            hex4_external_connection.export
			hex5_external_connection_export            => CONNECTED_TO_hex5_external_connection_export,            --            hex5_external_connection.export
			leds_external_connection_export            => CONNECTED_TO_leds_external_connection_export,            --            leds_external_connection.export
			load_external_connection_export            => CONNECTED_TO_load_external_connection_export,            --            load_external_connection.export
			parallel_input_external_connection_export  => CONNECTED_TO_parallel_input_external_connection_export,  --  parallel_input_external_connection.export
			parallel_output_external_connection_export => CONNECTED_TO_parallel_output_external_connection_export, -- parallel_output_external_connection.export
			reset_reset_n                              => CONNECTED_TO_reset_reset_n,                              --                               reset.reset_n
			switches_external_connection_export        => CONNECTED_TO_switches_external_connection_export,        --        switches_external_connection.export
			transmit_enable_external_connection_export => CONNECTED_TO_transmit_enable_external_connection_export  -- transmit_enable_external_connection.export
		);

