`timescale 1ns / 1ps
module RX_control
(
	input  logic           clock,
	input  logic           reset,
	input  logic [7:0]	   rx_input_data,
	input  logic           rx_ready,        // Push Button
	input  logic           send16,         // Indica si se deben enviar 8 o 16 bits
	output logic [15:0]    rx_data,        // Datos entregados al driver UART para transmision
	output logic		   ready
    );
    
    
    logic [15:0] next_data; // Dato a salir
    logic [7:0] next_data1, next_data2, data1, data2;
    enum logic [1:0] {IDLE, RECIEVE_BYTE_0, INTER_DELAY_1, RECIEVE_BYTE_1, RX_DATA_READY} state, next_state;
	
	always_comb begin
		next_data1 = data1;
		next_data2 = data2;
		next_state = state;
		next_data = rx_data; // variables para maquina de estado
		ready = 1'b0; // vale 1 si se completa la accion
		case (next_state)
		
			IDLE: begin
				if (rx_ready) begin
					next_state = RECIEVE_BYTE_0;
				end
			end
			
			RECIEVE_BYTE_0: begin
				next_data1 = rx_input_data;
				next_state = INTER_DELAY_1;
			end
			
			INTER_DELAY_1:
				if (send16) begin
					if (rx_ready) begin
						next_state = RECIEVE_BYTE_1;
					end
				end
				else begin
					next_state = RX_DATA_READY;
				end
			
			RECIEVE_BYTE_1: begin
				next_data2 = rx_input_data;
				next_state = RX_DATA_READY;			
			end

			RX_DATA_READY: begin
				next_data = {data1, data2};
				ready = 1'b1;
				next_state = IDLE;		
			end		
		
		endcase
	end
	
	always_ff @(posedge clock)
	
	begin
		if (reset) begin
			data1 <= 0;
			data2 <= 0;
			state <= IDLE;
			rx_data <= 'd0;
		end
		else begin
			data1 <= next_data1;
			data2 <= next_data2;
			state <= next_state;
			rx_data <= next_data;
		end
	
	end

endmodule
