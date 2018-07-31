`timescale 1ns / 1ps
module UART_rx_control_wrapper
(
	input  logic           clock,
    input  logic           reset,
    output logic [15:0] operando1,
    output logic [15:0] operando2,
    output logic [2:0] ALU_ctrl,
    input logic [7:0]     rx_data, // N°2 output rx_data
    input logic           rx_ready, // N°3 output rx_ready
    output logic output_ready
    );
logic [1:0] stateID;
logic send16, ready;
logic [15:0] rx_temp_data;

logic next_output_ready;
logic [15:0] next_op1, next_op2;
logic [2:0] ALU_cmd;

RX_control RX_control_inst0
(
	.clock (clock),
	.reset (reset),
	.rx_input_data (rx_data), // Se cambio a rx
	.send16 (send16),
	.ready(ready),
	.rx_data (rx_temp_data), 
	.rx_ready (rx_ready)
    );

TX_sequence TX_sequence_inst0 
(
	.clock (clock),
	.reset (reset),
	.send16 (send16),
	.ready (ready),
	.stateID(stateID)
    );
    
    
    
always_comb begin

	next_op1 = operando1;
	next_op2 = operando2;
	ALU_cmd = ALU_ctrl;
	next_output_ready = 1'b0;

	case (stateID)
		2'b00: begin
		
		end
		2'b01: begin
			next_op1 = rx_temp_data;
		end
		2'b10: begin
			next_op2 = rx_temp_data;
		end
		2'b11: begin
			ALU_cmd = rx_temp_data[2:0];
			next_output_ready = 1'b1;
		end
	endcase
end

always_ff @(posedge clock) begin
	if (reset) begin
		operando1 <= 'd0;
		operando2 <= 'd0;
		ALU_ctrl <= 'd0;
	end
	else begin
		operando1 <= next_op1;
		operando2 <= next_op2;
		ALU_ctrl <= ALU_cmd;
		output_ready <= next_output_ready;
	end
end

endmodule
