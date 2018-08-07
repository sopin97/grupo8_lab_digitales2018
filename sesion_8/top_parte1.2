module lab_8(
	input CLK100MHZ,
	input SW,
	input BTNC,	BTNU, BTNL, BTNR, BTND, CPU_RESETN,
	//output [15:0] LED,
	//output CA, CB, CC, CD, CE, CF, CG,
	//output DP,
	//output [7:0] AN,

	output VGA_HS,
	output VGA_VS,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B
	);
	
	
	logic CLK82MHZ;
	logic rst = 0;
	logic hw_rst = ~CPU_RESETN;
	
	// clock_wizzard aqui
	clk_wiz_82MHZ inst1
	  (
	  // Clock out ports  
	  .clk_out1(CLK82MHZ),
	  // Status and control signals               
	  .reset(1'b0), 
	  //.locked(locked),
	 // Clock in ports
	  .clk_in1(CLK100MHZ)
	  );
	//Fill here

	/************************* VGA ********************/
	logic [2:0] op;
	logic [2:0] pos_x;
	logic [1:0] pos_y;
	logic [4:0] grid_value;
	logic [15:0] output_number;
	logic [15:0] op1, op2;

	//Debounce Botones
	logic UP,DOWN,LEFT,RIGHT, CENTER; //Botones varios
	PushButton_Debouncer2 CBUP(
	    .clk(CLK100MHZ),
	    .rst(hw_rst),
	    .PB(BTNC),
	    .PB_posedge(CENTER));
    PushButton_Debouncer2 DBUP(
        .clk(CLK100MHZ),
        .rst(hw_rst),
        .PB(BTNU),
        .PB_posedge(UP));
    PushButton_Debouncer2 DBUD(
        .clk(CLK100MHZ),
        .rst(hw_rst),
        .PB(BTND),
        .PB_posedge(DOWN));
    PushButton_Debouncer2 DBUL(
        .clk(CLK100MHZ),
        .rst(hw_rst),
        .PB(BTNL),
        .PB_posedge(LEFT));
    PushButton_Debouncer2 DBUR(
        .clk(CLK100MHZ),
        .rst(hw_rst),
        .PB(BTNR),
        .PB_posedge(RIGHT));

//Modulo cursor
    grid_cursor GC(
        .clk(CLK100MHZ),
        .rst(~CPU_RESETN),
        .restriction(SW),
        .dir_up(UP),
        .dir_down(DOWN),
        .dir_left(LEFT),
        .dir_right(RIGHT),  //puse un valor cte, remplazar a RIGHT
        .pos_x(pos_x),
        .pos_y(pos_y),
        .val(grid_value));
 
 // procesa en 16 bit el numero a mostrar en la calculadora
    procces_input_screen PROC (
    	.val(grid_value),
    	.enter_button(CENTER),
    	.clk(CLK100MHZ),
    	.rst(~CPU_RESETN),
    	.output_number(output_number),
    	.op1(op1),
    	.op2(op2),
    	.op(op)
    );

	calculator_screen SCREEN1(
		.clk_vga(CLK82MHZ),
		.rst(hw_rst),
		.mode(SW),
		.op(op),
		.pos_x(pos_x),
		.pos_y(pos_y),
		.op1(op1),
		.op2(op2),
		.input_screen(output_number),
		
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B));

endmodule


/**
 * @brief Este modulo convierte un numero hexadecimal de 4 bits
 * en su equivalente ascii de 8 bits
 *
 * @param hex_num		Corresponde al numero que se ingresa
 * @param ascii_conv	Corresponde a la representacion ascii
 *
 */

module hex_to_ascii(
	input [3:0] hex_num,
	output logic[7:0] ascii_conv
	);
	always_comb begin
		case (hex_num)
			4'h0: ascii_conv = "0";
			4'h1: ascii_conv = "1";
			4'h2: ascii_conv = "2";
			4'h3: ascii_conv = "3";
			4'h4: ascii_conv = "4";
			4'h5: ascii_conv = "5";
			4'h6: ascii_conv = "6";
			4'h7: ascii_conv = "7";
			4'h8: ascii_conv = "8";
			4'h9: ascii_conv = "9";
			4'hA: ascii_conv = "A";
			4'hB: ascii_conv = "B";
			4'hC: ascii_conv = "C";
			4'hD: ascii_conv = "D";
			4'hE: ascii_conv = "E";
			4'hF: ascii_conv = "F";
			default: ascii_conv = " ";
		endcase
	end
	//fill here
endmodule


/**
 * @brief Este modulo convierte un numero hexadecimal de 4 bits
 * en su equivalente ascii, pero binario, es decir,
 * si el numero ingresado es 4'hA, la salida debera sera la concatenacion
 * del string "1010" (cada caracter del string genera 8 bits).
 *
 * @param num		Corresponde al numero que se ingresa
 * @param bit_ascii	Corresponde a la representacion ascii pero del binario.
 *
 */
