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
// Modulo: Suma
// Breve descripcion: Efectua una suma entre 2 operandos
//////////////////////////////////////////////////////////////////////////////////


module Suma(
	input logic [n_bits-1:0] entrada_a, entrada_b, // dos entradas
	output logic [n_bits-1:0] resultado // resultado
    );
    parameter n_bits = 8; // parametro de bits
    assign resultado = entrada_a + entrada_b; // la suma
endmodule
