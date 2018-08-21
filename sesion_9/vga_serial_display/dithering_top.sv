module dithering_top (
  input logic [23:0] data_in,
  output logic [23:0] data_out,
  input logic clk, rst, SW, visible
);
  logic [3:0] dith_red_out, dith_green_out, dith_blue_out;
  dithering_8bit RED_dithering(
    .entrada_color_8_bit(data_in[7:0]),
    .clk(clk), .rst(rst),
    .salida_color_8_bit(dith_red_out),
    .visible(visible)
);
  dithering_8bit GREEN_dithering(
    .entrada_color_8_bit(data_in[15:8]),
    .clk(clk), .rst(rst),
    .salida_color_8_bit(dith_green_out),
    .visible(visible)
);
  dithering_8bit BLUE_dithering(
    .entrada_color_8_bit(data_in[23:16]),
    .clk(clk), .rst(rst),
    .salida_color_8_bit(dith_blue_out),
    .visible(visible)
);

  always_comb begin
    case (SW)
      1'b0: data_out = data_in;
      1'b1: data_out = (visible == 1'b1)? {dith_blue_out,  dith_green_out, dith_red_out, 4'b0}:24'd0;
    endcase
  end
endmodule
