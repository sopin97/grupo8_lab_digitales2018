module debouncer(
	input logic slow_clk,		// entrada de un reloj de frecuencia: 400Hz
	input logic trigger,		// entrada boton
	input logic reset,
	output logic clean_trigger	// salida sin ruido
    );
    logic Q1;
    logic Q2;
    logic n_Q2;
    D_FF D1 (.clk(slow_clk),.D(trigger),.Q(Q1));
    D_FF D2 (.clk(slow_clk), .D(Q1),.Q(Q2));
    assign n_Q2 = ~Q2;
    assign clean_trigger = Q1 & n_Q2;     
endmodule
