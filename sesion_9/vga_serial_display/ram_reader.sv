// RAM_WIDTH -> cantidad de bits que guarda informacion
// RAM_HEIGHT -> numero de "slots" en la RAM
module RAM_reader #(parameter RAM_WIDTH = 8, parameter RAM_DEPTH = (1024*768*3*8)/RAM_WIDTH)
(
  input logic [RAM_DEPTH-1:0] data,
  input logic rst, clk,
  output logic [ADRESS_BITS-1:0] adress,
  output logic [7:0] tx_data,
  output logic tx_start, read_enable
);
  localparam ADRESS_BITS = $clog2(RAM_DEPTH); // numero de bits de adress
  
  enum logic [2:0] {START, READ_DATA, WAIT, SEND_DATA, REFRESH_ADRESS} next_state, state;
  logic [ADRESS_BITS-1:0] next_adress;
  logic [7:0] next_output;
  
  localparam MAX_COUNTER = 100000;
  
  logic [31:0] counter, next_counter;
  
  always_ff @(posedge clk) begin
    if (rst) begin
      counter <= 'd0;
      tx_data = 'd0;
      state <= START;
      adress <= 'd0;
    end
    else begin
      counter <= next_counter;
      tx_data = next_output;
      state <= next_state;
      if (adress >= RAM_DEPTH)
        adress <= 'd0;
      else
        adress <= next_adress;
  end
  
  always_comb begin
    next_state = state;
    next_adress = adress;
    next_output = tx_data;
    next_counter = 'd0;
    tx_start = 1'b0;
    read_enable = 1'b0
    case(state)
      START:  begin
        next_state = SET_ADRESS;
        next_adress = 'd0;
        next_output = 'd0;
      end
      READ_DATA: begin
        read_enable = 1'b1;
        next_state = SEND_DATA;
        next_output = data;
      SEND_DATA: begin
        next_state = WAIT;
        tx_start = 1'b1;
      end
      WAIT: begin
        next_counter = counter + 'd1;
        if (counter >= COUNTER_MAX)
          next_state = REFRESH_ADRESS;
      end
      REFRESH_ADRESS: begin
        next_state = READ_DATA;
        next_adress = adress + 'd1;
    endcase
  end

endmodule
