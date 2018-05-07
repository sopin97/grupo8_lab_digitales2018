`timescale 1ns / 1ps

module FSM(
	input logic reset, BTNC, clk,
	output logic [1:0] estado
    );
    enum logic [1:0] {wait_op1, wait_op2, wait_op, show_result} state, next_state;
    
    always_ff @(posedge clk) begin
    	if (reset) begin
    		state <= wait_op1;
    	end
    	else begin
    		state <= next_state;
    	end
    end
    
    always_comb begin
    	next_state = wait_op1;
    	case (state)
    		wait_op1:	if (BTNC == 1) next_state = wait_op2;
    					else next_state = wait_op1;
    		wait_op2:	if (BTNC == 1) next_state = wait_op;
    					else next_state = wait_op2;
			wait_op:	if (BTNC == 1) next_state = show_result;
    					else next_state = wait_op;
			show_result:	if (BTNC == 1) next_state = wait_op1;
    						else next_state = show_result;
    		default:	next_state = wait_op1;
    	endcase
    end
    assign estado = state;
endmodule
