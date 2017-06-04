module TransmitComm(clk, reset, transmit_en, load, parallel_in, serial_out, char_sent, data);

	input wire clk, reset, transmit_en, load;
	input wire [7:0] parallel_in; //char
	output wire serial_out;
	output reg char_sent;

	// Enable signals
	reg hold, shift, clear;

	reg [3:0] ps, ns;
	output reg [9:0] data;

	reg [3:0] bic;
	reg [3:0] bsc;


	parameter

		// Overall state encodings
		INIT = 4'b0000,
		IDLE = 4'b0001,
		TRANSMITTING = 4'b0010,

		// BIC encodings
		BIC_END = 4'b1011,

		// BSC encodings
		BIT_SENT = 4'b1111;


	assign serial_out = data[0];

	always @(*) begin

		ns = ps;
		hold = 1'b0;
		shift = 1'b0;
		clear = 1'b0;

		case (ps)
			INIT:
				begin
					hold = 1'b1;
					clear = 1'b1;
					ns = IDLE;
				end

			IDLE:
				begin
					hold = 1'b1;
					if (transmit_en) begin
							char_sent = 1'b0;
							ns = TRANSMITTING;
					end
				end

			TRANSMITTING:
				begin
					if (bsc == BIT_SENT) shift = 1'b1;		// We've sent 16 times, so shift to grab next bit
					if (bic == BIC_END) char_sent = 1'b1;	// Char sent if we're done sending 8 bits (a byte)
				end

			default:
				begin
					ns = ps;
					hold = 1'b0;
					shift = 1'b0;
					clear = 1'b0;
				end
		endcase

	end

	// Counter for BSC
	always @(posedge clk) begin
		if (hold)
			bsc <= 4'b0000;
		else
			bsc <= bsc + 4'b0001;
	end


	// Update BIC
	always @(posedge clk) begin
		if (bsc == BIT_SENT)
			bic <= bic + 4'b0001; // Increment BIC if we're done sending a bit
		if (bic == BIC_END)
			bic <= 4'b0000;
	end

	// Shift right register
	always @(posedge clk) begin
		if (shift) begin
			data = data >> 1;
			data[9] = 1'b1;
		end

		if (load)
			data = {1'b0, parallel_in, 1'b1};
		else if (clear)
			data = 10'b1111111111;

	end

	// State logic
	always @(posedge clk) begin
		if (reset) begin
			ps <= INIT;
		end else begin
			ps <= ns;
		end
	end


endmodule
