module top(
    input logic [15:0] SW,
    input logic reset,
    input logic clk,
    input logic BTNL,
    input logic BTNR,
    output logic [6:0] cc
    );
    logic BTNL_clean;
    logic BTNR_clean;
    logic [15:0] salida_iz;
    logic [15:0] salida_de;
    logic [31:0] salida_general = {salida_iz,salida_de};
    PushButton_Debouncer2 #(.N(4)) DB1(.clk(clk),.rst(reset),.PB(BTNL),.PB_posedge(BTNL_clean));
    PushButton_Debouncer2 #(.N(4)) DB2(.clk(clk),.rst(reset),.PB(BTNR),.PB_posedge(BTNR_clean));
    FDCE #(.N(16)) E1(.clk(clk), .RST_BTN_n(reset), .switches(SW), .retain(BTNL_clean), .leds(salida_iz));
    FDCE #(.N(16)) E2(.clk(clk), .RST_BTN_n(reset), .switches(SW), .retain(BTNR_clean), .leds(salida_de));
endmodule
