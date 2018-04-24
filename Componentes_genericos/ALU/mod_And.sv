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
// Modulo: And
// Breve descripcion: Efectua una and bit a bit
//////////////////////////////////////////////////////////////////////////////////


module And_op(
	input logic [n_bits-1:0] entrada_a, entrada_b,
	output logic [n_bits-1:0] resultado
    );
    parameter n_bits = 8;
    assign resultado = entrada_a & entrada_b;
endmodule
