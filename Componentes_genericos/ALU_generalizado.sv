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
    
    // A continuacion estan los resultados individuales de cada operacion
    logic [n_bits-1:0] resultado_suma, resultado_resta, resultado_and, resultado_or;
    // A continuacion se instancian los modulos, cabe notar que se les pasa
    // el parametri de numeros de bits.
    // Instancia del modulo de la suma
    Suma #(n_bits) SUM(
    	.entrada_a(entrada_a),
    	.entrada_b(entrada_b),
    	.resultado(resultado_suma)
    );
    // Instancia del modulo de la resta
    Resta #(n_bits) RES(
    	.entrada_a(entrada_a),
    	.entrada_b(entrada_b),
    	.resultado(resultado_resta)
    );
    // Instancia del modulo del AND
    And_op #(n_bits) AND1(
    	.entrada_a(entrada_a),
        .entrada_b(entrada_b),
        .resultado(resultado_and)
    );
    // Instancia del modulo del OR
    Or_op #(n_bits) OR1(
    	.entrada_a(entrada_a),
        .entrada_b(entrada_b),
        .resultado(resultado_or)
    );
    // Para cada caso escoge que operacion realiza
	always_comb begin
		case (operacion)
			3'b001:	resultado = resultado_suma; // SUMA
			3'b010:	resultado = resultado_resta; // RESTA
			3'b011:	resultado = resultado_and; // AND
			3'b100:	resultado = resultado_or; // OR
			default: resultado = 'd0; // en default es 0 el resultado
		endcase
	end

endmodule
