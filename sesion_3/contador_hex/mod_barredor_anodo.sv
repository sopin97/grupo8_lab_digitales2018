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
// Modulo 4: Barredor de anodos
// Breve descripcion: Su funcion es hacer que se prenda un anodo a la vez,
// de esta manera a una frecuencia alta, se podran ver todos los display encendidos
// ocupando un solo BCD_to_sevenseg si la frecuencia es suficientemente alta
//////////////////////////////////////////////////////////////////////////////////

module barredor_anodo(
	input logic [1:0] contador,
	output logic [3:0] AN // -> pines del anodo comun de los display
	// AN[0] es el display menos significativo (segun datasheet)
	// cuando el contador es 0, el anodo del display menos significativo se
	// enciende al mismo tiempo en que el bus del digito menos significativo se enciende
    );
    always_comb begin
    	case(contador) // solamente un anodo se prende a la vez
    		2'd0:	AN = 4'b1110; // se prende el anodo 0
    		2'd1:	AN = 4'b1101; // se prende el anodo 1
    		2'd2:	AN = 4'b1011; // se prende el anodo 2
    		2'd3:	AN = 4'b0111; // se prende el anodo 3
   			
    		default:	AN = 4'b0000;
    	endcase
    end
endmodule
