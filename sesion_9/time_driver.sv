`timescale 1ns / 1ps

/*
** El proposito de este modulo es que en la salida exista un reloj digital
** en que se puede aumentar las horas y minutos de acuerdo a los botones
*/
module time_driver(
	input logic BTNR, BTNL, BTNC, CPU_RESETN, CLK100MHZ, SW,
	output logic LED,
	output logic [6:0] sevenSeg,
	output logic [7:0] AN
    );
    
    // BOTONES para la salida del debouncer
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    logic BTNLn, BTNL_pos, BTNL_neg;
    logic BTNRn, BTNR_pos, BTNR_neg;
    logic BTNCn;

    // RESET
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    logic reset_seconds; // sirve para dejar los segundos en 0
    logic rst; // reset general
    assign rst = ~CPU_RESETN;
    assign reset_seconds = BTNC|rst;
    
    // DEBOUNCERS PARA BOTONES
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    PushButton_Debouncer2 BUTTON1(
    	.clk(CLK100MHZ),
    	.rst(rst),
    	.PB(BTNR),
    	.PB_state(BTNRn),
    	.PB_negedge(BTNR_neg),
    	.PB_posedge(BTNR_pos));
    PushButton_Debouncer2 BUTTON2(
    	.clk(CLK100MHZ),
    	.rst(rst),
    	.PB(BTNL),
    	.PB_state(BTNLn),
    	.PB_negedge(BTNL_neg),
    	.PB_posedge(BTNL_pos));
    PushButton_Debouncer2 BUTTON3(
    	.clk(CLK100MHZ),
    	.rst(rst),
    	.PB(BTNC),
    	.PB_state(BTNCn),
    	.PB_negedge(),
    	.PB_posedge());  
  
	// VARIABLES DE HORAS, MINUTO, SEGUNDO
	    logic [7:0] SEGUNDO, MINUTO, HORA;
    	logic [7:0] hora_am, horas, HORAn;
    	logic [7:0] hora_normal;
    	logic [7:0] minutos, MINUTOn, segundos, SEGUNDOn;
    // SMART_DRIVERS --> modulo que permite generar las horas, los minutos y los segundos
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    logic trigger_minutes, trigger_hours;
    
    smart_counter #(.OUTPUT_COUNTER_MAX(60), .COUNTER_TRIGGER_MAX(100000000)) SMART_SECONDS(
	    .trigger(~CLK100MHZ), .clk(CLK100MHZ), .rst(reset_seconds), .BTN(1'b0), .BTN_pos(1'b0), .BTN_neg(1'b0),
    	.trigger_out(trigger_minutes),
    	.output_counter(segundos)
        );

    smart_counter #(.OUTPUT_COUNTER_MAX(60), .COUNTER_TRIGGER_MAX(60)) SMART_MINUTES(
    	.trigger(trigger_minutes), .clk(CLK100MHZ), .rst(rst), .BTN(BTNLn), .BTN_pos(BTNL_pos), .BTN_neg(BTNL_neg),
    	.trigger_out(trigger_hours),
    	.output_counter(minutos)
        );
    smart_counter #(.OUTPUT_COUNTER_MAX(24), .COUNTER_TRIGGER_MAX(60)) SMART_HOUR(
        	.trigger(trigger_hours), .clk(CLK100MHZ), .rst(rst), .BTN(BTNRn), .BTN_pos(BTNR_pos), .BTN_neg(BTNR_neg),
        	.trigger_out(),
        	.output_counter(hora_normal)
            );
            
// TRANSFORMACION DE AM a PM

	always_comb begin
		if (hora_normal >= 'd12)
			hora_am = hora_normal - 'd12;
		else
			hora_am = hora_normal;
	end
// Seleccion de formato de hora
	always_comb begin
		if (SW == 1'b0)
			{LED, horas} = {1'b0, hora_normal};
		else
			{LED, horas} = {1'b1, hora_am};
	end

// DOUBLE DABBERS
unsigned_to_bcd HORAs (   
	.clk(CLK100MHZ),                         
	.trigger(1'b1),                 
	.in(horas),                           
	.idle(),                       
	.bcd(HORAn)                          
);
unsigned_to_bcd MINUTOs (   
	.clk(CLK100MHZ),                         
	.trigger(1'b1),                 
	.in(minutos),                           
	.idle(),                       
	.bcd(MINUTOn)                          
);
unsigned_to_bcd SEGUNDOs (   
	.clk(CLK100MHZ),                         
	.trigger(1'b1),                 
	.in(segundos),                           
	.idle(),                       
	.bcd(SEGUNDOn)                          
);                        
always_ff @(posedge CLK100MHZ) begin
	HORA <= HORAn;
	MINUTO <= MINUTOn;
	SEGUNDO <= SEGUNDOn;
end

// SALIDA AL DISPLAY
display_hex(
    .numero_entrada({8'b0, HORA, MINUTO, SEGUNDO}),
    .power_on(1'b1), .clk(CLK100MHZ), // prende el display
    .SEG(sevenSeg),
    .ANODO(AN)
	);

endmodule
