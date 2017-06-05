// nios_sys.v

// Generated using ACDS version 16.0 211

`timescale 1 ps / 1 ps
module nios_sys (
		input  wire       char_received_external_connection_export,   //   char_received_external_connection.export
		input  wire       char_sent_external_connection_export,       //       char_sent_external_connection.export
		input  wire       clk_clk,                                    //                                 clk.clk
		output wire [7:0] leds_external_connection_export,            //            leds_external_connection.export
		output wire       load_external_connection_export,            //            load_external_connection.export
		output wire [7:0] parallel_input_external_connection_export,  //  parallel_input_external_connection.export
		input  wire [7:0] parallel_output_external_connection_export, // parallel_output_external_connection.export
		input  wire       reset_reset_n,                              //                               reset.reset_n
		input  wire [7:0] switches_external_connection_export,        //        switches_external_connection.export
		output wire       transmit_enable_external_connection_export  // transmit_enable_external_connection.export
	);

	wire  [31:0] nios2_processor_data_master_readdata;                            // mm_interconnect_0:nios2_processor_data_master_readdata -> nios2_processor:d_readdata
	wire         nios2_processor_data_master_waitrequest;                         // mm_interconnect_0:nios2_processor_data_master_waitrequest -> nios2_processor:d_waitrequest
	wire         nios2_processor_data_master_debugaccess;                         // nios2_processor:jtag_debug_module_debugaccess_to_roms -> mm_interconnect_0:nios2_processor_data_master_debugaccess
	wire  [15:0] nios2_processor_data_master_address;                             // nios2_processor:d_address -> mm_interconnect_0:nios2_processor_data_master_address
	wire   [3:0] nios2_processor_data_master_byteenable;                          // nios2_processor:d_byteenable -> mm_interconnect_0:nios2_processor_data_master_byteenable
	wire         nios2_processor_data_master_read;                                // nios2_processor:d_read -> mm_interconnect_0:nios2_processor_data_master_read
	wire         nios2_processor_data_master_write;                               // nios2_processor:d_write -> mm_interconnect_0:nios2_processor_data_master_write
	wire  [31:0] nios2_processor_data_master_writedata;                           // nios2_processor:d_writedata -> mm_interconnect_0:nios2_processor_data_master_writedata
	wire  [31:0] nios2_processor_instruction_master_readdata;                     // mm_interconnect_0:nios2_processor_instruction_master_readdata -> nios2_processor:i_readdata
	wire         nios2_processor_instruction_master_waitrequest;                  // mm_interconnect_0:nios2_processor_instruction_master_waitrequest -> nios2_processor:i_waitrequest
	wire  [15:0] nios2_processor_instruction_master_address;                      // nios2_processor:i_address -> mm_interconnect_0:nios2_processor_instruction_master_address
	wire         nios2_processor_instruction_master_read;                         // nios2_processor:i_read -> mm_interconnect_0:nios2_processor_instruction_master_read
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect;        // mm_interconnect_0:jtag_uart_avalon_jtag_slave_chipselect -> jtag_uart:av_chipselect
	wire  [31:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata;          // jtag_uart:av_readdata -> mm_interconnect_0:jtag_uart_avalon_jtag_slave_readdata
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest;       // jtag_uart:av_waitrequest -> mm_interconnect_0:jtag_uart_avalon_jtag_slave_waitrequest
	wire   [0:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_address;           // mm_interconnect_0:jtag_uart_avalon_jtag_slave_address -> jtag_uart:av_address
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_read;              // mm_interconnect_0:jtag_uart_avalon_jtag_slave_read -> jtag_uart:av_read_n
	wire         mm_interconnect_0_jtag_uart_avalon_jtag_slave_write;             // mm_interconnect_0:jtag_uart_avalon_jtag_slave_write -> jtag_uart:av_write_n
	wire  [31:0] mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata;         // mm_interconnect_0:jtag_uart_avalon_jtag_slave_writedata -> jtag_uart:av_writedata
	wire  [31:0] mm_interconnect_0_nios2_processor_jtag_debug_module_readdata;    // nios2_processor:jtag_debug_module_readdata -> mm_interconnect_0:nios2_processor_jtag_debug_module_readdata
	wire         mm_interconnect_0_nios2_processor_jtag_debug_module_waitrequest; // nios2_processor:jtag_debug_module_waitrequest -> mm_interconnect_0:nios2_processor_jtag_debug_module_waitrequest
	wire         mm_interconnect_0_nios2_processor_jtag_debug_module_debugaccess; // mm_interconnect_0:nios2_processor_jtag_debug_module_debugaccess -> nios2_processor:jtag_debug_module_debugaccess
	wire   [8:0] mm_interconnect_0_nios2_processor_jtag_debug_module_address;     // mm_interconnect_0:nios2_processor_jtag_debug_module_address -> nios2_processor:jtag_debug_module_address
	wire         mm_interconnect_0_nios2_processor_jtag_debug_module_read;        // mm_interconnect_0:nios2_processor_jtag_debug_module_read -> nios2_processor:jtag_debug_module_read
	wire   [3:0] mm_interconnect_0_nios2_processor_jtag_debug_module_byteenable;  // mm_interconnect_0:nios2_processor_jtag_debug_module_byteenable -> nios2_processor:jtag_debug_module_byteenable
	wire         mm_interconnect_0_nios2_processor_jtag_debug_module_write;       // mm_interconnect_0:nios2_processor_jtag_debug_module_write -> nios2_processor:jtag_debug_module_write
	wire  [31:0] mm_interconnect_0_nios2_processor_jtag_debug_module_writedata;   // mm_interconnect_0:nios2_processor_jtag_debug_module_writedata -> nios2_processor:jtag_debug_module_writedata
	wire         mm_interconnect_0_onchip_memory_s1_chipselect;                   // mm_interconnect_0:onchip_memory_s1_chipselect -> onchip_memory:chipselect
	wire  [31:0] mm_interconnect_0_onchip_memory_s1_readdata;                     // onchip_memory:readdata -> mm_interconnect_0:onchip_memory_s1_readdata
	wire  [12:0] mm_interconnect_0_onchip_memory_s1_address;                      // mm_interconnect_0:onchip_memory_s1_address -> onchip_memory:address
	wire   [3:0] mm_interconnect_0_onchip_memory_s1_byteenable;                   // mm_interconnect_0:onchip_memory_s1_byteenable -> onchip_memory:byteenable
	wire         mm_interconnect_0_onchip_memory_s1_write;                        // mm_interconnect_0:onchip_memory_s1_write -> onchip_memory:write
	wire  [31:0] mm_interconnect_0_onchip_memory_s1_writedata;                    // mm_interconnect_0:onchip_memory_s1_writedata -> onchip_memory:writedata
	wire         mm_interconnect_0_onchip_memory_s1_clken;                        // mm_interconnect_0:onchip_memory_s1_clken -> onchip_memory:clken
	wire  [31:0] mm_interconnect_0_switches_s1_readdata;                          // switches:readdata -> mm_interconnect_0:switches_s1_readdata
	wire   [1:0] mm_interconnect_0_switches_s1_address;                           // mm_interconnect_0:switches_s1_address -> switches:address
	wire         mm_interconnect_0_leds_s1_chipselect;                            // mm_interconnect_0:LEDs_s1_chipselect -> LEDs:chipselect
	wire  [31:0] mm_interconnect_0_leds_s1_readdata;                              // LEDs:readdata -> mm_interconnect_0:LEDs_s1_readdata
	wire   [1:0] mm_interconnect_0_leds_s1_address;                               // mm_interconnect_0:LEDs_s1_address -> LEDs:address
	wire         mm_interconnect_0_leds_s1_write;                                 // mm_interconnect_0:LEDs_s1_write -> LEDs:write_n
	wire  [31:0] mm_interconnect_0_leds_s1_writedata;                             // mm_interconnect_0:LEDs_s1_writedata -> LEDs:writedata
	wire         mm_interconnect_0_parallel_input_s1_chipselect;                  // mm_interconnect_0:parallel_input_s1_chipselect -> parallel_input:chipselect
	wire  [31:0] mm_interconnect_0_parallel_input_s1_readdata;                    // parallel_input:readdata -> mm_interconnect_0:parallel_input_s1_readdata
	wire   [1:0] mm_interconnect_0_parallel_input_s1_address;                     // mm_interconnect_0:parallel_input_s1_address -> parallel_input:address
	wire         mm_interconnect_0_parallel_input_s1_write;                       // mm_interconnect_0:parallel_input_s1_write -> parallel_input:write_n
	wire  [31:0] mm_interconnect_0_parallel_input_s1_writedata;                   // mm_interconnect_0:parallel_input_s1_writedata -> parallel_input:writedata
	wire  [31:0] mm_interconnect_0_parallel_output_s1_readdata;                   // parallel_output:readdata -> mm_interconnect_0:parallel_output_s1_readdata
	wire   [1:0] mm_interconnect_0_parallel_output_s1_address;                    // mm_interconnect_0:parallel_output_s1_address -> parallel_output:address
	wire  [31:0] mm_interconnect_0_char_received_s1_readdata;                     // char_received:readdata -> mm_interconnect_0:char_received_s1_readdata
	wire   [1:0] mm_interconnect_0_char_received_s1_address;                      // mm_interconnect_0:char_received_s1_address -> char_received:address
	wire  [31:0] mm_interconnect_0_char_sent_s1_readdata;                         // char_sent:readdata -> mm_interconnect_0:char_sent_s1_readdata
	wire   [1:0] mm_interconnect_0_char_sent_s1_address;                          // mm_interconnect_0:char_sent_s1_address -> char_sent:address
	wire         mm_interconnect_0_transmit_enable_s1_chipselect;                 // mm_interconnect_0:transmit_enable_s1_chipselect -> transmit_enable:chipselect
	wire  [31:0] mm_interconnect_0_transmit_enable_s1_readdata;                   // transmit_enable:readdata -> mm_interconnect_0:transmit_enable_s1_readdata
	wire   [1:0] mm_interconnect_0_transmit_enable_s1_address;                    // mm_interconnect_0:transmit_enable_s1_address -> transmit_enable:address
	wire         mm_interconnect_0_transmit_enable_s1_write;                      // mm_interconnect_0:transmit_enable_s1_write -> transmit_enable:write_n
	wire  [31:0] mm_interconnect_0_transmit_enable_s1_writedata;                  // mm_interconnect_0:transmit_enable_s1_writedata -> transmit_enable:writedata
	wire         mm_interconnect_0_load_s1_chipselect;                            // mm_interconnect_0:load_s1_chipselect -> load:chipselect
	wire  [31:0] mm_interconnect_0_load_s1_readdata;                              // load:readdata -> mm_interconnect_0:load_s1_readdata
	wire   [1:0] mm_interconnect_0_load_s1_address;                               // mm_interconnect_0:load_s1_address -> load:address
	wire         mm_interconnect_0_load_s1_write;                                 // mm_interconnect_0:load_s1_write -> load:write_n
	wire  [31:0] mm_interconnect_0_load_s1_writedata;                             // mm_interconnect_0:load_s1_writedata -> load:writedata
	wire         irq_mapper_receiver0_irq;                                        // jtag_uart:av_irq -> irq_mapper:receiver0_irq
	wire  [31:0] nios2_processor_d_irq_irq;                                       // irq_mapper:sender_irq -> nios2_processor:d_irq
	wire         rst_controller_reset_out_reset;                                  // rst_controller:reset_out -> [LEDs:reset_n, char_received:reset_n, char_sent:reset_n, irq_mapper:reset, jtag_uart:rst_n, load:reset_n, mm_interconnect_0:nios2_processor_reset_n_reset_bridge_in_reset_reset, nios2_processor:reset_n, onchip_memory:reset, parallel_input:reset_n, parallel_output:reset_n, rst_translator:in_reset, switches:reset_n, transmit_enable:reset_n]
	wire         rst_controller_reset_out_reset_req;                              // rst_controller:reset_req -> [nios2_processor:reset_req, onchip_memory:reset_req, rst_translator:reset_req_in]
	wire         nios2_processor_jtag_debug_module_reset_reset;                   // nios2_processor:jtag_debug_module_resetrequest -> rst_controller:reset_in1

	nios_sys_LEDs leds (
		.clk        (clk_clk),                              //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),      //               reset.reset_n
		.address    (mm_interconnect_0_leds_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_leds_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_leds_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_leds_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_leds_s1_readdata),   //                    .readdata
		.out_port   (leds_external_connection_export)       // external_connection.export
	);

	nios_sys_char_received char_received (
		.clk      (clk_clk),                                     //                 clk.clk
		.reset_n  (~rst_controller_reset_out_reset),             //               reset.reset_n
		.address  (mm_interconnect_0_char_received_s1_address),  //                  s1.address
		.readdata (mm_interconnect_0_char_received_s1_readdata), //                    .readdata
		.in_port  (char_received_external_connection_export)     // external_connection.export
	);

	nios_sys_char_received char_sent (
		.clk      (clk_clk),                                 //                 clk.clk
		.reset_n  (~rst_controller_reset_out_reset),         //               reset.reset_n
		.address  (mm_interconnect_0_char_sent_s1_address),  //                  s1.address
		.readdata (mm_interconnect_0_char_sent_s1_readdata), //                    .readdata
		.in_port  (char_sent_external_connection_export)     // external_connection.export
	);

	nios_sys_jtag_uart jtag_uart (
		.clk            (clk_clk),                                                   //               clk.clk
		.rst_n          (~rst_controller_reset_out_reset),                           //             reset.reset_n
		.av_chipselect  (mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect),  // avalon_jtag_slave.chipselect
		.av_address     (mm_interconnect_0_jtag_uart_avalon_jtag_slave_address),     //                  .address
		.av_read_n      (~mm_interconnect_0_jtag_uart_avalon_jtag_slave_read),       //                  .read_n
		.av_readdata    (mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata),    //                  .readdata
		.av_write_n     (~mm_interconnect_0_jtag_uart_avalon_jtag_slave_write),      //                  .write_n
		.av_writedata   (mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata),   //                  .writedata
		.av_waitrequest (mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest), //                  .waitrequest
		.av_irq         (irq_mapper_receiver0_irq)                                   //               irq.irq
	);

	nios_sys_load load (
		.clk        (clk_clk),                              //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),      //               reset.reset_n
		.address    (mm_interconnect_0_load_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_load_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_load_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_load_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_load_s1_readdata),   //                    .readdata
		.out_port   (load_external_connection_export)       // external_connection.export
	);

	nios_sys_nios2_processor nios2_processor (
		.clk                                   (clk_clk),                                                         //                       clk.clk
		.reset_n                               (~rst_controller_reset_out_reset),                                 //                   reset_n.reset_n
		.reset_req                             (rst_controller_reset_out_reset_req),                              //                          .reset_req
		.d_address                             (nios2_processor_data_master_address),                             //               data_master.address
		.d_byteenable                          (nios2_processor_data_master_byteenable),                          //                          .byteenable
		.d_read                                (nios2_processor_data_master_read),                                //                          .read
		.d_readdata                            (nios2_processor_data_master_readdata),                            //                          .readdata
		.d_waitrequest                         (nios2_processor_data_master_waitrequest),                         //                          .waitrequest
		.d_write                               (nios2_processor_data_master_write),                               //                          .write
		.d_writedata                           (nios2_processor_data_master_writedata),                           //                          .writedata
		.jtag_debug_module_debugaccess_to_roms (nios2_processor_data_master_debugaccess),                         //                          .debugaccess
		.i_address                             (nios2_processor_instruction_master_address),                      //        instruction_master.address
		.i_read                                (nios2_processor_instruction_master_read),                         //                          .read
		.i_readdata                            (nios2_processor_instruction_master_readdata),                     //                          .readdata
		.i_waitrequest                         (nios2_processor_instruction_master_waitrequest),                  //                          .waitrequest
		.d_irq                                 (nios2_processor_d_irq_irq),                                       //                     d_irq.irq
		.jtag_debug_module_resetrequest        (nios2_processor_jtag_debug_module_reset_reset),                   //   jtag_debug_module_reset.reset
		.jtag_debug_module_address             (mm_interconnect_0_nios2_processor_jtag_debug_module_address),     //         jtag_debug_module.address
		.jtag_debug_module_byteenable          (mm_interconnect_0_nios2_processor_jtag_debug_module_byteenable),  //                          .byteenable
		.jtag_debug_module_debugaccess         (mm_interconnect_0_nios2_processor_jtag_debug_module_debugaccess), //                          .debugaccess
		.jtag_debug_module_read                (mm_interconnect_0_nios2_processor_jtag_debug_module_read),        //                          .read
		.jtag_debug_module_readdata            (mm_interconnect_0_nios2_processor_jtag_debug_module_readdata),    //                          .readdata
		.jtag_debug_module_waitrequest         (mm_interconnect_0_nios2_processor_jtag_debug_module_waitrequest), //                          .waitrequest
		.jtag_debug_module_write               (mm_interconnect_0_nios2_processor_jtag_debug_module_write),       //                          .write
		.jtag_debug_module_writedata           (mm_interconnect_0_nios2_processor_jtag_debug_module_writedata),   //                          .writedata
		.no_ci_readra                          ()                                                                 // custom_instruction_master.readra
	);

	nios_sys_onchip_memory onchip_memory (
		.clk        (clk_clk),                                       //   clk1.clk
		.address    (mm_interconnect_0_onchip_memory_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_onchip_memory_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_onchip_memory_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_onchip_memory_s1_write),      //       .write
		.readdata   (mm_interconnect_0_onchip_memory_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_onchip_memory_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_onchip_memory_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),                // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req)             //       .reset_req
	);

	nios_sys_LEDs parallel_input (
		.clk        (clk_clk),                                        //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),                //               reset.reset_n
		.address    (mm_interconnect_0_parallel_input_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_parallel_input_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_parallel_input_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_parallel_input_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_parallel_input_s1_readdata),   //                    .readdata
		.out_port   (parallel_input_external_connection_export)       // external_connection.export
	);

	nios_sys_parallel_output parallel_output (
		.clk      (clk_clk),                                       //                 clk.clk
		.reset_n  (~rst_controller_reset_out_reset),               //               reset.reset_n
		.address  (mm_interconnect_0_parallel_output_s1_address),  //                  s1.address
		.readdata (mm_interconnect_0_parallel_output_s1_readdata), //                    .readdata
		.in_port  (parallel_output_external_connection_export)     // external_connection.export
	);

	nios_sys_parallel_output switches (
		.clk      (clk_clk),                                //                 clk.clk
		.reset_n  (~rst_controller_reset_out_reset),        //               reset.reset_n
		.address  (mm_interconnect_0_switches_s1_address),  //                  s1.address
		.readdata (mm_interconnect_0_switches_s1_readdata), //                    .readdata
		.in_port  (switches_external_connection_export)     // external_connection.export
	);

	nios_sys_load transmit_enable (
		.clk        (clk_clk),                                         //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),                 //               reset.reset_n
		.address    (mm_interconnect_0_transmit_enable_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_transmit_enable_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_transmit_enable_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_transmit_enable_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_transmit_enable_s1_readdata),   //                    .readdata
		.out_port   (transmit_enable_external_connection_export)       // external_connection.export
	);

	nios_sys_mm_interconnect_0 mm_interconnect_0 (
		.clk_0_clk_clk                                       (clk_clk),                                                         //                                     clk_0_clk.clk
		.nios2_processor_reset_n_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                                  // nios2_processor_reset_n_reset_bridge_in_reset.reset
		.nios2_processor_data_master_address                 (nios2_processor_data_master_address),                             //                   nios2_processor_data_master.address
		.nios2_processor_data_master_waitrequest             (nios2_processor_data_master_waitrequest),                         //                                              .waitrequest
		.nios2_processor_data_master_byteenable              (nios2_processor_data_master_byteenable),                          //                                              .byteenable
		.nios2_processor_data_master_read                    (nios2_processor_data_master_read),                                //                                              .read
		.nios2_processor_data_master_readdata                (nios2_processor_data_master_readdata),                            //                                              .readdata
		.nios2_processor_data_master_write                   (nios2_processor_data_master_write),                               //                                              .write
		.nios2_processor_data_master_writedata               (nios2_processor_data_master_writedata),                           //                                              .writedata
		.nios2_processor_data_master_debugaccess             (nios2_processor_data_master_debugaccess),                         //                                              .debugaccess
		.nios2_processor_instruction_master_address          (nios2_processor_instruction_master_address),                      //            nios2_processor_instruction_master.address
		.nios2_processor_instruction_master_waitrequest      (nios2_processor_instruction_master_waitrequest),                  //                                              .waitrequest
		.nios2_processor_instruction_master_read             (nios2_processor_instruction_master_read),                         //                                              .read
		.nios2_processor_instruction_master_readdata         (nios2_processor_instruction_master_readdata),                     //                                              .readdata
		.char_received_s1_address                            (mm_interconnect_0_char_received_s1_address),                      //                              char_received_s1.address
		.char_received_s1_readdata                           (mm_interconnect_0_char_received_s1_readdata),                     //                                              .readdata
		.char_sent_s1_address                                (mm_interconnect_0_char_sent_s1_address),                          //                                  char_sent_s1.address
		.char_sent_s1_readdata                               (mm_interconnect_0_char_sent_s1_readdata),                         //                                              .readdata
		.jtag_uart_avalon_jtag_slave_address                 (mm_interconnect_0_jtag_uart_avalon_jtag_slave_address),           //                   jtag_uart_avalon_jtag_slave.address
		.jtag_uart_avalon_jtag_slave_write                   (mm_interconnect_0_jtag_uart_avalon_jtag_slave_write),             //                                              .write
		.jtag_uart_avalon_jtag_slave_read                    (mm_interconnect_0_jtag_uart_avalon_jtag_slave_read),              //                                              .read
		.jtag_uart_avalon_jtag_slave_readdata                (mm_interconnect_0_jtag_uart_avalon_jtag_slave_readdata),          //                                              .readdata
		.jtag_uart_avalon_jtag_slave_writedata               (mm_interconnect_0_jtag_uart_avalon_jtag_slave_writedata),         //                                              .writedata
		.jtag_uart_avalon_jtag_slave_waitrequest             (mm_interconnect_0_jtag_uart_avalon_jtag_slave_waitrequest),       //                                              .waitrequest
		.jtag_uart_avalon_jtag_slave_chipselect              (mm_interconnect_0_jtag_uart_avalon_jtag_slave_chipselect),        //                                              .chipselect
		.LEDs_s1_address                                     (mm_interconnect_0_leds_s1_address),                               //                                       LEDs_s1.address
		.LEDs_s1_write                                       (mm_interconnect_0_leds_s1_write),                                 //                                              .write
		.LEDs_s1_readdata                                    (mm_interconnect_0_leds_s1_readdata),                              //                                              .readdata
		.LEDs_s1_writedata                                   (mm_interconnect_0_leds_s1_writedata),                             //                                              .writedata
		.LEDs_s1_chipselect                                  (mm_interconnect_0_leds_s1_chipselect),                            //                                              .chipselect
		.load_s1_address                                     (mm_interconnect_0_load_s1_address),                               //                                       load_s1.address
		.load_s1_write                                       (mm_interconnect_0_load_s1_write),                                 //                                              .write
		.load_s1_readdata                                    (mm_interconnect_0_load_s1_readdata),                              //                                              .readdata
		.load_s1_writedata                                   (mm_interconnect_0_load_s1_writedata),                             //                                              .writedata
		.load_s1_chipselect                                  (mm_interconnect_0_load_s1_chipselect),                            //                                              .chipselect
		.nios2_processor_jtag_debug_module_address           (mm_interconnect_0_nios2_processor_jtag_debug_module_address),     //             nios2_processor_jtag_debug_module.address
		.nios2_processor_jtag_debug_module_write             (mm_interconnect_0_nios2_processor_jtag_debug_module_write),       //                                              .write
		.nios2_processor_jtag_debug_module_read              (mm_interconnect_0_nios2_processor_jtag_debug_module_read),        //                                              .read
		.nios2_processor_jtag_debug_module_readdata          (mm_interconnect_0_nios2_processor_jtag_debug_module_readdata),    //                                              .readdata
		.nios2_processor_jtag_debug_module_writedata         (mm_interconnect_0_nios2_processor_jtag_debug_module_writedata),   //                                              .writedata
		.nios2_processor_jtag_debug_module_byteenable        (mm_interconnect_0_nios2_processor_jtag_debug_module_byteenable),  //                                              .byteenable
		.nios2_processor_jtag_debug_module_waitrequest       (mm_interconnect_0_nios2_processor_jtag_debug_module_waitrequest), //                                              .waitrequest
		.nios2_processor_jtag_debug_module_debugaccess       (mm_interconnect_0_nios2_processor_jtag_debug_module_debugaccess), //                                              .debugaccess
		.onchip_memory_s1_address                            (mm_interconnect_0_onchip_memory_s1_address),                      //                              onchip_memory_s1.address
		.onchip_memory_s1_write                              (mm_interconnect_0_onchip_memory_s1_write),                        //                                              .write
		.onchip_memory_s1_readdata                           (mm_interconnect_0_onchip_memory_s1_readdata),                     //                                              .readdata
		.onchip_memory_s1_writedata                          (mm_interconnect_0_onchip_memory_s1_writedata),                    //                                              .writedata
		.onchip_memory_s1_byteenable                         (mm_interconnect_0_onchip_memory_s1_byteenable),                   //                                              .byteenable
		.onchip_memory_s1_chipselect                         (mm_interconnect_0_onchip_memory_s1_chipselect),                   //                                              .chipselect
		.onchip_memory_s1_clken                              (mm_interconnect_0_onchip_memory_s1_clken),                        //                                              .clken
		.parallel_input_s1_address                           (mm_interconnect_0_parallel_input_s1_address),                     //                             parallel_input_s1.address
		.parallel_input_s1_write                             (mm_interconnect_0_parallel_input_s1_write),                       //                                              .write
		.parallel_input_s1_readdata                          (mm_interconnect_0_parallel_input_s1_readdata),                    //                                              .readdata
		.parallel_input_s1_writedata                         (mm_interconnect_0_parallel_input_s1_writedata),                   //                                              .writedata
		.parallel_input_s1_chipselect                        (mm_interconnect_0_parallel_input_s1_chipselect),                  //                                              .chipselect
		.parallel_output_s1_address                          (mm_interconnect_0_parallel_output_s1_address),                    //                            parallel_output_s1.address
		.parallel_output_s1_readdata                         (mm_interconnect_0_parallel_output_s1_readdata),                   //                                              .readdata
		.switches_s1_address                                 (mm_interconnect_0_switches_s1_address),                           //                                   switches_s1.address
		.switches_s1_readdata                                (mm_interconnect_0_switches_s1_readdata),                          //                                              .readdata
		.transmit_enable_s1_address                          (mm_interconnect_0_transmit_enable_s1_address),                    //                            transmit_enable_s1.address
		.transmit_enable_s1_write                            (mm_interconnect_0_transmit_enable_s1_write),                      //                                              .write
		.transmit_enable_s1_readdata                         (mm_interconnect_0_transmit_enable_s1_readdata),                   //                                              .readdata
		.transmit_enable_s1_writedata                        (mm_interconnect_0_transmit_enable_s1_writedata),                  //                                              .writedata
		.transmit_enable_s1_chipselect                       (mm_interconnect_0_transmit_enable_s1_chipselect)                  //                                              .chipselect
	);

	nios_sys_irq_mapper irq_mapper (
		.clk           (clk_clk),                        //       clk.clk
		.reset         (rst_controller_reset_out_reset), // clk_reset.reset
		.receiver0_irq (irq_mapper_receiver0_irq),       // receiver0.irq
		.sender_irq    (nios2_processor_d_irq_irq)       //    sender.irq
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (2),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                                // reset_in0.reset
		.reset_in1      (nios2_processor_jtag_debug_module_reset_reset), // reset_in1.reset
		.clk            (clk_clk),                                       //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),                // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req),            //          .reset_req
		.reset_req_in0  (1'b0),                                          // (terminated)
		.reset_req_in1  (1'b0),                                          // (terminated)
		.reset_in2      (1'b0),                                          // (terminated)
		.reset_req_in2  (1'b0),                                          // (terminated)
		.reset_in3      (1'b0),                                          // (terminated)
		.reset_req_in3  (1'b0),                                          // (terminated)
		.reset_in4      (1'b0),                                          // (terminated)
		.reset_req_in4  (1'b0),                                          // (terminated)
		.reset_in5      (1'b0),                                          // (terminated)
		.reset_req_in5  (1'b0),                                          // (terminated)
		.reset_in6      (1'b0),                                          // (terminated)
		.reset_req_in6  (1'b0),                                          // (terminated)
		.reset_in7      (1'b0),                                          // (terminated)
		.reset_req_in7  (1'b0),                                          // (terminated)
		.reset_in8      (1'b0),                                          // (terminated)
		.reset_req_in8  (1'b0),                                          // (terminated)
		.reset_in9      (1'b0),                                          // (terminated)
		.reset_req_in9  (1'b0),                                          // (terminated)
		.reset_in10     (1'b0),                                          // (terminated)
		.reset_req_in10 (1'b0),                                          // (terminated)
		.reset_in11     (1'b0),                                          // (terminated)
		.reset_req_in11 (1'b0),                                          // (terminated)
		.reset_in12     (1'b0),                                          // (terminated)
		.reset_req_in12 (1'b0),                                          // (terminated)
		.reset_in13     (1'b0),                                          // (terminated)
		.reset_req_in13 (1'b0),                                          // (terminated)
		.reset_in14     (1'b0),                                          // (terminated)
		.reset_req_in14 (1'b0),                                          // (terminated)
		.reset_in15     (1'b0),                                          // (terminated)
		.reset_req_in15 (1'b0)                                           // (terminated)
	);

endmodule
