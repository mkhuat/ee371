module ReceiveComm(clk, sample_clk, reset, serial_in, parallel_out, char_received, data, bic);

	input wire clk, sample_clk, reset;
	input wire serial_in;
	output wire [7:0] parallel_out;
	output reg char_received;

	reg [3:0] ps;
	output reg [10:0] data;
	reg [10:0] buff;
	
	output reg [3:0] bic;
	reg [3:0] bsc;
	wire parity;
	
	parameter

		// Overall state encodings
		INIT = 4'b0000,
		IDLE = 4'b0001,
		SAMPLING = 4'b0010,

		// BIC encodings
		BIC_END = 4'b1011,
		
		// BSC encodings
		BSC_START = 4'b0000,
		BSC_MIDDLE = 4'b0111,
		BSC_END = 4'b1111;

	assign parallel_out = buff[9:2];
	assign parity = ^data[9:1];
	
	// Bit Sampling Count (BSC) counter
	always @(posedge sample_clk)
		begin
			// $display("RECEIVE: TICK");
			if (reset)
				begin
					// $display("RECEIVE: RESET");
					bic <= 4'b0000;
					ps <= INIT;
					char_received <= 1'b0;
					data <= 11'b11111111111;
					buff <= 11'b11111111111;
				end
			else
				begin
					case(ps)
						INIT:
							begin
								// $display("RECEIVE: INIT TICK");
								bic <= 4'b0000;
								char_received <= 1'b0;
								ps <= IDLE;
								data <= 11'b11111111111;
								buff <= 11'b11111111111;
							end
						IDLE:
							begin
								// $display("RECEIVE: IDLE TICK");
								// Start bit detection
								if (!serial_in)
									begin
										ps <= SAMPLING;
										bsc <= 4'b0000;
										char_received <= 1'b0;
									end
							end
						SAMPLING:
							begin
								// $display("RECEIVE: SAMPLING TICK");
								if (bsc == BSC_MIDDLE)
									begin
										data <= data << 1;
										data[0] <= serial_in;
										bic <= bic + 4'b0001;
										
										// Note assymetry between send and receive at when
										// the "end state is checked"
										if (bic == BIC_END)
											begin
												ps <= IDLE;
												char_received <= 1'b1;
												if (~parity)
													buff <= data;
												bic <= 4'b0000;
											end
									end
								bsc <= bsc + 4'b0001;
							end
						default:
							begin
								ps <= INIT;
								// $display("RECEIVE: DEFAULT TICK");
							end
					endcase
				end
		end
endmodule
