module ReceiveComm(clk, reset, serial_in, parallel_out, char_received, data);

	input wire clk, reset;
	input wire serial_in;
	output reg [7:0] parallel_out;
	output reg char_received;


	// Enable signals
	reg hold, shift;

	reg [3:0] ps, ns;
	output reg [9:0] data;

	reg [3:0] bic;
	reg [3:0] bsc;

	parameter

		// Overall state encodings
		IDLE = 4'b0000,
		SAMPLING = 4'b0001,

		// BIC encodings
		BIC_END = 4'b1011,

		// BSC encodings
		BSC_START = 4'b0000,
		BSC_MIDDLE = 4'b0111,
		BSC_END = 4'b1111;


	// Combinational logic
	always @(*) begin

		// Steady-state instructions
		ns = ps;
		hold = 1'b0;
		shift = 1'b0;

		case (ps)
			IDLE:
				begin
					if (~serial_in) begin
						ns = SAMPLING;
						hold = 1'b1;
						//shift = 1'b1;
						char_received =1'b0;
					end
				end
			SAMPLING:
				begin

					// Got to end of byte
					if (bic == BIC_END) begin
						ns = IDLE;
						char_received = 1'b1;
						parallel_out = data[8:1];

					// Sample bits for our byte
					end else begin
						if (bsc == BSC_MIDDLE) begin
							shift = 1'b1;
						end else begin
							shift = 1'b0;
						end
					end
				end
			default:
				begin
					ns = ps;
					hold = 1'b0;
					shift = 1'b0;
				end
		endcase
	end

	// Update Bit Identification Count (BIC)
	always @(posedge clk) begin
		if (bsc == BSC_END)
			bic <= bic + 4'b0001;
	end

	// Bit Sampling Count (BSC) counter
	always @(posedge clk) begin
		if (hold)
			bsc <= 4'b0000;
		else
			bsc <= bsc + 4'b0001;
	end

	// Shift register
	always @(posedge clk) begin
		 if (shift) begin
			data = data << 1;
			data[0] = serial_in;
		 end
	end

	// State logic
	always @(posedge clk) begin
		if (reset) begin
			ps <= IDLE;
		end else begin
			ps <= ns;
		end
	end

endmodule
