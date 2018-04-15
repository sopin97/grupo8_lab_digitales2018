`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Laboratorio de Sistemas Digitales, 1er semestre, 2018
// Laboratorio 3
// Integrantes:
// - Tomas Munoz ROL: 201621029-6
// - Mauricio Aravena
// - Oscar Cordova
// Grupo 1000
// Proyecto: Contador de 4 digitos hexadecimal
// Modulo: Modulo completo
// Breve descripcion: es la fusion de todos los modulos, el cual cumple la funcion
// solicitada, lo logra a traves de separar los switches en 4 buses de 4 bit, los cuales
// son 1 a 1 mostrados en cada display, haciendo un barrido por todos los displays gracias al reloj
//////////////////////////////////////////////////////////////////////////////////

module contador_hex4hz(
	input logic CLK100MHZ,reset,
	output logic [0:6] sevenSeg,
	output logic [3:0] AN // primeros 4 anodos display
    );
    logic clk_out4hz; // Reloj de 4 HZ
    logic clk_out; // Reloj de 120 HZ (en realidad no es de 120 porque hicmos mal el calculo ojo)
    logic [15:0] contador16bit; // contador 16 bit
    logic [1:0] contador2bit; // contador 2 bit
    
    logic [3:0] bus_out; // bus de salida de 4 bit
    
     // se crean los modulos
    clk4hz CLK4HZ(.clk_in(CLK100MHZ), .reset(reset), .clk_out(clk_out4hz)); // genera un reloj de 4 hz
    clk_generator CLK2 (.clk_in(CLK100MHZ),.reset(reset),.clk_out(clk_out)); // genera un reloj de 120 hz
    
    contador_16bit CONT1(.clk(clk_out4hz),.reset(reset), .contador(contador16bit)); // contador 16 bit
    contador_2bit CONT2(.clk(clk_out),.reset(reset),.contador(contador2bit)); // contador 2 bit
    
    multiplexer_4nibble MULTI2(.bus1(contador16bit[3:0]), // multiplexor, de entrada de 4 buses de 4 bit y salida de 1 bit
    	.bus2(contador16bit[7:4]),
    	.bus3(contador16bit[11:8]),
    	.bus4(contador16bit[15:12]),
    	.contador(contador2bit),
    	.bus_out(bus_out));
    	
    BCD_to_sevenseg SEG2(.bus_in(bus_out),.sevenSeg(sevenSeg)); // convertidor de bcd a 7seg
    barredor_anodo BARAN2(.contador(contador2bit),.AN(AN)); // se preocupa de barrer los 4 display para que se vean todos los numeros de manera fluida
    
endmodule
