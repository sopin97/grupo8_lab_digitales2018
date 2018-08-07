
`timescale 1ns / 1ps

module procces_input_screen(
	input logic [4:0] val,
	input logic enter_button,
	output logic [15:0] op1, op2,
	output logic [2:0] op,
	input logic clk,
	input logic rst,
	output logic [15:0] output_number
    );
    logic [15:0] resultado;
    logic overflow;
    logic result_ready;
    
    ALU_generalizado #(.n_bits(16)) ALU1
    (
    	.entrada_a(op1),
    	.entrada_b(op2),
    	.operacion(op),
    	.resultado(resultado),
    	.overflow(overflow)
    );
    
    enum logic [1:0] {OP1, OP2, ALU_CMD, SHOW_RESULT} state, next_state;
    always_comb begin
    	next_state = state;
    	case(state)
    		OP1: begin
    			if(enter_button)begin
    				if(val == 5'b1_0011)
    					next_state = OP2;
    			end
    		end
    		OP2: begin
    			if(enter_button)begin
    				if(val == 5'b1_0011)
    					next_state = ALU_CMD;
    			end
    		end
    		ALU_CMD: begin
    			if(enter_button)begin
    				if(val == 5'b1_0011)
    					next_state = SHOW_RESULT;
    			end
    		end
    		SHOW_RESULT: begin
    			if(enter_button)begin
    				if(val == 5'b1_0011)
    					next_state = OP1;
    			end
    		end
    	endcase
    end
    
    always_ff @(posedge clk) begin
        	if (rst) begin
        		state <= OP1;
        	end
        	else begin
        		state <= next_state;
        	end
        end

    logic [19:0] temp;
    always_comb begin
    	temp = {output_number, val[3:0]};
    	case(enter_button)
    		1'b0: begin
    			if (result_ready == 1'b1) begin
    	    		temp = {resultado, val};
    	    	end
    	    end
    		1'b1: begin
    			if (((val[4] == 0) && (temp[19:16] == 'd0)) && (result_ready == 1'b0)) begin
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
    
    logic [15:0] next_op1, next_op2;
	logic [2:0] next_op;
    always_comb begin
    	next_op1 = op1;
    	next_op2 = op2;
    	next_op = op;
    	result_ready = 1'b0;
    	case(state)
    		OP1:begin
    			if(enter_button)begin
    				if(val == 5'b1_0011)
    					next_op1 = temp[19:4];
    			end
    		end
    		OP2:begin
    			if(enter_button) begin
    				if(val == 5'b1_0011)
    					next_op2 = temp[19:4];
    			end
    		end
    		ALU_CMD:begin
    			if(enter_button) begin
    				if(val == 5'b1_0011)
    					next_op = val[2:0];
    			end
    		end
    		SHOW_RESULT: begin
    			result_ready = 1'b1;
    		end
    	endcase
    end
    
    always_ff @(posedge clk) begin
    	if (rst) begin
    		op1 <= 'd0;
    		op2 <= 'd0;
    		op <= 'd0;
    	end
    	else begin
    		op1 <= next_op1;
    	    op2 <= next_op2;
    	    op <= next_op;
    	end
    end
endmodule
