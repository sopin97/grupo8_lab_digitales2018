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
// Modulo 1: Multiplexor
// Breve descripcion: El objetivo de este modulo es filtrar el bus que pasara la informacion
// ocupando un multiplexor de 4 entradas de 4 bit y una salida de 4 bit
//////////////////////////////////////////////////////////////////////////////////

module multiplexer_4nibble(
	input logic [3:0] bus1, bus2, bus3, bus4, // cada bus representa un digito hexadecimal
	input logic [1:0] contador,
	output logic [3:0] bus_out // salida multiplexor
    );
    // el objetivo de este modulo es filtrar el bus que pasara la informacion
    // ocupando un multiplexor de 4 entradas de 4 bit y una salida de 4 bit
    // el contador ira de 0 a 3
    always_comb begin
    	case(contador)
    		2'd0: bus_out = bus1; // Numero Hexadecimal menos significativo
    		2'd1: bus_out = bus2;
    		2'd2: bus_out = bus3;
    		2'd3: bus_out = bus4; // Numero hexadecimal mas significativo
    		default: bus_out = 2'd0;
    	endcase
    end
endmodule
