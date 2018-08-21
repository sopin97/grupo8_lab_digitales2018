module gray_scaler (
	input logic SW, //SWITCH 1
	input logic [23:0] input_line,
	output logic [23:0] gray_scaled
);
	always_comb begin
		//defaults
		case(SW)
			1'b0:	gray_scaled = input_line;
			1'b1:	gray_scaled = (((input_line[7:0] *30)/10) + ((input_line[15:8] *59)/100) + ((input_line[23:16] *11)/100));
			default: gray_scaled = input_line;
		endcase
	end
endmodule
