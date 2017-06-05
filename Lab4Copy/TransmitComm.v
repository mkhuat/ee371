module TransmitComm(clk, sample_clk, reset, transmit_en, load, parallel_in, serial_out, char_sent, data, ps, bic);

	input wire clk, sample_clk, reset, transmit_en, load;
	input wire [7:0] parallel_in; //char
	output wire serial_out;
	output reg char_sent;

	// Enable signals
	reg hold, shift, clear;

	output reg [3:0] ps, bic;
	reg [3:0] ns;
	output reg [9:0] data;
	reg [9:0] buff;

	reg [3:0] bsc;


	parameter

		// Overall state encodings
		INIT = 4'b0000,
		IDLE = 4'b0001,
		TRANSMITTING = 4'b0010,

		// BIC encodings
		BIC_END = 4'b1010,
		BIT_SENT = 4'b1111;


	assign serial_out = data[9];


	// Shift left register
	always @(posedge clk) begin
		// $display("TRANSMIT TICK");
		if (reset)
			begin
				bic <= 4'b0000;
				char_sent <= 1'b0;
				ps <= IDLE;
				buff <= 10'b1111111111;
				data <= 10'b1111111111;
			end
		else
			begin
				case(ps)
					INIT:
						begin
							// $display("TRANSMIT: INIT TICK");
							bic <= 4'b0000;
							char_sent <= 1'b0;
							ps <= IDLE;
							buff <= 10'b1111111111;
							data <= 10'b1111111111;
						end
					IDLE:
						begin
							// $display("TRANSMIT: IDLE TICK");
							// If else chain establishes precendence
							if (load)
								begin
									buff <= {1'b0, parallel_in, 1'b1};
								end
							else if (transmit_en)
								begin
									data <= buff;
									ps <= TRANSMITTING;
									bic <= 4'b0000;
									char_sent <= 1'b0;
								end
						end
					TRANSMITTING:
						begin
							// $display("TRANSMIT: TRANSMITTING TICK");
							if (bic == BIT_SENT)
								begin
									bic <= 4'b0000;
									char_sent <= 1'b1;
									data <= 10'b1111111111; // Should have shifted in all 1's already
									ps <= IDLE;
								end
							else
								begin
									data <= data << 1;
									data[0] <= 1'b1;
									bic <= bic + 4'b0001;
								end
						end
					default:
						begin
							ps <= INIT;
							// $display("TRANSMIT: DEFAULT TICK");
						end
				endcase
				
			end
	end

endmodule
