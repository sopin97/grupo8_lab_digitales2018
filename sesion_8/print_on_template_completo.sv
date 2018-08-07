module print_on_template(
	input logic [10:0] hc_visible,
	input logic [10:0] vc_visible,
	input logic rst, clk_vga,
	
	//Entradas valores calculadora
	input logic [79:0] calculator_value_entry,
	input logic [7:0] operacion,
	input logic [39:0] operando1_entry,
	input logic [39:0] operando2_entry,
	input logic [127:0] binary_input,
	
	//Salidas para poder pintar pantalla
	output logic in_square,
	output logic in_char,
	output logic in_input_screen,
	output logic in_input_screen_char,
	output logic in_operand_box,
	output logic in_operand_box_char,
	output logic in_binary_box,
	output logic in_binary_box_char
    );
    
    parameter INPUT_SCREEN_X = 700; //Cordenada pantalla de ingreso
    parameter INPUT_SCREEN_Y = 500;
    parameter OP1_X = 500; //Cordenadas Operandos
    parameter OP2_X = 600;
    parameter OP1_Y = 500;
    parameter OP2_Y = 600;
    parameter OP_X = 243;
    parameter OP_Y = 756;
    parameter BINARY_X = 324; // Cordenadas digito en binario
    parameter BINARY_Y = 323;
    parameter X0 = 0; // Cordenadas posicion grilla
    parameter X1 = 100;
    parameter X2 = 200;
    parameter X3 = 300;
    parameter X4 = 400;
    parameter X5 = 500;
    parameter Y0 = 0;
    parameter Y1 = 100;
    parameter Y2 = 200;
    parameter Y3 = 300;
    localparam X_OFFSET = 25;
    localparam Y_OFFSET = 25; // OFFSET de grillas
    
    logic [25:0] in_squares;
    logic [25:0] in_chars;
    logic [2:0] in_operand_boxes;
    logic [2:0] in_operand_boxes_char; // cada modulo tiene su estado de salida
    logic [3:0] in_binary_boxes;
    logic [3:0] in_binary_boxes_char;
    
    assign in_operand_box = |in_operand_boxes;
    assign in_operand_box_char = |in_operand_boxes_char;
    assign in_square = |in_squares;	// Se juntan todos los estados de salida de cada modulo
    assign in_char = |in_chars;
    assign in_binary_box = |in_binary_boxes;
    assign in_binary_box_char = |in_binary_boxes_char;
    
    // Dibuja la linea del input screen
    show_one_line #(.LINE_X_LOCATION(INPUT_SCREEN_X), 
    				.LINE_Y_LOCATION(INPUT_SCREEN_Y), 
    				.MAX_CHARACTER_LINE(10), 
    				.ancho_pixel(8), 
    				.n(4)) 
    			line_input_screen(
    			.clk(clk_vga), 
    			.rst(rst), 
    			.hc_visible(hc_visible), 
    			.vc_visible(vc_visible), 
    			.the_line(calculator_value_entry), 
    			.in_square(in_input_screen), 
    			.in_character(in_input_screen_char));
    
    // Dibuja los operandos	
    show_one_char #(.CHAR_X_LOC(OP_X), 
    				.CHAR_Y_LOC(OP_Y)) 
    	OP(.clk(clk_vga), 
    		  .rst(rst), 
    		  .hc_visible(hc_visible), 
    		  .vc_visible(vc_visible), 
    		  .the_char(operacion), 
    		  .in_square(in_operand_boxes[2]), 
    		  .in_character(in_operand_boxes_char[2]));
    
     show_one_line #(.LINE_X_LOCATION(OP1_X), 
    			   	 .LINE_Y_LOCATION(OP1_Y), 
    			   	 .MAX_CHARACTER_LINE(5), 
    			   	 .ancho_pixel(5), 
    			   	 .n(3)) 
    			line_OP1(.clk(clk_vga), 
    			.rst(rst), 
    			.hc_visible(hc_visible), 
    			.vc_visible(vc_visible), 
    			.the_line(operando1_entry), 
    			.in_square(in_operand_boxes[0]), 
    			.in_character(in_operand_boxes_char[0]));

     show_one_line #(.LINE_X_LOCATION(OP2_X), 
    			   	 .LINE_Y_LOCATION(OP2_Y), 
    			   	 .MAX_CHARACTER_LINE(5), 
    			   	 .ancho_pixel(5), 
    			   	 .n(3)) 
    			line_OP2(.clk(clk_vga), 
    			.rst(rst), 
    			.hc_visible(hc_visible), 
    			.vc_visible(vc_visible), 
    			.the_line(operando2_entry), 
    			.in_square(in_operand_boxes[1]), 
    			.in_character(in_operand_boxes_char[1]));
	
	// Dibuja la pantalla para numeros binarios
     show_one_line #(.LINE_X_LOCATION(BINARY_X), 
    			   	 .LINE_Y_LOCATION(BINARY_Y), 
    			   	 .MAX_CHARACTER_LINE(4), 
    			   	 .ancho_pixel(3), 
    			   	 .n(2)) 
    			line_binary_0(.clk(clk_vga), 
    			.rst(rst), 
    			.hc_visible(hc_visible), 
    			.vc_visible(vc_visible), 
    			.the_line(binary_input[127:96]), 
    			.in_square(in_binary_boxes[0]), 
    			.in_character(in_binary_boxes_char[0]));
    			
     show_one_line #(.LINE_X_LOCATION(BINARY_X+100), 
    			   	 .LINE_Y_LOCATION(BINARY_Y), 
    			   	 .MAX_CHARACTER_LINE(4), 
    			   	 .ancho_pixel(3), 
    			   	 .n(2)) 
    			line_binary_1(.clk(clk_vga), 
    			.rst(rst), 
    			.hc_visible(hc_visible), 
    			.vc_visible(vc_visible), 
    			.the_line(binary_input[95:64]), 
    			.in_square(in_binary_boxes[1]), 
    			.in_character(in_binary_boxes_char[1]));
    			
     show_one_line #(.LINE_X_LOCATION(BINARY_X+200), 
    			   	 .LINE_Y_LOCATION(BINARY_Y), 
    			   	 .MAX_CHARACTER_LINE(4), 
    			   	 .ancho_pixel(3), 
    			   	 .n(2)) 
    			line_binary_2(.clk(clk_vga), 
    			.rst(rst), 
    			.hc_visible(hc_visible), 
    			.vc_visible(vc_visible), 
    			.the_line(binary_input[63:32]), 
    			.in_square(in_binary_boxes[2]), 
    			.in_character(in_binary_boxes_char[2]));
    			
     show_one_line #(.LINE_X_LOCATION(BINARY_X+300), 
    			   	 .LINE_Y_LOCATION(BINARY_Y), 
    			   	 .MAX_CHARACTER_LINE(4), 
    			   	 .ancho_pixel(3), 
    			   	 .n(2)) 
    			line_binary_3(.clk(clk_vga), 
    			.rst(rst), 
    			.hc_visible(hc_visible), 
    			.vc_visible(vc_visible), 
    			.the_line(binary_input[31:0]), 
    			.in_square(in_binary_boxes[3]), 
    			.in_character(in_binary_boxes_char[3]));
    			
    // dibuja todos los caracteres de la grilla
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
