module filter(
  input [15:0] entrada
  input sw,
  output [15:0] salida1,salida2
);
  logic [15:0] c1,c2, c1_out, c2_out;
  assign c1 = entrada;
  assign c2 = entrada;
	unsigned_to_bcd u32_to_bcd_inst (
		.clk(clk),
    .trigger(1'd1),
    .in(c2),
    .bcd(c2_out)
	);
  always_comb begin
    if(sw) begin
      output = c2_out;
    end
    else 
      output = c1_out;
  end
  
  
