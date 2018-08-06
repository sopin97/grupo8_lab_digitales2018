`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Mauricio Solis
// 
// Create Date:    17:09:55 05/23/2015 
// Design Name: 
// Module Name:    caracters 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module characters(
	input [7:0] select ,
	input [2:0] coor_x,
	input [2:0] coor_y,
	output pixel
	);
	
	logic [39:0] vec_char;
	
	//Numeros y simbolos
	logic [39:0] vect_num_0;
	logic [39:0] vect_num_1;
	logic [39:0] vect_num_2;
	logic [39:0] vect_num_3;
	logic [39:0] vect_num_4;
	logic [39:0] vect_num_5;
	logic [39:0] vect_num_6;
	logic [39:0] vect_num_7;
	logic [39:0] vect_num_8;
	logic [39:0] vect_num_9;
	logic [39:0] vect_num_SUMA;
	logic [39:0] vect_num_RESTA;
	logic [39:0] vect_num_MULTIP;
	logic [39:0] vect_num_AND;
	logic [39:0] vect_num_OR;
	logic [39:0] vect_num_EQUAL;
	logic [39:0] vect_num_DOT;
	logic [39:0] vect_num_COMMA;
	logic [39:0] vect_num_EXCLAMATION;
	logic [39:0] vect_num_QUESTION;
	logic [39:0] vect_num_SPACE;
	logic [39:0] vect_num_RIGHT_ARROW;
	logic [39:0] vect_num_LEFT_ARROW;
	
	// Abecedario
	logic [39:0] vect_char_a;
	logic [39:0] vect_char_b;
	logic [39:0] vect_char_c;
	logic [39:0] vect_char_d;
	logic [39:0] vect_char_e;
	logic [39:0] vect_char_f;
	logic [39:0] vect_char_g;
	logic [39:0] vect_char_h;
	logic [39:0] vect_char_i;
	logic [39:0] vect_char_j;
	logic [39:0] vect_char_k;
	logic [39:0] vect_char_l;
	logic [39:0] vect_char_m;
	logic [39:0] vect_char_n;
	logic [39:0] vect_char_o;
	logic [39:0] vect_char_p;
	logic [39:0] vect_char_q;
	logic [39:0] vect_char_r;
	logic [39:0] vect_char_s;
	logic [39:0] vect_char_t;
	logic [39:0] vect_char_u;
	logic [39:0] vect_char_v;
	logic [39:0] vect_char_w;
	logic [39:0] vect_char_x;
	logic [39:0] vect_char_y;
	logic [39:0] vect_char_z;
	logic [39:0] vect_char_A;
	logic [39:0] vect_char_B;
	logic [39:0] vect_char_C;
	logic [39:0] vect_char_D;
	logic [39:0] vect_char_E;
	logic [39:0] vect_char_F;
	logic [39:0] vect_char_G;
	logic [39:0] vect_char_H;
	logic [39:0] vect_char_I;
	logic [39:0] vect_char_J;
	logic [39:0] vect_char_K;
	logic [39:0] vect_char_L;
	logic [39:0] vect_char_M;
	logic [39:0] vect_char_N;
	logic [39:0] vect_char_O;
	logic [39:0] vect_char_P;
	logic [39:0] vect_char_Q;
	logic [39:0] vect_char_R;
	logic [39:0] vect_char_S;
	logic [39:0] vect_char_T;
	logic [39:0] vect_char_U;
	logic [39:0] vect_char_V;
	logic [39:0] vect_char_W;
	logic [39:0] vect_char_X;
	logic [39:0] vect_char_Y;
	logic [39:0] vect_char_Z;
	logic [39:0] vect_char_enie;
	logic [39:0] vect_char_ENIE;
	
	// Numeros y simbolos
	assign vect_num_0={5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
	assign vect_num_1={5'b00000,5'b01110,5'b00100,5'b00100,5'b00100,5'b00100,5'b00110,5'b00100};
	assign vect_num_2={5'b00000,5'b11111,5'b00010,5'b00100,5'b01000,5'b10000,5'b10001,5'b01110};
	assign vect_num_3={5'b00000,5'b01110,5'b10001,5'b10000,5'b01000,5'b00100,5'b01000,5'b11111};
	assign vect_num_4={5'b00000,5'b01000,5'b01000,5'b11111,5'b01001,5'b01010,5'b01100,5'b01000};
	assign vect_num_5={5'b00000,5'b01110,5'b10001,5'b10000,5'b10000,5'b01111,5'b00001,5'b11111};
	assign vect_num_6={5'b00000,5'b01110,5'b10001,5'b10001,5'b01111,5'b00001,5'b00010,5'b01100};
	assign vect_num_7={5'b00000,5'b00010,5'b00010,5'b00010,5'b00100,5'b01000,5'b10000,5'b11111};
	assign vect_num_8={5'b00000,5'b01110,5'b10001,5'b10001,5'b01110,5'b10001,5'b10001,5'b01110};
	assign vect_num_9={5'b00000,5'b00110,5'b01000,5'b10000,5'b11110,5'b10001,5'b10001,5'b01110};
	assign vect_num_SUMA={5'b00000,5'b00000,5'b00100,5'b00100,5'b11111,5'b00100,5'b00100,5'b00000};
	assign vect_num_RESTA={5'b00000,5'b00000,5'b00000,5'b00000,5'b11111,5'b00000,5'b00000,5'b00000};
	assign vect_num_MULTIP={5'b00000,5'b00000,5'b00100,5'b10101,5'b01110,5'b10101,5'b00100,5'b00000};
	assign vect_num_AND={5'b00000,5'b10110,5'b01001,5'b10101,5'b00010,5'b00101,5'b01001,5'b00110};
	assign vect_num_OR={5'b00000,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100};
	assign vect_num_EQUAL={5'b00000,5'b00000,5'b00000,5'b11111,5'b00000,5'b11111,5'b00000,5'b00000};
	assign vect_num_DOT={5'b00000,5'b00110,5'b00110,5'b00000,5'b00000,5'b00000,5'b00000,5'b00000};
	assign vect_num_COMMA={5'b00000,5'b00010,5'b00100,5'b00110,5'b00000,5'b00000,5'b00000,5'b00000};
	assign vect_num_EXCLAMATION={5'b00000,5'b00100,5'b00000,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100};
	assign vect_num_QUESTION={5'b00000,5'b00100,5'b00000,5'b00100,5'b01000,5'b10000,5'b10001,5'b01110};
	assign vect_num_SPACE={5'b00000,5'b00000,5'b00000,5'b00000,5'b00000,5'b00000,5'b00000,5'b00000};
	assign vect_num_RIGHT_ARROW={5'b00000,5'b00000,5'b00100,5'b01000,5'b11111,5'b01000,5'b00100,5'b00000};
	assign vect_num_LEFT_ARROW={5'b00000,5'b00000,5'b00100,5'b00010,5'b11111,5'b00010,5'b00100,5'b00000};
	
	// Abecedario
	assign vect_char_a={5'b00000,5'b11110,5'b10001,5'b11110,5'b10000,5'b01110,5'b00000,5'b00000};
	assign vect_char_b={5'b00000,5'b01111,5'b10001,5'b10001,5'b10011,5'b01101,5'b00001,5'b00001};
	assign vect_char_c={5'b00000,5'b01110,5'b10001,5'b00001,5'b00001,5'b01110,5'b00000,5'b00000};
	assign vect_char_d={5'b00000,5'b11110,5'b10001,5'b10001,5'b11001,5'b10110,5'b10000,5'b10000};
	assign vect_char_e={5'b00000,5'b01110,5'b00001,5'b11111,5'b10001,5'b01110,5'b00000,5'b00000};
	assign vect_char_f={5'b00000,5'b00010,5'b00010,5'b00010,5'b00111,5'b00010,5'b10010,5'b01100};
	assign vect_char_g={5'b00000,5'b01110,5'b10000,5'b11110,5'b10001,5'b10001,5'b11110,5'b00000};
	assign vect_char_h={5'b00000,5'b10001,5'b10001,5'b10001,5'b10011,5'b01101,5'b00001,5'b00001};
	assign vect_char_i={5'b00000,5'b01110,5'b00100,5'b00100,5'b00100,5'b00110,5'b00000,5'b00100};
	assign vect_char_j={5'b00000,5'b00110,5'b01001,5'b01000,5'b01000,5'b01100,5'b00000,5'b01000};
	assign vect_char_k={5'b00000,5'b01001,5'b00101,5'b00011,5'b00101,5'b01001,5'b00001,5'b00001};
	assign vect_char_l={5'b00000,5'b01110,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100,5'b00110};
	assign vect_char_m={5'b00000,5'b10001,5'b10001,5'b10101,5'b10101,5'b01011,5'b00000,5'b00000};
	assign vect_char_n={5'b00000,5'b10001,5'b10001,5'b10001,5'b10011,5'b01101,5'b00000,5'b00000};
	assign vect_char_o={5'b00000,5'b01110,5'b10001,5'b10001,5'b10001,5'b01110,5'b00000,5'b00000};
	assign vect_char_p={5'b00000,5'b00001,5'b00001,5'b01111,5'b10001,5'b01111,5'b00000,5'b00000};
	assign vect_char_q={5'b00000,5'b10000,5'b10000,5'b11110,5'b11001,5'b10110,5'b00000,5'b00000};
	assign vect_char_r={5'b00000,5'b00001,5'b00001,5'b00001,5'b10011,5'b01101,5'b00000,5'b00000};
	assign vect_char_s={5'b00000,5'b01111,5'b10000,5'b01110,5'b00001,5'b01110,5'b00000,5'b00000};
	assign vect_char_t={5'b00000,5'b01100,5'b10010,5'b00010,5'b00010,5'b00111,5'b00010,5'b00010};
	assign vect_char_u={5'b00000,5'b10110,5'b11001,5'b10001,5'b10001,5'b10001,5'b00000,5'b00000};
	assign vect_char_v={5'b00000,5'b00100,5'b01010,5'b10001,5'b10001,5'b10001,5'b00000,5'b00000};
	assign vect_char_w={5'b00000,5'b01010,5'b10101,5'b10101,5'b10001,5'b10001,5'b00000,5'b00000};
	assign vect_char_x={5'b00000,5'b10001,5'b01010,5'b00100,5'b01010,5'b10001,5'b00000,5'b00000};
	assign vect_char_y={5'b00000,5'b01110,5'b10000,5'b11110,5'b10001,5'b10001,5'b00000,5'b00000};
	assign vect_char_z={5'b00000,5'b11111,5'b00010,5'b00100,5'b01000,5'b11111,5'b00000,5'b00000};
	assign vect_char_A={5'b00000,5'b10001,5'b10001,5'b11111,5'b10001,5'b10001,5'b10001,5'b01110};
	assign vect_char_B={5'b00000,5'b01111,5'b10001,5'b10001,5'b01111,5'b10001,5'b10001,5'b01111};
	assign vect_char_C={5'b00000,5'b01110,5'b10001,5'b00001,5'b00001,5'b00001,5'b10001,5'b01110};
	assign vect_char_D={5'b00000,5'b00111,5'b01001,5'b10001,5'b10001,5'b10001,5'b01001,5'b00111};
	assign vect_char_E={5'b00000,5'b11111,5'b00001,5'b00001,5'b01111,5'b00001,5'b00001,5'b11111};
	assign vect_char_F={5'b00000,5'b00001,5'b00001,5'b00001,5'b01111,5'b00001,5'b00001,5'b11111};
	assign vect_char_G={5'b00000,5'b11110,5'b10001,5'b10001,5'b11101,5'b00001,5'b10001,5'b01110};
	assign vect_char_H={5'b00000,5'b10001,5'b10001,5'b10001,5'b11111,5'b10001,5'b10001,5'b10001};
	assign vect_char_I={5'b00000,5'b01110,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100,5'b01110};
	assign vect_char_J={5'b00000,5'b00110,5'b01001,5'b01000,5'b01000,5'b01000,5'b01000,5'b11100};
	assign vect_char_K={5'b00000,5'b10001,5'b01001,5'b00101,5'b00011,5'b00101,5'b01001,5'b10001};
	assign vect_char_L={5'b00000,5'b11111,5'b00001,5'b00001,5'b00001,5'b00001,5'b00001,5'b00001};
	assign vect_char_M={5'b00000,5'b10001,5'b10001,5'b10001,5'b10101,5'b10101,5'b11011,5'b10001};
	assign vect_char_N={5'b00000,5'b10001,5'b10001,5'b11001,5'b10101,5'b10011,5'b10001,5'b10001};
	assign vect_char_O={5'b00000,5'b01110,5'b10001,5'b10001,5'b10001,5'b10001,5'b10001,5'b01110};
	assign vect_char_P={5'b00000,5'b00001,5'b00001,5'b00001,5'b01111,5'b10001,5'b10001,5'b01111};
	assign vect_char_Q={5'b00000,5'b10110,5'b01001,5'b10101,5'b10001,5'b10001,5'b10001,5'b01110};
	assign vect_char_R={5'b00000,5'b10001,5'b01001,5'b00101,5'b01111,5'b10001,5'b10001,5'b01111};
	assign vect_char_S={5'b00000,5'b01111,5'b10000,5'b10000,5'b01110,5'b00001,5'b00001,5'b11110};
	assign vect_char_T={5'b00000,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100,5'b11111};
	assign vect_char_U={5'b00000,5'b01110,5'b10001,5'b10001,5'b10001,5'b10001,5'b10001,5'b10001};
	assign vect_char_V={5'b00000,5'b00100,5'b01010,5'b10001,5'b10001,5'b10001,5'b10001,5'b10001};
	assign vect_char_W={5'b00000,5'b01010,5'b10101,5'b10101,5'b10101,5'b10001,5'b10001,5'b10001};
	assign vect_char_X={5'b00000,5'b10001,5'b10001,5'b01010,5'b00100,5'b01010,5'b10001,5'b10001};
	assign vect_char_Y={5'b00000,5'b00100,5'b00100,5'b00100,5'b01010,5'b10001,5'b10001,5'b10001};
	assign vect_char_Z={5'b00000,5'b11111,5'b00001,5'b00010,5'b00100,5'b01000,5'b10000,5'b11111};
	assign vect_char_enie={5'b00000,5'b10001,5'b10001,5'b10001,5'b10011,5'b01101,5'b00000,5'b01110};
	assign vect_char_ENIE={5'b00000,5'b10001,5'b11001,5'b10101,5'b10011,5'b10001,5'b00000,5'b01110};



	always_comb
		case(select)
			"0":  vec_char=vect_num_0;
			"1":  vec_char=vect_num_1;
			"2":  vec_char=vect_num_2;
			"3":  vec_char=vect_num_3;
			"4":  vec_char=vect_num_4;
			"5":  vec_char=vect_num_5;
			"6":  vec_char=vect_num_6;
			"7":  vec_char=vect_num_7;
			"8":  vec_char=vect_num_8;
			"9":  vec_char=vect_num_9;
			"+":  vec_char=vect_num_SUMA;       
			"-":  vec_char=vect_num_RESTA;      
			"*":  vec_char=vect_num_MULTIP;     
			"&":  vec_char=vect_num_AND;        
			"|":  vec_char=vect_num_OR;         
			"=":  vec_char=vect_num_EQUAL;      
			".":  vec_char=vect_num_DOT;        
			",":  vec_char=vect_num_COMMA;      
			"!":  vec_char=vect_num_EXCLAMATION;
			"?":  vec_char=vect_num_QUESTION;   
			" ":  vec_char=vect_num_SPACE;
			"<":  vec_char=vect_num_LEFT_ARROW;
			">":  vec_char=vect_num_RIGHT_ARROW;      
			
			"a": vec_char=vect_char_a;
			"b": vec_char=vect_char_b;
			"c": vec_char=vect_char_c;
			"d": vec_char=vect_char_d;
			"e": vec_char=vect_char_e;
			"f": vec_char=vect_char_f;
			"g": vec_char=vect_char_g;
			"h": vec_char=vect_char_h;
			"i": vec_char=vect_char_i;
			"j": vec_char=vect_char_j;
			"k": vec_char=vect_char_k;
			"l": vec_char=vect_char_l;
			"m": vec_char=vect_char_m;
			"n": vec_char=vect_char_n;
			"o": vec_char=vect_char_o;
			"p": vec_char=vect_char_p;
			"q": vec_char=vect_char_q;
			"r": vec_char=vect_char_r;
			"s": vec_char=vect_char_s;
			"t": vec_char=vect_char_t;
			"u": vec_char=vect_char_u;
			"v": vec_char=vect_char_v;
			"w": vec_char=vect_char_w;
			"x": vec_char=vect_char_x;
			"y": vec_char=vect_char_y;
			"z": vec_char=vect_char_z;
			"A": vec_char=vect_char_A;
			"B": vec_char=vect_char_B;
			"C": vec_char=vect_char_C;
			"D": vec_char=vect_char_D;
			"E": vec_char=vect_char_E;
			"F": vec_char=vect_char_F;
			"G": vec_char=vect_char_G;
			"H": vec_char=vect_char_H;
			"I": vec_char=vect_char_I;
			"J": vec_char=vect_char_J;
			"K": vec_char=vect_char_K;
			"L": vec_char=vect_char_L;
			"M": vec_char=vect_char_M;
			"N": vec_char=vect_char_N;
			"O": vec_char=vect_char_O;
			"P": vec_char=vect_char_P;
			"Q": vec_char=vect_char_Q;
			"R": vec_char=vect_char_R;
			"S": vec_char=vect_char_S;
			"T": vec_char=vect_char_T;
			"U": vec_char=vect_char_U;
			"V": vec_char=vect_char_V;
			"W": vec_char=vect_char_W;
			"X": vec_char=vect_char_X;
			"Y": vec_char=vect_char_Y;
			"Z": vec_char=vect_char_Z;
			"ñ": vec_char=vect_char_enie;
			"Ñ": vec_char=vect_char_ENIE;
			default:vec_char=vect_num_DOT;//punto
	endcase
	
	
	logic [4:0] character_to_show[0:7];
	logic [4:0] row;
	
	assign { character_to_show[7], character_to_show[6], character_to_show[5], character_to_show[4],
				character_to_show[3], character_to_show[2], character_to_show[1], character_to_show[0] } = 
				vec_char;
	assign row = character_to_show[coor_y];
	assign pixel = row[coor_x];
	
endmodule
