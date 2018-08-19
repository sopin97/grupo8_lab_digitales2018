`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2018 14:34:52
// Design Name: 
// Module Name: test_bram
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


module test_bram(
	input logic CLK100MHZ,
	input logic UART_TXD_IN,
	input logic BTNC, CPU_RESETN,
	output logic [7:0] AN,
	output logic [6:0] SEG
    );
    logic hw_reset = ~CPU_RESETN;
    logic [7:0] data_uart;
    logic rx_ready;//,enable_flag;
    //logic [23:0] pre_ram;
    //logic [31:0] ram_data = {8'd0,pre_ram};
    logic [7:0] ram_out;
    //logic address,r_address;
    logic BTNC_clean;
    logic [31:0] display;
    
    
    uart_basic UART_ram(
    	.clk(CLK100MHZ),
    	.reset(hw_reset),
    	.rx(UART_TXD_IN),
    	.rx_data(data_uart),
    	.rx_ready(rx_ready)
    	);
   // inter_comm COMM(
   // 	.clk(CLK100MHZ),
   // 	.reset(hw_reset),
   // 	.tx_ready(rx_ready),
   // 	.data_in(data_uart),
   // 	.enable_flag(enable_flag),
   // 	.data_ram(pre_ram),
   // 	.address(address)
   // 	);
  //  blk_mem_gen_0 your_instance_name (
  //  	  .clka(CLK100MHZ),    // input wire clka
  //  	  .ena(enable_flag),      // input wire ena    
  //  	  .addra(address),  // input wire [9 : 0] addra
  // 	  .dina(ram_data),    // input wire [31 : 0] dina
  //  	  .clkb(CLK100MHZ),    // input wire clkb
  //  	  .addrb(r_address),  // input wire [9 : 0] addrb
   // 	  .doutb(ram_out)  // output wire [31 : 0] doutb
   // 	);
	bram_1 your_instance_name (
    	  .clka(CLK100MHZ),    // input wire clka
    	  .ena('d1),      // input wire ena
    	  .wea('d1),      // input wire [0 : 0] wea
    	  .addra('d1),  // input wire [0 : 0] addra
    	  .dina(8'd15),    // input wire [7 : 0] dina
    	  .clkb(CLK100MHZ),    // input wire clkb
    	  .addrb('d1),  // input wire [0 : 0] addrb
    	  .doutb(ram_out)  // output wire [7 : 0] doutb
    	);
	unsigned_to_bcd u32_to_bcd_inst (
    		.clk(CLK100MHZ),
    		.trigger('d1),
    		.in({24'd0,ram_out}),
    		.bcd(display)
    	);
    display_hex HEX(
    	.clk(CLK100MHZ),
    	.numero_entrada(display),
    	.power_on('d1),
    	.SEG(SEG),
    	.ANODO(AN)
    	);

endmodule
