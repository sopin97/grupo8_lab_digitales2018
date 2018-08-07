`timescale 1ns / 1ps

module procces_input_screen(
	input logic [4:0] val,
	input logic enter_button,
	input logic clk,
	input logic rst,
	output logic [15:0] output_number
    );
    logic [15:0] next_output;
    logic [19:0] temp;
    always_comb begin
    	temp = {output_number, val[3:0]};
    	case(enter_button)
    		1'b0:;
    		1'b1: begin
			if ((val[4] == 0) && (temp[19:16] == 'd0)) begin
    				temp = temp << 4;
    			end
    		end
    	endcase
    end
    
    always_ff @(posedge clk) begin
    	if (rst) begin
    		output_number <= 'd0;
    	end
    	else begin
    		output_number <= temp[19:4];
    	end
    end
endmodule
