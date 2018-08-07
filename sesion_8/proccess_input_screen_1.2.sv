
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
    logic reset_screen;
    
    ALU_generalizado #(.n_bits(16)) ALU1
    (
    	.entrada_a(op1),
    	.entrada_b(op2),
    	.operacion(op),
    	.resultado(resultado),
    	.overflow(overflow)
    );
    
    enum logic [2:0] {OP1, RST1,  OP2, RST2, ALU_CMD, SHOW_RESULT, RST3} state, next_state;
    always_comb begin
    	next_state = state;
    	output_number = 'd0;
    	case(state)
    		OP1: begin
    			output_number = op1;
    			if(enter_button)begin
    				if(val == 5'b1_0011) 
    					next_state = RST1;
    				else if (val == 5'b1_0110)
    					next_state = RST3;
    				else if (val == 5'b1_0111)
    					next_state = RST3;
    			end
    		end
     		RST1: begin
    			next_state = OP2;
    		end
    		OP2: begin
    			output_number = op2;
    			if(enter_button)begin
    				if(val == 5'b1_0011)
    					next_state = RST2;
    				else if(val == 5'b1_0110)
    					next_state = RST1;
     				else if (val == 5'b1_0111)
    						next_state = RST3;
    			end
    			end
    		RST2: begin
    				next_state = ALU_CMD;
    			end
    		ALU_CMD: begin
    			if(enter_button)begin
    				if((val == 5'b1_0011) && (op != 3'b111))
    					next_state = SHOW_RESULT;
    				else if(val == 5'b1_0110)
    					next_state = RST2;
    				else if (val == 5'b1_0111)
    					next_state = RST3;
    			end
    		end
    		SHOW_RESULT: begin
    		output_number = resultado;
    			if (enter_button)
    				if(val == 5'b1_0011)
    					next_state = RST3;
    				else if (val == 5'b1_0111)
    					next_state = RST3;
    		end
    		RST3: begin
    			next_state = OP1;
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

    logic [15:0] next_op1, next_op2;
	logic [2:0] next_op;
    always_comb begin
    	next_op1 = op1;
    	next_op2 = op2;
    	next_op = op;
    	
    	case(state)
    		OP1:begin
    			next_op = 'b111;
    			if(enter_button)begin
    				if((val[4] == 1'b0) && ({op1,val[3:0]} <= 'hFFFF))
    					next_op1 = {op1[11:0], val[3:0]};//temp[19:4];
    			end
    		end
    		RST1:
    			next_op2 = 'd0;
    		OP2:begin
    			if(enter_button) begin
    				if((val[4] == 1'b0) && ({op2,val[3:0]} <= 'hFFFF))
    					next_op2 = {op2[11:0], val[3:0]};//temp[19:4];
    			end
    		end
    		RST2:
    			next_op = 'b111;
    		ALU_CMD:begin
    			if(enter_button) begin
    				if((val[4] == 1'b1) && (val != 5'b1_0011) && (val != 5'b1_0110) && (val != 5'b1_0111))
    					next_op = val[2:0];
    			end
    		end
    		SHOW_RESULT: begin
    		end
    		RST3: begin
    			next_op1 = 'd0;
    		    next_op2 = 'd0;
    		    next_op = 'b111;
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
