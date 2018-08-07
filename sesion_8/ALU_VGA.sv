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

module ALU_generalizado #(parameter n_bits = 8)(
	input logic [n_bits-1:0] entrada_a, entrada_b, // Entradas ALU
	input logic [2:0] operacion, // Operacion a elegir
	output logic [n_bits-1:0] resultado, // Resultado de la operacion
	output logic overflow
    );
    
    logic temp, bit_a, bit_b;
    assign bit_a = entrada_a[n_bits-1];
    assign bit_b = entrada_b[n_bits-1];

    // Para cada caso escoge que operacion realiza
	always_comb begin
		case (operacion)
			3'b001:	begin
						resultado = entrada_a * entrada_b;
						overflow = (((resultado[n_bits-1] == 0) && (bit_a == bit_b)) || ((resultado[n_bits-1] == 1) && (bit_a != bit_b)))? 1'b0:1'b1;
					end
			3'b000:	begin
						resultado = entrada_a + entrada_b; // SUMA
						overflow = (resultado[n_bits-1] == 1)? 1'b1:1'b0;
					end
			3'b100:	begin
						resultado = entrada_a + (~entrada_b + 'd1); // RESTA
						overflow = 1'b0;
					end
			3'b010:	begin
						resultado = entrada_a & entrada_b; // AND
						overflow = 1'b0;
					end
			3'b101:	begin
						resultado = entrada_a | entrada_b; // OR
						overflow = 1'b0;
					end
			default: begin resultado = 'd0; // en default es 0 el resultado
					 overflow = 1'b0; end
		endcase
	end
endmodule
