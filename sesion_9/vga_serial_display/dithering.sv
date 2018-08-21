module dithering_8bit (
  input logic [7:0] entrada_color_8_bit,
  input logic clk, rst,
  output logic [7:0] salida_color_8_bit
);
localparam THRESHOLD = 4'd8;

// cables para calcular error
logic [7:0] error, next_error;
// resultado y overflow ALU
logic [7:0] resultado;
logic overflow;

// se separara a la salida de la ALU como MSN (most significant Nibble) y LSN (Less significant Nibble)
logic [3:0] MSN, LSN;
assign MSN = resultado[7:4];
assign LSN = resultado [3:0];

ALU_generalizado #(.n_bits(8)) ALU(
	.entrada_a(entrada_color_8_bit), .entrada_b(error), // Entradas ALU
	.operacion(3'b000), // SUMA
	.resultado(resultado), // Resultado de la operacion
	.overflow(overflow)
    );
    
always_comb begin
	if (!overflow) begin
		if (LSN >= THRESHOLD) begin
			if (MSN == 4'hF) begin
				next_error = error - (4'h10 - {4'd0 , LSN});
				salida_color_8_bit = {MSN , 4'd0};
			end
			else begin
				next_error = error + (resultado - {MSN + 'd1 , 4'd0});
				salida_color_8_bit = {MSN + 'd1 , 4'd0};
			end
		end
    		else begin
			salida_color_8_bit = {MSN , 4'd0};
			next_error = error + (resultado - {MSN , 4'd0});
    		end
  	end
	else begin
		next_error = error - resultado+'d1;
		salida_color_8_bit = {4'hF , 4'd0};
  	end
end
	// logica secuencial del error
	always_ff @(posedge clk) begin
		if (rst)
			error <= 'd0;
		else
			error <= next_error;
	end
endmodule
