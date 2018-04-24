module top(
    input logic [15:0] SW,
    input logic reset,
    input logic clk,
    input logic BTNL,
    input logic BTNR,
    output logic [6:0] cc
    );
    logic [15:0] salida_iz;
    logic [15:0] salida_de;
    logic [31:0] salida_general = {salida_iz,salida_de};
    FDCE #(.N(16)) E1(.clk(clk), .RST_BTN_n(reset), .switches(SW), .retain(BTNL), .leds(salida_iz));
    FDCE #(.N(16)) E2(.clk(clk), .RST_BTN_n(reset), .switches(SW), .retain(BTNR), .leds(salida_de));
endmodule
