`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2018 21:58:51
// Design Name: 
// Module Name: SE
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SE(
    input   logic clk, reset_n, uart_tx,
    output  logic [6:0] SEG,
    output  logic [7:0] ANODO,
    output  logic [5:0] dual_RGB,
    output  logic [15:0]LEDS_out,
    output  logic tx, tx_sniff, rx_sniff
    );
    //sniffer
    logic rx_in, tx_out;
    assign rx_in    =   uart_tx;
    assign tx   =   tx_out;
    assign tx_sniff =   tx_out;
    assign rx_sniff =   rx_in;
    
    //UART        
    logic [7:0]  rx_data; //data proveniende de la uart
    logic        rx_ready;//señal de recepcion completa de la uart
    
    //ALU
    logic [15:0] OP1,OP2,alu_exit; //Operandos y resultado
    logic [1:0]  CTRL; //comando
    
    //Double Dabble
    logic [31:0] bcd_output; //Salida del conversor BCD
    
    //Display
    logic [31:0] display_32; //Entrada display_32bits
    
    //RGB
    logic [2:0]  pre_led_in; //Señal combinacional led
    logic [2:0]  led_in; //Señal entrada RGB
    logic [2:0]  RGB_out; //Salida del modulo RGB
    logic [5:0]  dual_led; //Señal para ambos leds
    assign dual_led     =   {RGB_out,RGB_out};
    assign dual_RGB     =   dual_led;
    
    //TX_CTRL
    logic tx_flag, tx_start; //señal busy proveniende de la UART, señal de inicio UART
    logic [7:0] tx_data; //data chunk para envio
    
    //Varios
    logic output_ready; //trigger para tx_control
    logic [15:0] exit; //salida leds, display por estado
    logic [1:0]  estado; //estado proveniente del wrapper - leds/rgb
    assign display_32   =   {16'd0, exit}; //data corregida para el display
    assign LEDS_out     =   exit; //Salida para led
    
    //debounce del boton reset
    logic [1:0]    reset_sr;
    logic reset;
    assign reset = reset_sr[1];
        
    always_ff @(posedge clk)
          reset_sr <= {reset_sr[0], ~reset_n};
    
    //Modulos instanciados:
    //UART
    uart_basic #(.CLK_FREQUENCY(100000000),.BAUD_RATE(115200))  UART_SE(.clk(clk),  .reset(reset),  .rx(rx_in),   .rx_data(rx_data),
                        .rx_ready(rx_ready), .tx_start(tx_start), .tx_busy(tx_flag), .tx_data(tx_data), .tx(tx_out));
                        
    //Control Wrapper [REVISADO]
    UART_rx_control_wrapper RX_CTRL(.clock(clk),    .reset(reset),  .rx_data(rx_data),
                        .rx_ready(rx_ready),    .operando1(OP1),    .operando2(OP2),
                        .ALU_ctrl(CTRL),    .stateID(estado),   .output_ready(output_ready));
                        
    //ALU [REVISADO]
    ALU_generalizado    #(.n_bits (16))    ALU(.entrada_a(OP1),  .entrada_b(OP2),
                        .operacion(CTRL),   .resultado(alu_exit));
                        
   //Double-Dabble (Github del curso)
    unsigned_to_bcd u32_to_bcd_inst (.clk(clk),.trigger('b1),.in(display_32),.bcd(bcd_output) );         
                
   //Display -32bits
    display_hex DISP(.clk(clk), .power_on('d1), .numero_entrada(bcd_output),    
                        .SEG(SEG),  .ANODO(ANODO));
                        
   //RGB-Controller
    controller  RGB(.reset(reset),  .clk_in(clk),   .led_in(led_in),    .led_out(RGB_out));
    
    //TX_control    
    tx_control TX_CTRL(.clk(clk), .reset(reset), .raw_data(alu_exit), .tx_busy(tx_flag), .tx_start(tx_start), .tx_data(tx_data), .trigger(output_ready));
    
   //Logica RGB
   always @(*) begin
   pre_led_in   =   led_in;
   exit         =   alu_exit;
   case(estado)
   		2'b00: begin //estado IDLE -> AZUL
            pre_led_in  =   3'd4;
        end
        2'b01: begin //estado OP1 ->VERDE
            pre_led_in  =   3'd2;
            exit        =   OP1;
        end
        2'b10: begin
            pre_led_in  =   3'd1; //estado CTRL -> ROJO
            exit        =   OP2;
        end
        2'b11: begin
            
        end
   endcase
   end
   always_ff @(posedge clk) begin
        if (reset)  begin
            led_in  <=  'd7;
        end
        else    begin
            led_in  <=  pre_led_in;
        end
   end
    
    
endmodule
