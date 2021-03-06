module lab_8_1(
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
	//logic [2:0] op;
	logic [2:0] pos_x;
	logic [1:0] pos_y;
	//logic [15:0] op1, op2;
	
	//Debounce Botones
	logic UP,DOWN,LEFT,RIGHT; //Botones varios
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
        .pos_y(pos_y));
                        
	calculator_screen SCREEN1(
		.clk_vga(CLK82MHZ),
		.rst(hw_rst),
		//.mode(SW[0]),
		//.op(op),
		.pos_x(pos_x),
		.pos_y(pos_y),
		//.op1(op1),
		//.op2(op2),
		//.input_screen(16'd0),
		
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

//module hex_to_ascii(
//	input [3:0] hex_num,
//	output logic[7:0] ascii_conv
//	);
//
//	//fill here
//endmodule


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
//module hex_to_bit_ascii(
//	input [3:0]num,
//	output [4*8-1:0]bit_ascii
//	);

	//fill Here
	
//endmodule

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
	//input mode, //bcd or dec.
	//input [2:0]op,
	input [2:0]pos_x,
	input [1:0]pos_y,
	//input [15:0] op1,
	//input [15:0] op2,
	//input [15:0] input_screen,
	
	output VGA_HS,
	output VGA_VS,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B
	);
	
	
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
	
	logic in_square, in_char;
	
	// El template se encarga de imprimir una grilla de 6x4
	template_6x4_600x400 #( .GRID_XI(CUADRILLA_XI), 
							.GRID_XF(CUADRILLA_XF), 
							.GRID_YI(CUADRILLA_YI), 
							.GRID_YF(CUADRILLA_YF)) 
     //MODIFICAR ESTO PARA HACER LLAMADO POR NOMBRE DE PUERTO, NO POR ORDEN!!!!!
	template_1(clk_vga, hc_visible, vc_visible, matrix_x, matrix_y, lines);
	
	print_on_template #(
	.X0(CUADRILLA_X0),
	.X1(CUADRILLA_X1),
	.X2(CUADRILLA_X2),		// ESTE MODULO SE ENCARGA DE IMPRIMIR
	.X3(CUADRILLA_X3),		// LA CALCULADORA ENCIMA DEL
	.X4(CUADRILLA_X4),		// TEMPLATE
	.X5(CUADRILLA_X5),
	.Y0(CUADRILLA_Y0),
	.Y1(CUADRILLA_Y1),
	.Y2(CUADRILLA_Y2),
	.Y3(CUADRILLA_Y3)
	)
	PRINT (	.clk_vga(clk_vga),
		  	.rst(rst),
		  	.hc_visible(hc_visible),
		  	.vc_visible(vc_visible),
		  	.in_square(in_square),
		  	.in_char(in_char));
		  	
	logic [11:0]VGA_COLOR;
	
	logic text_sqrt_fg;
	logic text_sqrt_bg;

	//logic [1:0]generic_fg;
	//logic [1:0]generic_bg;	DESCOMENTAR CUANDO SE USE show_one_char!!!!!!!!!!!!!!!!!!!!!!

	//localparam GRID_X_OFFSET	= 20;
	//localparam GRID_Y_OFFSET	= 10;
	
	//localparam FIRST_SQRT_X = 400;
	//localparam FIRST_SQRT_Y = 200;
	
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
	
	always@(*)
		if((hc_visible != 0) && (vc_visible != 0))
		begin
			
			if(text_sqrt_fg)
				VGA_COLOR = COLOR_RED;
			else if (text_sqrt_bg)
				VGA_COLOR = COLOR_YELLOW;
				
			else if(in_char)
				VGA_COLOR = COLOR_BLACK;
			else if(in_square)
				VGA_COLOR = COLOR_WHITE;
			
			//si esta dentro de la grilla.
			else if((hc_visible > CUADRILLA_XI) && (hc_visible <= CUADRILLA_XF) && (vc_visible > CUADRILLA_YI) && (vc_visible <= CUADRILLA_YF))
				if(lines)//lineas negras de la grilla
					VGA_COLOR = COLOR_BLACK;
					
				else if (draw_cursor) //el cursor
					VGA_COLOR = COLOR_CYAN;
					
				else
					VGA_COLOR = {3'h7, {2'b0, matrix_x} + {3'b00, matrix_y}, 4'h3};// el fondo de la grilla.
			
			else
				VGA_COLOR = COLOR_BLUE;//el fondo de la pantalla
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
