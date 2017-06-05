	nios_sys u0 (
		.char_received_external_connection_export   (<connected-to-char_received_external_connection_export>),   //   char_received_external_connection.export
		.char_sent_external_connection_export       (<connected-to-char_sent_external_connection_export>),       //       char_sent_external_connection.export
		.clk_clk                                    (<connected-to-clk_clk>),                                    //                                 clk.clk
		.leds_external_connection_export            (<connected-to-leds_external_connection_export>),            //            leds_external_connection.export
		.load_external_connection_export            (<connected-to-load_external_connection_export>),            //            load_external_connection.export
		.parallel_input_external_connection_export  (<connected-to-parallel_input_external_connection_export>),  //  parallel_input_external_connection.export
		.parallel_output_external_connection_export (<connected-to-parallel_output_external_connection_export>), // parallel_output_external_connection.export
		.reset_reset_n                              (<connected-to-reset_reset_n>),                              //                               reset.reset_n
		.switches_external_connection_export        (<connected-to-switches_external_connection_export>),        //        switches_external_connection.export
		.transmit_enable_external_connection_export (<connected-to-transmit_enable_external_connection_export>), // transmit_enable_external_connection.export
		.hex5_external_connection_export            (<connected-to-hex5_external_connection_export>),            //            hex5_external_connection.export
		.hex4_external_connection_export            (<connected-to-hex4_external_connection_export>),            //            hex4_external_connection.export
		.hex3_external_connection_export            (<connected-to-hex3_external_connection_export>),            //            hex3_external_connection.export
		.hex2_external_connection_export            (<connected-to-hex2_external_connection_export>),            //            hex2_external_connection.export
		.hex1_external_connection_export            (<connected-to-hex1_external_connection_export>),            //            hex1_external_connection.export
		.hex0_external_connection_export            (<connected-to-hex0_external_connection_export>)             //            hex0_external_connection.export
	);

