`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2018 02:09:56
// Design Name: 
// Module Name: test_one_lin
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


module test_one_lin(
	input logic CLK100MHZ,
	input logic CPU_RESETN,
	input logic [5:0] SW_d,
	input logic UART_TXD_IN, SW,SW_D,
	output logic [3:0] VGA_R, VGA_G, VGA_B,
	output logic VGA_HS,VGA_VS
    );
    //parametros 
    localparam width_i = 480;
    localparam height_i = 360;
    localparam add_bit = $clog2(width_i*height_i);
    
    
    logic hw_reset = ~CPU_RESETN;
    logic [7:0] data_uart;
    logic rx_flag;
    logic [23:0] data_ram,r_data,data_vga,data_dithering, data_gray;
    logic e_flag, pixel_clk, visible;
    logic [add_bit -1:0] address, r_address;
    logic [10:0] hc,vc;
    logic [7:0] R,G,B;
    //INTER COMUNICADOR
    inter_comm #(.PIXEL_COUNT(480*360)) COMOL(
		.clk(CLK100MHZ),
		.reset(hw_reset),
		.tx_ready(rx_flag),
		.data_in(data_uart),
		.enable_flag(e_flag),
		.data_ram(data_ram),
		.address(address)
		);
	//UART
	uart_basic UARTOL(
		.clk(CLK100MHZ),
		.reset(hw_reset),
		.rx(UART_TXD_IN),
		.rx_data(data_uart),
		.rx_ready(rx_flag)
		);
	//BRAM
	blk_mem_gen_1 BRAMOL (
	  	.clka(CLK100MHZ),    // input wire clka
	  	.wea(e_flag),      // input wire [0 : 0] wea
	  	.addra(address),  // input wire [8 : 0] addra
	  	.dina(data_ram),    // input wire [23 : 0] dina
	  	.clkb(pixel_clk),    // input wire clkb
	  	.addrb(r_address),  // input wire [8 : 0] addrb
	  	.doutb(r_data)  // output wire [23 : 0] doutb
		);
	RAM_reader #(.RAM_WIDTH(24),.N_BITS(480*360*24))READ(
		.data(r_data),
		.rst(hw_reset),
		.clk(pixel_clk),
		.visible(visible),
		.adress(r_address),
		.data_out(data_vga)
		);
	driver_vga_480x360 DRVGA1( //driver modificado
		.clk_vga(pixel_clk),
		.hs(VGA_HS),
		.vs(VGA_VS),
		.hc_visible(hc),
		.vc_visible(vc)
		);
	clk_vga_480_360 PXCLK(
    	.clk_out1(pixel_clk),// output clk_out1
    	.reset(hw_reset), // input reset
    	.clk_in1(CLK100MHZ) // input clk_in1
    	);
    visible_area VSBL(
    	.visible(visible),
    	.hc(hc),
    	.vc(vc)
    	);
    //FILTROS
    dithering_top(
    	.data_in(data_vga),
    	.clk(pixel_clk),
    	.rst(hw_reset),
    	.SW(SW_D),
    	.visible(visible),
    	.data_out(data_dithering)
    	);
    gray_scaler GRAY(
    	.SW(SW),
    	.input_line(data_dithering),
    	.gray_scaled(data_gray)
    	);
    //DEMUX FINAL
    demux_rgb RED(
    	.channel(data_gray),
    	.switches(SW_d[5:4]),
    	.channel_out(R)
    	);
    demux_rgb GREEN(
    	.channel(data_gray),
    	.switches(SW_d[3:2]),
    	.channel_out(G)
    	);
    demux_rgb BLUE(
    	.channel(data_gray),
    	.switches(SW_d[1:0]),
    	.channel_out(B)
    	);
    	
    	
    assign VGA_B = B[7:4];
    assign VGA_G = G[7:4];
    assign VGA_R = R[7:4];
endmodule
