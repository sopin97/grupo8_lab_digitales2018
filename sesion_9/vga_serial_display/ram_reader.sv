module RAM_reader #(parameter RAM_WIDTH = 8, parameter RAM_HEIGHT = (1024*768*3*8)/RAM_WIDTH)
(
  input logic [RAM_WIDTH-1:0] data,
  output logic [ADRESS_BITS-1:0] adress,
  output logic [7:0] tx_data,
  output logic tx_start
);
  localparam ADRESS_BITS = $clog2(RAM_HEIGHT);

endmodule
