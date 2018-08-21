module dithering (
  input logic [7:0] entrada_color_8_bit,
  input logic visible, clk, rst,
  output logic [7:0] salida_color_8_bit
);
localparam THRESHOLD = 8;

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
	.operacion(3'b000), // Operacion a elegir
	.resultado(resultado), // Resultado de la operacion
	.overflow(overflow)
    );
    
always_comb begin
  if (LSN >= THRESHOLD) begin
    if (!overflow) begin
      salida_color_8_bit = {MSN + 4'd1 , LSN};
      n_error = resultado + {4'd0 , LSN};
    end
    
  end
  else begin
  
  end
end

endmodule
