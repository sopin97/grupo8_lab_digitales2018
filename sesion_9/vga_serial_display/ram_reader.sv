// RAM_WIDTH -> tama;o de una palabra
// RAM_HEIGHT -> numero de "slots" en la RAM
module RAM_reader #(parameter RAM_WIDTH = 32, parameter RAM_DEPTH = (480*360*24)/RAM_WIDTH)
(
  input logic [RAM_WIDTH-1:0] data,
  input logic rst, clk, pixel_clk,
  input logic visible,
  output logic [ADRESS_BITS-1:0] adress,
  output logic [RAM_WIDTH-1:0] data_out
);
  localparam MAX_ADRESS = 129600 - 1;
  localparam ADRESS_BITS = $clog2(RAM_DEPTH); // numero de bits de adress
  logic [ADRESS_BITS-1:0] next_adress;
  
  enum logic [1:0] {IDLE, READ_DATA, REFRESH_ADRESS, WAIT} next_state, state;
  logic [ADRESS_BITS-1:0] next_adress;
  logic [RAM_WIDTH-1:0] next_output;
  logic refresh_data;
  
  always_ff@(posedge clk) begin
    if(visible) begin
      refresh_data <= pixel_clk;
    end
    else begin
      refresh_data <= 'd0;
    end
  end

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
      IDLE: begin
        if (refresh_data)
          next_state = READ_DATA;
      end
      READ_DATA: begin
        next_output = data;
        next_state = REFRESH_ADRESS;
      end
      REFRESH_ADRESS: begin
        next_state = WAIT;
        if (adress >= MAX_ADRESS)
          next_adress = adress + 'd0;
        else
          next_adress = adress + 'd1;
      end
      WAIT: begin
        if (!refresh_data)
          next_state = IDLE;
      end
      endcase
    end
  endmodule
