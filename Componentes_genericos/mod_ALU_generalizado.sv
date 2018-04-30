`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Laboratorio de Sistemas Digitales, 1er semestre, 2018
// Laboratorio 3
// Integrantes:
// - Tomas Munoz ROL: 201621029-6
// - Mauricio Aravena
// - Oscar Cordova
// Grupo 1000
// Proyecto: ALU Generalizada
// Modulo: modulo superior del alu
// Breve descripcion: efectua una operacion en sus 2 entradas, arrojando como salida un resultado
//////////////////////////////////////////////////////////////////////////////////

module ALU_generalizado(
	input logic [n_bits-1:0] entrada_a, entrada_b, // Entradas ALU
	input logic [2:0] operacion, // Operacion a elegir
	output logic [n_bits-1:0] resultado // Resultado de la operacion
    );
    parameter n_bits = 8; // parametro que describe el numero de bits de la ALU
    // Para cada caso escoge que operacion realiza
	always_comb begin
		case (operacion)
			3'b001:	resultado = entrada_a + entrada_b; // SUMA
			3'b010:	resultado = entrada_a + (~entrada_b + 'd1); // RESTA
			3'b011:	resultado = entrada_a & entrada_b; // AND
			3'b100:	resultado = entrada_a | entrada_b; // OR
			default: resultado = 'd0; // en default es 0 el resultado
		endcase
	end
endmodule
