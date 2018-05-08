`timescale 1ns / 1ps

module Calculadora_undo(
	input logic CLK100MHZ, reset, BTNC, BTNU, BTND,
	input logic [15:0] SW,
	output logic [7:0] AN,
	output logic [6:0] sevenSeg,
	output logic [3:0] LED,
	output logic LED16_B, LED16_G, LED16_R
    );
    
    logic BTNC_clean, BTNU_clean, reset_clean, BTNU_posedge, BTND_clean;
    
    logic [1:0] operacion, estado;
    logic [16:0] sumando1, sumando2, resultado;
    logic enable1, enable2, enable3;
    logic power;
    logic [16:0] salida_FSM;
    logic [31:0] salida_dd;
    logic [31:0] entrada_display;
    logic led_dd;
    logic [2:0] led_in;
    logic led_on = &estado;
    PushButton_Debouncer2 #(.N(20)) DEB4 (
    	.clk(CLK100MHZ),
    	.rst(1'b0),
    	.PB(BTNC),
    	.PB_posedge(BTNC_clean)
    );
    PushButton_Debouncer2 #(.N(20)) DEB5 (
        	.clk(CLK100MHZ),
        	.rst(1'b0),
        	.PB(~reset),
        	.PB_state(reset_clean)
        );
    PushButton_Debouncer2 #(.N(20)) DEB6 (
             .clk(CLK100MHZ),
             .rst(1'b0),
             .PB(BTNU),
             .PB_state(BTNU_clean),
             .PB_posedge(BTNU_posedge)
                );
    PushButton_Debouncer2 #(.N(20)) DEB7 (
             .clk(CLK100MHZ),
             .rst(1'b0),
             .PB(BTND),
             .PB_posedge(BTND_clean)
             );
    ALU_generalizado #(17) ALU2(
    	.entrada_a(sumando1),
    	.entrada_b(sumando2),
    	.operacion(operacion),
    	.resultado(resultado)
    );
    register #(17) REG4 (
    	.clk(CLK100MHZ),
    	.reset(reset_clean),
    	.switches({1'b0,SW}),
    	.retain(enable1),
    	.retain_output(sumando1)
    );
    register #(17) REG5 (
    	.clk(CLK100MHZ),
    	.reset(reset_clean),
    	.switches({1'b0,SW}),
    	.retain(enable2),
    	.retain_output(sumando2)
    );
    register #(2) REG6 (
    	.clk(CLK100MHZ),
    	.reset(reset_clean),
    	.switches(SW[1:0]),
    	.retain(enable3),
    	.retain_output(operacion)
    );
    display_hex DIS2 (
    	.numero_entrada(entrada_display),
    	.power_on(power),
    	.clk(CLK100MHZ),
    	.SEG(sevenSeg),
    	.ANODO(AN)
    );
    FSM2 FSM2 (
    	.clk(CLK100MHZ),
    	.reset(reset_clean),
    	.BTNC(BTNC_clean),
    	.BTNL(BTND_clean),
    	.SW(SW),
    	.resultado(resultado),
    	.enable({enable1, enable2, enable3}),
    	.power_on(power),
    	.salida_display(salida_FSM),
    	.estado(estado)
    );
    unsigned_to_bcd DD2 (
		.clk(CLK100MHZ),
		.trigger(BTNU_posedge),
		.in({16'd0,salida_FSM[15:0]}),
		.idle(led_dd),
		.bcd(salida_dd)
   	);
   	controller RGB1 (
   		.reset(led_on),
   		.clk_in(CLK100MHZ),
   		.led_in(led_in),
   		.led_out({LED16_R,LED16_G,LED16_B})
   	);
    
    always_comb begin
    	case(BTNU_clean)
    		1'b0: entrada_display = {16'd0,salida_FSM[15:0]};
    		1'b1: entrada_display = salida_dd;
    		default: entrada_display = {16'd0,salida_FSM[15:0]};
    	endcase
    end
    always_comb begin
    	case(salida_FSM[16])
    		1'b0: led_in = 3'b010;
    		1'b1: led_in = 3'b100;
    		default: led_in = 3'b010;
    	endcase
    end
    
    assign LED[3] = ~led_dd;
    assign LED[2:0] = {reset_clean, estado};
    
endmodule
