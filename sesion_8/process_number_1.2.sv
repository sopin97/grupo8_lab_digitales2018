`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/07/2018 05:43:20 AM
// Design Name: 
// Module Name: process_numbers
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


module process_numbers(
	input [2:0] command,
	input logic [15:0] bit16_number,
	output logic [31:0] ascii_16_bit_number,
	output logic [127:0] ascii_16_bit_binary_number,
	output logic [7:0] char_command
    );
    
    always_comb begin
    	case(command)
    		3'b000: char_command = "+";
    		3'b001: char_command = "*";
    		3'b010: char_command = "&";
    		3'b100: char_command = "-";
    		3'b101: char_command = "|";
    		default:char_command = " ";
    	endcase
    end
    
    hex_to_ascii byte_0(
    	.hex_num(bit16_number[3:0]),
    	.ascii_conv(ascii_16_bit_number[7:0])
    );
    hex_to_ascii byte_1(
    	.hex_num(bit16_number[7:4]),
    	.ascii_conv(ascii_16_bit_number[15:8])
    );
    hex_to_ascii byte_2(
    	.hex_num(bit16_number[11:8]),
    	.ascii_conv(ascii_16_bit_number[23:16])
    );
    hex_to_ascii byte_3(
    	.hex_num(bit16_number[15:12]),
    	.ascii_conv(ascii_16_bit_number[31:24])
    );
    
	hex_to_bit_ascii Byte_0(
		.num(bit16_number[3:0]),
		.bit_ascii(ascii_16_bit_binary_number[31:0])
	);
	hex_to_bit_ascii Byte_1(
		.num(bit16_number[7:4]),
		.bit_ascii(ascii_16_bit_binary_number[63:32])
	);
	hex_to_bit_ascii Byte_2(
		.num(bit16_number[11:8]),
		.bit_ascii(ascii_16_bit_binary_number[95:64])
	);
	hex_to_bit_ascii Byte_3(
		.num(bit16_number[15:12]),
		.bit_ascii(ascii_16_bit_binary_number[127:96])
	);
endmodule
