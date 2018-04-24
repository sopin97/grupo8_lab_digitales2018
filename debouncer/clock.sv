module variable_clock(
	input logic clk_in,
	input logic reset,
	output logic clk_out
    );
    parameter frecuency = 60; // el parametro que varia es la frecuencia deseada para el reloj, por default es 60 [Hz]
    localparam COUNTER_MAX = (100000000/(2*frecuency))-1; //determina el valor del contador a partir del parametro de frecuencia
    localparam n_bits = $clog2(COUNTER_MAX); //determina la cantidad de bits para almacenar COUNTER_MAX
    logic [n_bits-1:0] counter = 'd0;
    //operacion normal del reloj
    always @(posedge clk_in) begin
    	if (reset == 1'b1)
    	begin
    		counter <= 'd0;
    		clk_out <= 1'b0;
    	end
    	else if (counter == COUNTER_MAX)
    	begin
    		counter <= 'd0;
    		clk_out <= ~clk_out;
    	end
    	else
    	begin
    		counter <= counter + 'd1;
    		clk_out <= clk_out;
    	end
    end
endmodule
