`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Laboratorio de Sistemas Digitales, 1er semestre, 2018
// Laboratorio 3
// Integrantes:
// - Tomas Munoz ROL: 201621029-6
// - Mauricio Aravena
// - Oscar Cordova
// Grupo 1000
// Proyecto: contador generalizado
// Modulo: contador de n bits
// Breve descripcion: genera un contador n bit
//////////////////////////////////////////////////////////////////////////////////

// el parametro COUNTER_MAX define el valor maximo a contar incluyendo ese numero

module contador_generico #(parameter COUNTER_MAX = 'd3)( // numero maximo el cual el contador puede llegar a contar
	input logic clk, // -> pin del reloj
	input logic reset, // -> pin de reset
	output logic [n_bits-1:0] contador // salida del contador
    );
    
	localparam n_bits = $clog2(COUNTER_MAX); // n_bits es el numero de bits necesarios para realizar el conteo
	always @(posedge clk) begin
    	if (reset == 1'b1) begin // cuando se aprete reset, contador es 0
    		contador <= 'd0;
    	end
    	else if (contador == COUNTER_MAX) begin // si llega al maximo, se reinicia el contador
    		contador <= 'd0;
    	end
    	else begin
    		contador <= contador + 'd1; // si nada en especial ocurre, contador se incrementa
    	end
    end
endmodule

