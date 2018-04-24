module D_FF(			// modulo corresponde a un flip - flop tipo D
	input	logic clk,
	input	logic D,
	output	logic Q
    );
    always @ (posedge clk)
    begin
    	Q <= D;
    end
endmodule
