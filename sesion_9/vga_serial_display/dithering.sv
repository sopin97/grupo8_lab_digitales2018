module dithering_8bit (
	input logic [7:0] entrada_color_8_bit,
  	input logic clk, rst, visible,
	output logic [7:0] salida_color_8_bit
);
localparam THRESHOLD = 'd4;

// cables para calcular error
	logic [7:0] error, next_error;
// resultado y overflow ALU
	logic [15:0] resultado;
logic overflow;

// se separara a la salida de la ALU como MSN (most significant Nibble) y LSN (Less significant Nibble)
logic [3:0] MSN, LSN;
	assign MSN = resultado[7:4];
	assign LSN = resultado [3:0];

	ALU_generalizado #(.n_bits(16)) ALU(
		.entrada_a({8'b0,entrada_color_8_bit}), .entrada_b({8'd0,error}), // Entradas ALU
	.operacion(3'b000), // SUMA
	.resultado(resultado), // Resultado de la operacion
    );
    
always_comb begin
		if (LSN >= THRESHOLD) begin
			next_error = error - (8'd16 - {4'd0 , LSN});
			if (resultado >= 8'hFF) begin
				salida_color_8_bit = {MSN , 4'd0};
			end
			else begin
				salida_color_8_bit = {MSN + 'd1 , 4'd0};
			end
		end
    		else begin
			next_error = error + {4'd0 , LSN};
			salida_color_8_bit = {MSN , 4'd0};
    		end
salida_color_8_bit = {4'hF , 4'd0};
  	end
end
	// logica secuencial del error
	always_ff @(posedge clk) begin
		if (rst) begin
			error <= 'd0;
		end
		else begin
			if (visible)
				error <= next_error;
			else
				error <= 'd0;
		end
	end
endmodule
