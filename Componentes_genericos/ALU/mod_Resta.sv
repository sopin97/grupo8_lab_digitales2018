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
// Modulo: Resta
// Breve descripcion: Efectua una resta entre dos operandos
//////////////////////////////////////////////////////////////////////////////////


module Resta(
	input logic [n_bits-1:0] entrada_a, entrada_b, // 2 entradas
	output logic [n_bits-1:0] resultado // 1 salida
    );
    parameter n_bits = 8; // parametro de bits
    // efectua una resta en 2 complementos
    always_comb begin
    // realiza una resta en 2 complementos
    	resultado = (entrada_a + ((~entrada_b) + 'd1));
    end;
endmodule
