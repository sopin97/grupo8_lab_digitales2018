`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2018 07:56:10 AM
// Design Name: 
// Module Name: sim_topsimulation
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim_topsimulation();

	logic [15:0] switch;
	logic clk, reset;
	logic [0:6] sevenSeg;
	logic [3:0] AN;

	top_module DUT2(.SW(switch),.CLK100MHZ(clk),.sevenSeg(sevenSeg),.AN(AN),.reset(reset));

	always #5 clk = ~clk;
	
	initial begin
		switch = 16'b0000_0000_0000_0000;
		clk = 1'b0;
		reset = 1'b1;
		#28
		reset = 1'b0;
		#2
		#22
		switch = 16'b0000_1111_0000_1111;
	end
endmodule
