`timescale 1ns / 1ps

module top_modulo(
	input logic [15:0] SW,
	input logic BTNR, BTNL, CLK100MHZ, reset,
	output logic [7:0] AN,
	output logic [6:0] sevenSeg
    );
    logic BTNR_clean, BTNL_clean;
    logic [15:0] retain_output1, retain_output2;
    logic [31:0] numero_display = {retain_output1, retain_output2};
    
    PushButton_Debouncer DEB1 (
    	.clk(CLK100MHZ),
    	.PB(BTNL),
    	.PB_state(BTNL_clean),
    	.rst(1'b0)
    );
    PushButton_Debouncer DEB2 (
        .clk(CLK100MHZ),
        .PB(BTNR),
        .PB_state(BTNR_clean),
        .rst(1'b0)	
        );
    FDCEmod #(16) MOD1 (
    	.clk(CLK100MHZ),
    	.reset(~reset),
    	.switches(SW),
    	.retain(~BTNL_clean),
    	.retain_output(retain_output1)
    );
    FDCEmod #(16) MOD2 (
    	.clk(CLK100MHZ),
    	.reset(~reset),
    	.switches(SW),
    	.retain(~BTNR_clean),
    	.retain_output(retain_output2)        
        );
    display_hex DIS1 (
    	.numero_entrada(numero_display),
    	.clk(CLK100MHZ),
    	.power_on(1'b1),
    	.ANODO(AN),
    	.SEG(sevenSeg)
    );
    
endmodule
