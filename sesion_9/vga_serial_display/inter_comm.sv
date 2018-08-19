module inter_comm #(parameter PIXEL_COUNT =172800)(
	input logic clk,
	input logic reset,
	input logic tx_ready,
	input logic [7:0] data_in,
	output logic enable_flag,
	output logic [23:0] data_ram,
	output logic [address_bit-1:0] address
);
	//parametros locales
	localparam address_bit = $clog2(PIXEL_COUNT);
	localparam add_max = PIXEL_COUNT -'d1;
	//definicion estados
	enum logic [2:0] {wp_1,reg1,wp_2,reg2,wp_3,reg3,enable,ch_add} state,next_state;
	//logica estados
	logic pre_enable;
	logic [23:0] temp,pre_temp;
	logic [9:0] addr,n_addr;
	always_comb begin
		//defaults
		next_state = state;
		pre_enable = 'd0;
		n_addr = addr;
		pre_temp = temp;
		case(state)
			wp_1:	begin
				if(tx_ready) begin
					next_state = reg1;
				end
				else begin
					next_state = state;
				end
			end
			reg1:	begin
				pre_temp = {16'd0,data_in};
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
				pre_temp = {8'd0,data_in,temp[7:0]};
				next_state = wp_3;
			end
			wp_3:	begin
				if(tx_ready) begin
					next_state = reg3;
				end
				else begin
					next_state = state;
				end
			end
			reg3:	begin
				pre_temp = {data_in,temp[15:0]};
				next_state = enable;
			end
			enable:	begin
				next_state = ch_add;
				pre_enable = 'd1;
			end
			ch_add:	begin
				next_state = wp_1;
				n_addr = addr + 'd1;
			end
		endcase
	end
	//ff
	always_ff @(posedge clk) begin
		if(reset) begin
			state <= wp_1;
			enable_flag <= 'd0;
			temp <= 'd0;
			addr <= 'd0;
		end
		else begin
			state <= next_state;
			enable_flag <= pre_enable;
			temp <= pre_temp;
			if(addr == add_max) begin
				addr <= 'd0;
			end
			else begin
				addr <= n_addr;
			end
		end
	end
	assign address = addr;
	assign data_ram = temp;
endmodule
