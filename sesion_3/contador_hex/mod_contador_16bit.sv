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
// Modulo: contador 16 bit
// Breve descripcion: genera un contador 16 bit
//////////////////////////////////////////////////////////////////////////////////


module contador_16bit(
	input logic clk, // -> pin del reloj
	input logic reset, // -> pin de reset
	output logic [15:0] contador // salida del contador
    );
    
    localparam COUNTER_MAX = 16'hffff; // numero maximo el cual el contador puede llegar
    
    always @(posedge clk) begin
    	if (reset == 1'b1) begin // cuando se aprete reset, contador es 0
    		contador <= 16'd0;
    	end
    	else if (contador == COUNTER_MAX) begin // si llega al maximo, se reinicia el contador
    		contador <= 16'd0;
    	end
    	else begin
    		contador <= contador + 16'd1; // si nada en especial ocurre, contador se incrementa
    	end
    end
endmodule