module hex_to_bit_ascii(
	input [3:0]num,
	output logic [4*8-1:0]bit_ascii
	);
	
	always_comb begin
		case (num)
			4'h0: bit_ascii = "0000";
			4'h1: bit_ascii = "0001";
			4'h2: bit_ascii = "0010";
			4'h3: bit_ascii = "0011";
			4'h4: bit_ascii = "0100";
			4'h5: bit_ascii = "0101";
			4'h6: bit_ascii = "0110";
			4'h7: bit_ascii = "0111";
			4'h8: bit_ascii = "1000";
			4'h9: bit_ascii = "1001";
			4'hA: bit_ascii = "1010";
			4'hB: bit_ascii = "1011";
			4'hC: bit_ascii = "1100";
			4'hD: bit_ascii = "1101";
			4'hE: bit_ascii = "1110";
			4'hF: bit_ascii = "1111";
			default: bit_ascii = " ";
		endcase
		end
	//fill Here
	
endmodule

/**
 * @brief Este modulo es el encargado de dibujar en pantalla
 * la calculadora y todos sus componentes graficos
 *
 * @param clk_vga		:Corresponde al reloj con que funciona el VGA.
 * @param rst			:Corresponde al reset de todos los registros
 * @param mode			:'0' si se esta operando en decimal, '1' si esta operando hexadecimal
 * @param op			:La operacion matematica a realizar
 * @param pos_x			:Corresponde a la posicion X del cursor dentro de la grilla.
 * @param pos_y			:Corresponde a la posicion Y del cursor dentro de la grilla.
 * @param op1			:El operando 1 en formato hexadecimal.
 * @param op2			;El operando 2 en formato hexadecimal.
 * @param input_screen	:Lo que se debe mostrar en la pantalla de ingreso de la calculadora (en hexa)
 * @param VGA_HS		:Sincronismo Horizontal para el monitor VGA
 * @param VGA_VS		:Sincronismo Vertical para el monitor VGA
 * @param VGA_R			:Color Rojo para la pantalla VGA
 * @param VGA_G			:Color Verde para la pantalla VGA
 * @param VGA_B			:Color Azul para la pantalla VGA
 */
