`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Laboratorio de Sistemas Digitales, 1er semestre, 2018
// Laboratorio 3
// Integrantes:
// - Tomas Munoz ROL: 201621029-6
// - Mauricio Aravena
// - Oscar Cordova
// Grupo 1000
// Proyecto: Display de 4 numeros Hexadecimal
// Modulo 3: conversor BCD a 7 segmentos (anodo comun)
// Breve descripcion: El objetivo del modulo es convertir la entrada
// del bus en su representacion en el display
//////////////////////////////////////////////////////////////////////////////////


module BCD_to_sevenseg(
	input logic [3:0] bus_in,
	output logic [0:6] sevenSeg // -> pines a,b,c,d,e,f,g del 7 segmentos
	// bit 6 de sevenSeg corresponde al pin g del display
	// bit 0 de sevenSeg corresponde al pin a del display (segun datasheet)
    );
    always_comb begin
    	case (bus_in)
    	// para cada valor del contador, el output sera su representacion en el display
    		4'b0000: 	sevenSeg = 7'b0000001; // 0
    		4'b0001:	sevenSeg = 7'b1001111; // 1
    		4'b0010:	sevenSeg = 7'b0010010; // 2
    		4'b0011:	sevenSeg = 7'b0000110; // 3
    		4'b0100:	sevenSeg = 7'b1001100; // 4
    		4'b0101:	sevenSeg = 7'b0100100; // 5
    		4'b0110:	sevenSeg = 7'b0100000; // 6
    		4'b0111:	sevenSeg = 7'b0001111; // 7
    		4'b1000:	sevenSeg = 7'b0000000; // 8
    		4'b1001:	sevenSeg = 7'b0001100; // 9
    		4'b1010:	sevenSeg = 7'b0001000; // A
    		4'b1011:	sevenSeg = 7'b1100000; // B
    		4'b1100:	sevenSeg = 7'b0110001; // C
    		4'b1101:	sevenSeg = 7'b1000010; // D
    		4'b1110:	sevenSeg = 7'b0110000; // E
    		4'b1111:	sevenSeg = 7'b0111000; // F
    		default:	sevenSeg = 7'b1111111;
    	endcase
    end
endmodule
