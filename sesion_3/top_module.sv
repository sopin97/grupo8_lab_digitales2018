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
// Modulo: Modulo completo
// Breve descripcion: es la fusion de todos los modulos, el cual cumple la funcion
// solicitada, lo logra a traves de separar los switches en 4 buses de 4 bit, los cuales
// son 1 a 1 mostrados en cada display, haciendo un barrido por todos los displays gracias al reloj
//////////////////////////////////////////////////////////////////////////////////

// Se definen los input y outputs importantes que van al FPGA,
// los nombres estan dados por lo especificado por el constraint
module top_module(
	input logic [15:0] SW, // switches
	input logic CLK100MHZ, reset, // reloj y boton de reset
	output logic [0:6] sevenSeg, // 7 segmentos
	output logic [3:0] AN // Anodos comunes del display
    );
    // primero separamos los switches en 4 buses
    // cada bus representa un digito en hexadecimal
    wire [3:0] bus1 = SW[3:0];
    wire [3:0] bus2 = SW[7:4];
    wire [3:0] bus3 = SW[11:8];
    wire [3:0] bus4 = SW[15:12];
    
    // creamos 2 cables auxiliares
    wire [1:0] contadores;
    wire [3:0] bus;
    
    // comenzamos con la implementacion de los modulos
    // Multiplexor que dejara pasar solo 1 bus
    multiplexer_4nibble MULTI(
    	.bus1(bus1),
    	.bus2(bus2),
    	.bus3(bus3),
    	.bus4(bus4),
    	.bus_out(bus),
    	.contador(contadores) // el contador regula al multiplexor
    );
    // contador que regula al multiplexor y al barredor de anodos
    contador_2bit CONT(
    	.clk(CLK100MHZ),
    	.reset(reset),
    	.contador(contadores)
    );
    // lo siguiente convierte al bus de salida en un numero legible
    // para el display
    BCD_to_sevenseg BCD(
    	.bus_in(bus),
    	.sevenSeg(sevenSeg)
    );
    // encargado de que se prenda un dsiplay a la vez, haciendo un
    // barrido de todos los display
    barredor_anodo BARAN(
    	.contador(contadores),
    	.AN(AN)
    );
endmodule
