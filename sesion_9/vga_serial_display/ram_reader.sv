// RAM_WIDTH -> tama;o de una palabra
// RAM_HEIGHT -> numero de "slots" en la RAM
module RAM_reader #(parameter RAM_WIDTH = 32)
(
  input logic [RAM_WIDTH-1:0] data,
  input logic rst, clk, visible,
  output logic [ADRESS_BITS-1:0] adress,
  output logic [RAM_WIDTH-1:0] data_out
);
  localparam RAM_DEPTH = (480*360*24)/RAM_WIDTH
  localparam MAX_ADRESS = 172800 - 1;
  localparam ADRESS_BITS = $clog2(RAM_DEPTH); // numero de bits de adress
	
  logic [ADRESS_BITS-1:0] next_adress;
  logic [RAM_WIDTH-1:0] next_output;
	
	enum logic [1:0] {DATA_AVAILABLE, DATA_UNAVAILABLE} next_state, state;

  always_ff @(posedge clk) begin
    if (rst) begin
      	data_out <= 'd0;
     	adress <= 'd0;
      	state <= IDLE;
    end
    else begin
    	data_out <= next_output;
    	adress <= next_adress;
     	state <= next_state;
    end
   end
  always_comb begin
    next_state = state;
    next_output = data_out;
    next_adress = adress;
    case(state)
      DATA_AVAILABLE: begin
	      next_output = data;
	      if (!visible)
		next_state = DATA_UNAVAILABLE;
	      if (adress >= MAX_ADRESS)
		      next_adress = 'd0;
	      else
		next_adress = adress + 'd1;
      end
      DATA_UNAVAILABLE: begin
	      next_output = 'd0;
	      next_adress = adress;
	      if (visible)
		      next_state = IDLE;
      endcase
    end
  endmodule
