module dithering_8bit (
	input logic [3:0] entrada_color_8_bit,
  	input logic clk, rst, visible,
	output logic [3:0] salida_color_8_bit
);
localparam THRESHOLD = 2'd2;

// cables para calcular error
	logic [3:0] error, next_error;
// resultado y overflow ALU
	logic [3:0] resultado;
logic overflow;

// se separara a la salida de la ALU como MSN (most significant Nibble) y LSN (Less significant Nibble)
logic [3:0] MSN, LSN;
	assign MSN = resultado[3:2];
	assign LSN = resultado [1:0];

	ALU_generalizado #(.n_bits(5)) ALU(
	.entrada_a({1'b0,entrada_color_8_bit}), .entrada_b({1'b0,error}), // Entradas ALU
	.operacion(3'b000), // SUMA
	.resultado(resultado), // Resultado de la operacion
	.overflow(overflow)
    );
    
always_comb begin
	if (!overflow) begin
		if (LSN >= THRESHOLD) begin
			next_error = error - (4'd8 - {2'd0 , LSN});
			if (MSN == 2'b11) begin
				salida_color_8_bit = {MSN , 2'd0};
			end
			else begin
				salida_color_8_bit = {MSN + 'd1 , 2'd0};
			end
		end
    		else begin
			next_error = error + {2'd0 , LSN};
			salida_color_8_bit = {MSN , 2'd0};
    		end
  	end
	else begin
		next_error = error - {MSN , LSN}+'d1;
		salida_color_8_bit = {2'b11 , 2'd0};
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
