`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Laboratorio de Sistemas Digitales, 1er semestre, 2018
// Laboratorio 3
// Integrantes:
// - Tomas Munoz ROL: 201621029-6
// - Mauricio Aravena
// - Oscar Cordova
// Grupo 1000
// Proyecto: contador de 4 numeros Hexadecimal
// Modulo: generador de reloj de 120 hz
// Breve descripcion: le entra un reloj de 100Mhz y lo convierte en un reloj de 120hz
//////////////////////////////////////////////////////////////////////////////////


module clk_generator(
	input logic clk_in,
	input logic reset,
	output logic clk_out
    );
    localparam COUNTER_MAX = 27'd417000;
    logic [26:0] counter = 27'd0;
    
    always @(posedge clk_in) begin
    	if (reset == 1'b1)
    	begin
    		counter <= 27'd0;
    		clk_out <= 1'b0;
    	end
    	else if (counter == COUNTER_MAX)
    	begin
    		counter <= 27'd0;
    		clk_out <= ~clk_out;
    	end
    	else
    	begin
    		counter <= counter + 27'd1;
    		clk_out <= clk_out;
    	end
    end
endmodule
