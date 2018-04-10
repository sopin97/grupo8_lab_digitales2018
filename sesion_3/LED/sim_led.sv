`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2018 02:06:49 AM
// Design Name: 
// Module Name: simulacion_led
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


module simulacion_led();
	logic [15:0] bus_switch;
	logic [15:0] bus_led;

	led_switch DUT1(.LED(bus_led), .SW(bus_switch));

	initial begin
		bus_switch = 16'b0000_0000_0000_0000;
		#10
		bus_switch = 16'b1111_1111_1111_1111;
		#10
		bus_switch = 16'b1111_1111_0000_0000;
	end
endmodule
