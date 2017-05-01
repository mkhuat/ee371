module DisplayState(state, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [3:0] state;
    output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    
	parameter boat = 7'b0111111;
	parameter wall_in = 7'b1001111;
	parameter wall_in_boat = 7'b1001110;
	parameter wall_out = 7'b1111001;
	parameter wall_out_boat = 7'b1111000;
	parameter empty = 7'b1111111;
	
	always @(*)
		begin
		// 0. 88|88|88
		// 1. -8|88|88 
		// 2. 8-|88|88
		// 3. 88 -8|88
		// 4. 88|-8|88
		// 5. 88|8-|88
		// 6. 88|88 -8
		// 7. 88|88|-8
		// 8. 88|88|8-
		// 9. 8- 88|88
		// 10.88|8- 88
			case(state)
				'd0: begin
					HEX5 = empty;
					HEX4 = empty;
					HEX3 = wall_in;
					HEX2 = wall_out;
					HEX1 = empty;
					HEX0 = empty;
				end
				'd1: begin
					HEX5 = boat;
					HEX4 = empty;
					HEX3 = wall_in;
					HEX2 = wall_out;
					HEX1 = empty;
					HEX0 = empty;
				end
				'd2: begin
					HEX5 = empty;
					HEX4 = boat;
					HEX3 = wall_in;
					HEX2 = wall_out;
					HEX1 = empty;
					HEX0 = empty;
				end
				'd3: begin
					HEX5 = empty;
					HEX4 = empty;
					HEX3 = boat;
					HEX2 = wall_out;
					HEX1 = empty;
					HEX0 = empty;
				end
				'd4: begin
					HEX5 = empty;
					HEX4 = empty;
					HEX3 = wall_in_boat;
					HEX2 = wall_out;
					HEX1 = empty;
					HEX0 = empty;
				end
				'd5: begin
					HEX5 = empty;
					HEX4 = empty;
					HEX3 = wall_in;
					HEX2 = wall_out_boat;
					HEX1 = empty;
					HEX0 = empty;
				end
				'd6: begin
					HEX5 = empty;
					HEX4 = empty;
					HEX3 = wall_in;
					HEX2 = empty;
					HEX1 = boat;
					HEX0 = empty;
				end
				'd7: begin
					HEX5 = empty;
					HEX4 = empty;
					HEX3 = wall_in;
					HEX2 = wall_out;
					HEX1 = boat;
					HEX0 = empty;
				end
				'd8: begin
					HEX5 = empty;
					HEX4 = empty;
					HEX3 = wall_in;
					HEX2 = wall_out;
					HEX1 = empty;
					HEX0 = boat;
				end
				'd9: begin 
					HEX5 = empty;
					HEX4 = boat;
					HEX3 = empty;
					HEX2 = wall_out;
					HEX1 = empty;
					HEX0 = empty;
				end
				'd10: begin
					HEX5 = empty;
					HEX4 = empty;
					HEX3 = wall_in;
					HEX2 = boat;
					HEX1 = empty;
					HEX0 = empty;
				end
				default: begin
					HEX5 = empty;
					HEX4 = empty;
					HEX3 = wall_in;
					HEX2 = wall_out;
					HEX1 = empty;
					HEX0 = empty;
				end
			endcase
		
		end

endmodule
