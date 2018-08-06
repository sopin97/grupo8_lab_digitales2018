`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2018 04:02:55 AM
// Design Name: 
// Module Name: print_on_template
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


module print_on_template(
	input logic [10:0] hc_visible,
	input logic [10:0] vc_visible,
	input logic rst, clk_vga,
	output logic in_square,
	output logic in_char
    );
    parameter X0 = 0;
    parameter X1 = 100;
    parameter X2 = 200;
    parameter X3 = 300;
    parameter X4 = 400;
    parameter X5 = 500;
    parameter Y0 = 0;
    parameter Y1 = 100;
    parameter Y2 = 200;
    parameter Y3 = 300;
    localparam X_OFFSET = 10;
    localparam Y_OFFSET = 10;
    
    logic [25:0] in_squares;
    logic [25:0] in_chars;
    
    assign in_square = |in_squares;
    assign in_char = |in_chars;
    
    show_one_char #(.CHAR_X_LOC(X0+X_OFFSET), 
    				.CHAR_Y_LOC(Y0+Y_OFFSET)) 
    	ch_01(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("0"), 
    		  .in_square(in_squares[0]), 
    		  .in_character(in_chars[0]));

    show_one_char #(.CHAR_X_LOC(X1+X_OFFSET), 
    				.CHAR_Y_LOC(Y0+Y_OFFSET))
    	ch_02(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("1"), 
    		  .in_square(in_squares[1]), 
    		  .in_character(in_chars[1]));

    show_one_char #(.CHAR_X_LOC(X2+X_OFFSET), 
    				.CHAR_Y_LOC(Y0+Y_OFFSET)) 
    	ch_03(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("2"), 
    		  .in_square(in_squares[2]), 
    		  .in_character(in_chars[2]));

    show_one_char #(.CHAR_X_LOC(X3+X_OFFSET), 
    				.CHAR_Y_LOC(Y0+Y_OFFSET))
    	ch_04(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("3"), 
    		  .in_square(in_squares[3]), 
    		  .in_character(in_chars[3]));

    show_one_char #(.CHAR_X_LOC(X4+X_OFFSET), 
    				.CHAR_Y_LOC(Y0+Y_OFFSET)) 
    	ch_05(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("+"), 
    		  .in_square(in_squares[4]), 
    		  .in_character(in_chars[4]));

    show_one_char #(.CHAR_X_LOC(X5+X_OFFSET), 
    				.CHAR_Y_LOC(Y0+Y_OFFSET))
    	ch_06(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("-"), 
    		  .in_square(in_squares[5]), 
    		  .in_character(in_chars[5]));

    show_one_char #(.CHAR_X_LOC(X0+X_OFFSET), 
    				.CHAR_Y_LOC(Y1+Y_OFFSET)) 
    	ch_07(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("4"), 
    		  .in_square(in_squares[6]), 
    		  .in_character(in_chars[6]));

    show_one_char #(.CHAR_X_LOC(X1+X_OFFSET), 
    				.CHAR_Y_LOC(Y1+Y_OFFSET))
    	ch_08(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("5"), 
    		  .in_square(in_squares[7]), 
    		  .in_character(in_chars[7]));

    show_one_char #(.CHAR_X_LOC(X2+X_OFFSET), 
    				.CHAR_Y_LOC(Y1+Y_OFFSET)) 
    	ch_09(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("6"), 
    		  .in_square(in_squares[8]), 
    		  .in_character(in_chars[8]));

    show_one_char #(.CHAR_X_LOC(X3+X_OFFSET), 
    				.CHAR_Y_LOC(Y1+Y_OFFSET))
    	ch_10(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("7"), 
    		  .in_square(in_squares[9]), 
    		  .in_character(in_chars[9]));

    show_one_char #(.CHAR_X_LOC(X4+X_OFFSET), 
    				.CHAR_Y_LOC(Y1+Y_OFFSET)) 
    	ch_11(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("*"), 
    		  .in_square(in_squares[10]), 
    		  .in_character(in_chars[10]));

    show_one_char #(.CHAR_X_LOC(X5+X_OFFSET), 
    				.CHAR_Y_LOC(Y1+Y_OFFSET))
    	ch_12(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("|"), 
    		  .in_square(in_squares[11]), 
    		  .in_character(in_chars[11]));

    show_one_char #(.CHAR_X_LOC(X0+X_OFFSET), 
    				.CHAR_Y_LOC(Y2+Y_OFFSET)) 
    	ch_13(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("8"), 
    		  .in_square(in_squares[12]), 
    		  .in_character(in_chars[12]));

    show_one_char #(.CHAR_X_LOC(X1+X_OFFSET), 
    				.CHAR_Y_LOC(Y2+Y_OFFSET))
    	ch_14(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("9"), 
    		  .in_square(in_squares[13]), 
    		  .in_character(in_chars[13]));

    show_one_char #(.CHAR_X_LOC(X2+X_OFFSET), 
    				.CHAR_Y_LOC(Y2+Y_OFFSET)) 
    	ch_15(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("A"), 
    		  .in_square(in_squares[14]), 
    		  .in_character(in_chars[14]));

    show_one_char #(.CHAR_X_LOC(X3+X_OFFSET), 
    				.CHAR_Y_LOC(Y2+Y_OFFSET))
    	ch_16(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("B"), 
    		  .in_square(in_squares[15]), 
    		  .in_character(in_chars[15]));

    show_one_char #(.CHAR_X_LOC(X4+X_OFFSET), 
    				.CHAR_Y_LOC(Y2+Y_OFFSET)) 
    	ch_17(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("&"), 
    		  .in_square(in_squares[16]), 
    		  .in_character(in_chars[16]));

    show_one_char #(.CHAR_X_LOC(X5+X_OFFSET), 
    				.CHAR_Y_LOC(Y2+Y_OFFSET))
    	ch_18(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("?"), 
    		  .in_square(in_squares[17]), 
    		  .in_character(in_chars[17]));

    show_one_char #(.CHAR_X_LOC(X0+X_OFFSET), 
    				.CHAR_Y_LOC(Y3+Y_OFFSET)) 
    	ch_19(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("C"), 
    		  .in_square(in_squares[18]), 
    		  .in_character(in_chars[18]));

    show_one_char #(.CHAR_X_LOC(X1+X_OFFSET), 
    				.CHAR_Y_LOC(Y3+Y_OFFSET))
    	ch_20(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("D"), 
    		  .in_square(in_squares[19]), 
    		  .in_character(in_chars[19]));

    show_one_char #(.CHAR_X_LOC(X2+X_OFFSET), 
    				.CHAR_Y_LOC(Y3+Y_OFFSET)) 
    	ch_21(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("E"), 
    		  .in_square(in_squares[20]), 
    		  .in_character(in_chars[20]));

    show_one_char #(.CHAR_X_LOC(X3+X_OFFSET), 
    				.CHAR_Y_LOC(Y3+Y_OFFSET))
    	ch_22(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("F"), 
    		  .in_square(in_squares[21]), 
    		  .in_character(in_chars[21]));

    show_one_char #(.CHAR_X_LOC(X4+X_OFFSET), 
    				.CHAR_Y_LOC(Y3+Y_OFFSET)) 
    	ch_23(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char(">"), 
    		  .in_square(in_squares[22]), 
    		  .in_character(in_chars[22]));

    show_one_char #(.CHAR_X_LOC(X5+X_OFFSET), 
    				.CHAR_Y_LOC(Y3+Y_OFFSET))
    	ch_24(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char("!"), 
    		  .in_square(in_squares[23]), 
    		  .in_character(in_chars[23]));
    		  
endmodule
