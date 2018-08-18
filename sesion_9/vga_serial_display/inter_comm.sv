module inter_comm(
	input logic clk,
	input logic reset,
	input logic tx_ready,
	input logic [7:0] data_in,
	output logic enable
	output logic [23:0] data_ram
);
	//definicion estados
	enum logic [2:0] {wp_1,reg1,wp_2,reg2,wp_3,reg3,enable,ch_add} state,next_state;
	//logica estados
	always_comb begin
		//defaults
		next_state = state;
		case(state) begin
			wp_1:	begin
				if(tx_ready) begin
					next_state = reg1;
				end
				else begin
					next_state = state;
				end
			end
			reg1:	begin
				next_state = wp_2;
			end
			wp_2:	begin
				if(tx_ready) begin
					next_state = reg2;
				end
				else begin
					next_state = state;
				end
			end
			reg2:	begin
				next_state = wp_3;
			end
			wp_3:	begin
				if(rx_ready) begin
					next_state = reg3;
				end
				else begin
					next_state = state;
				end
			end
			reg3:	begin
				if(tx_ready) begin
					next_state = enable;
				end
				else begin
					next_state = state;
				end
			end
			enable:	begin
				