module calculator_screen(
	input clk_vga,
	input rst,
	input mode, //bcd or dec.
	input [2:0]op,
	input [2:0]pos_x,
	input [1:0]pos_y,
	input [15:0] op1,
	input [15:0] op2,
	input [15:0] input_screen,
	
	output VGA_HS,
	output VGA_VS,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B
	);
	// Seccion donde se procesa el numero a mostrar en calculadora
	logic [31:0] screen_ascii_number, OP1_number, OP2_number;
	logic [127:0] screen_binary_number;
	logic [7:0] char_command;
	process_numbers NUM0(
		.bit16_number(input_screen),
		.ascii_16_bit_number(screen_ascii_number),
		.ascii_16_bit_binary_number(screen_binary_number)
	);
	process_numbers OP1(.bit16_number(op1),
	.ascii_16_bit_number(OP1_number)
	);
	process_numbers OP2(.bit16_number(op2),
	.ascii_16_bit_number(OP2_number)
	);
	process_numbers OPP(.command(op),
	.char_command(char_command)
	);
	// PARAMETROS IMPORTANTES PARA DEFINIR LAS DIMENSIONES DE LA CALCULADORA Y SUS GRILLAS~~
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	localparam CUADRILLA_XI = 		340;
	localparam CUADRILLA_XF = 		CUADRILLA_XI + 600;
	localparam CUADRILLA_X0 = 		CUADRILLA_XI;
	localparam CUADRILLA_X1 = 		CUADRILLA_XI + 100;
	localparam CUADRILLA_X2 = 		CUADRILLA_XI + 200;
	localparam CUADRILLA_X3 = 		CUADRILLA_XI + 300;
	localparam CUADRILLA_X4 = 		CUADRILLA_XI + 400;
	localparam CUADRILLA_X5 = 		CUADRILLA_XI + 500;
	
	localparam CUADRILLA_YI = 		256;
	localparam CUADRILLA_YF = 		CUADRILLA_YI + 400;
	localparam CUADRILLA_Y0 = 		CUADRILLA_YI;
	localparam CUADRILLA_Y1 = 		CUADRILLA_YI + 100;
	localparam CUADRILLA_Y2 = 		CUADRILLA_YI + 200;
	localparam CUADRILLA_Y3 = 		CUADRILLA_YI + 300;
	
	
	
	logic [10:0]vc_visible,hc_visible;
	
	// MODIFICAR ESTO PARA HACER LLAMADO POR NOMBRE DE PUERTO, NO POR ORDEN!!!!!
	driver_vga_1024x768 m_driver(clk_vga, VGA_HS, VGA_VS, hc_visible, vc_visible);
	/*************************** VGA DISPLAY ************************/
		
	logic [2:0]matrix_x;
	logic [1:0]matrix_y;
	logic lines;
	
	// VARIABLES DE CONTROL PARA IMPRIMIR EN PANTALLA, MUY IMPORTANTE!
	logic in_square, in_char, in_input_screen, in_input_screen_char, text_sqrt_fg, text_sqrt_bg;
	logic in_operand_box, in_operand_box_char, in_binary_box, in_binary_box_char, in_background, in_background_char;
	// duda sobre donde esta? doble click en alguna variable y buscar
	
	// El template se encarga de imprimir una grilla de 6x4
	template_6x4_600x400 #( .GRID_XI(CUADRILLA_XI), 
							.GRID_XF(CUADRILLA_XF), 
							.GRID_YI(CUADRILLA_YI), 
							.GRID_YF(CUADRILLA_YF)) 
     //MODIFICAR ESTO PARA HACER LLAMADO POR NOMBRE DE PUERTO, NO POR ORDEN!!!!!
	template_1(clk_vga, hc_visible, vc_visible, matrix_x, matrix_y, lines);
	
	print_on_template #(
	.INPUT_SCREEN_X(CUADRILLA_XI+100),
	.INPUT_SCREEN_Y(CUADRILLA_YI-200),// Pantalla ingreso operacion
	.OP1_X(200), // pantallas operandos
	.OP1_Y(200),
	.OP2_X(200),
	.OP2_Y(300),
	.OP_X(200), // pantalla operacion
	.OP_Y(400),
	.BINARY_X(CUADRILLA_XI+200),
	.BINARY_Y(CUADRILLA_YI-100), // pantalla numero binario
	.X0(CUADRILLA_X0),
	.X1(CUADRILLA_X1),
	.X2(CUADRILLA_X2),		// ESTE MODULO SE ENCARGA DE IMPRIMIR
	.X3(CUADRILLA_X3),		// LA CALCULADORA ENCIMA DEL
	.X4(CUADRILLA_X4),		// TEMPLATE
	.X5(CUADRILLA_X5),		// imprimiendo los valores actuales de la calculadora
	.Y0(CUADRILLA_Y0),
	.Y1(CUADRILLA_Y1),
	.Y2(CUADRILLA_Y2),
	.Y3(CUADRILLA_Y3)
	)
	PRINT  (.clk_vga(clk_vga),
		  	.rst(rst),
		  	//Entradas numeros y operandos a la calculadora
		  	.calculator_value_entry({"000000",screen_ascii_number}),
		  	.operando1_entry({"0", OP1_number}),
		  	.operando2_entry({"0", OP2_number}),
		  	.operacion(char_command),
		  	.binary_input(screen_binary_number),
		  	// variables de control
		  	.hc_visible(hc_visible),
		  	.vc_visible(vc_visible),
		  	.in_square(in_square), // si esta dentro de la grilla
		  	.in_char(in_char), // si es que esta en character de grilla
		  	.in_input_screen(in_input_screen), // si esta dentro de la pantalla de la calculador
		  	.in_input_screen_char(in_input_screen_char),
		  	.in_operand_box(in_operand_box),
		  	.in_operand_box_char(in_operand_box_char),
		  	.in_binary_box(in_binary_box),
		  	.in_binary_box_char(in_binary_box_char)); // si esta dentro de un caracter en la pantalla de la calculadora
	
	// Esta seccion imprime texto en pantalla
	localparam n_textos = 3;
	logic [n_textos-1:0] in_backgrounds;
	logic [n_textos-1:0] in_backgrounds_char;
	assign in_background = |in_backgrounds;
	assign in_background_char = |in_backgrounds_char;
	show_one_line #(.LINE_X_LOCATION(50),
						.LINE_Y_LOCATION(200),
						.MAX_CHARACTER_LINE(4),
						.ancho_pixel(5),
						.n(3))
		exe_00(	.clk(clk_vga),
				.rst(rst),
				.hc_visible(hc_visible), 
				.vc_visible(vc_visible), 
				.the_line("Op1:"), 
				.in_square(in_backgrounds[0]), 
				.in_character(in_backgrounds_char[0]));

	show_one_line #(.LINE_X_LOCATION(50), 
						.LINE_Y_LOCATION(300), 
						.MAX_CHARACTER_LINE(4), 
						.ancho_pixel(5), 
						.n(3)) 
		exe_01(	.clk(clk_vga), 
				.rst(rst), 
				.hc_visible(hc_visible), 
				.vc_visible(vc_visible), 
				.the_line("Op2:"), 
				.in_square(in_backgrounds[1]), 
				.in_character(in_backgrounds_char[1]));
				
	show_one_line #(.LINE_X_LOCATION(50), 
									.LINE_Y_LOCATION(400), 
									.MAX_CHARACTER_LINE(3), 
									.ancho_pixel(5), 
									.n(3)) 
					exe_02(	.clk(clk_vga), 
							.rst(rst), 
							.hc_visible(hc_visible), 
							.vc_visible(vc_visible), 
							.the_line("Op:"), 
							.in_square(in_backgrounds[2]), 
							.in_character(in_backgrounds_char[2]));
		  	
	logic [11:0]VGA_COLOR; // colores VGA

	//localparam GRID_X_OFFSET	= 20;
	//localparam GRID_Y_OFFSET	= 10;
	
	//localparam FIRST_SQRT_X = 400;
	//localparam FIRST_SQRT_Y = 200;
	// Nombre integrantes de grupo
	hello_world_text_square m_hw(	.clk(clk_vga), 
									.rst(rst), 
									.hc_visible(hc_visible), 
									.vc_visible(vc_visible), 
									.in_square(text_sqrt_bg), 
									.in_character(text_sqrt_fg));

	/*
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + GRID_Y_OFFSET)) 
	ch_00(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("0"), 
		  .in_square(generic_bg[0]), 
		  .in_character(generic_fg[0]));
		  */
	/*
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET - 25), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET + 10), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(5), 
					.n(3)) 
	exe(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("abc"), 
			.in_square(generic_bg[1]), 
			.in_character(generic_fg[1]));

	*/
	logic draw_cursor = (pos_x == matrix_x) && (pos_y == matrix_y);
	
	
	localparam COLOR_BLUE 		= 12'h00F;
	localparam COLOR_YELLOW 	= 12'hFF0;
	localparam COLOR_RED		= 12'hF00;
	localparam COLOR_BLACK		= 12'h000;
	localparam COLOR_WHITE		= 12'hFFF;
	localparam COLOR_CYAN		= 12'h0FF;
	localparam COLOR_GREEN		= 12'h0F0;
	localparam COLOR_GREY		= 12'h888;
	localparam COLOR_BROWN		= 12'hCC0;
	localparam COLOR_PINK		= 12'hFC9;
	localparam COLOR_LIGHT_ORANGE		= 12'hFF9;
	
	always@(*)
		if((hc_visible != 0) && (vc_visible != 0))
		begin
			
			if(text_sqrt_fg)
				VGA_COLOR = COLOR_RED;
			else if (text_sqrt_bg)
				VGA_COLOR = COLOR_YELLOW;
			// color input_screen
			else if(in_input_screen_char)
				VGA_COLOR = COLOR_GREEN;
			else if(in_input_screen)
				VGA_COLOR = COLOR_GREY;
			else if(in_operand_box_char)
				VGA_COLOR = COLOR_BLACK;
			else if(in_operand_box)
				VGA_COLOR = COLOR_WHITE;
			else if(in_binary_box_char)
				VGA_COLOR = COLOR_BLUE;
			else if(in_binary_box)
				VGA_COLOR = COLOR_GREEN;
			else if(in_background_char)
				VGA_COLOR = COLOR_RED;
			else if(in_background)
				VGA_COLOR = COLOR_LIGHT_ORANGE;
			//si esta dentro de la grilla.
			else if((hc_visible > CUADRILLA_XI) && (hc_visible <= CUADRILLA_XF) && (vc_visible > CUADRILLA_YI) && (vc_visible <= CUADRILLA_YF))
				if(lines)//lineas negras de la grilla
					VGA_COLOR = COLOR_BLACK;
			//color caracteres en grilla	
				else if(in_char)
					VGA_COLOR = COLOR_BLACK;
				else if (draw_cursor) //el cursor
					VGA_COLOR = COLOR_CYAN;
				else if(in_square)
					VGA_COLOR = COLOR_BROWN;
					
				else
					VGA_COLOR = COLOR_BROWN;// el fondo de la grilla.
			
			else
				VGA_COLOR = COLOR_LIGHT_ORANGE;//el fondo de la pantalla
		end
		else
			VGA_COLOR = COLOR_BLACK;//esto es necesario para no poner en riesgo la pantalla.

	assign {VGA_R, VGA_G, VGA_B} = VGA_COLOR;
endmodule



/**
 * @brief Este modulo cambia los ceros a la izquierda de un numero, por espacios
 * @param value			:Corresponde al valor (en hexa o decimal) al que se le desea hacer el padding.
 * @param no_pading		:Corresponde al equivalente ascii del value includos los ceros a la izquierda
 * @param padding		:Corresponde al equivalente ascii del value, pero sin los ceros a la izquierda.
 */

module space_padding(
	input [19:0] value,
	input [8*6 -1:0]no_pading,
	
	output logic [8*6 -1:0]padding);
	
	
endmodule
