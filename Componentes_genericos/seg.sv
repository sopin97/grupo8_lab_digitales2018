`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2018 03:56:51
// Design Name: 
// Module Name: seg
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


`timescale 1ns / 1ps

module hexa(
        input clk_dis,// reloj a la frecuencia adecuada para los anodos del display
        input [31:0] num,
        input display, // verfica que se use el display

        output logic [7:0] SEG,
        output logic [7:0] ANODO
         );
         
logic [2:0] counter; 
logic [3:0] nible;  
      
always @(posedge clk_dis) begin
                 counter <= counter+2'b1;
     end
always @(*) begin
    if(display==1'b0)
        ANODO[7:0] = 8'b11111111;
    else 
     begin
     case (counter) 
             3'd0 : ANODO[7:0] = 8'b11111110;
             3'd1 : ANODO[7:0] = 8'b11111101;
             3'd2 : ANODO[7:0] = 8'b11111011;
             3'd3 : ANODO[7:0] = 8'b11110111;                              
             3'd4 : ANODO[7:0] = 8'b11101111;
             3'd5 : ANODO[7:0] = 8'b11011111;
             3'd6 : ANODO[7:0] = 8'b10111111;
             3'd7 : ANODO[7:0] = 8'b01111111;        
          default : ANODO[7:0] = 8'b11111111;
     endcase
     end
 end

always @(*) begin
    case (counter) 
                3'd0 :  nible= num[3:0];
                3'd1 :  nible= num[7:4];
                3'd2 :  nible= num[11:8];
                3'd3 :  nible= num[15:12];
                3'd4 :  nible= num[19:16];
                3'd5 :  nible= num[23:20];
                3'd6 :  nible= num[27:24];
                3'd7 :  nible= num[31:28];
                        
                        
                                        
            endcase   
    end
    
 always @(*)begin
     case(nible)
          4'd0:  SEG = 8'b00000011;
          4'd1:  SEG = 8'b10011111; 
          4'd2:  SEG = 8'b00100101;
          4'd3:  SEG = 8'b00001101;
          4'd4:  SEG = 8'b10011001;
          4'd5:  SEG = 8'b01001001;
          4'd6:  SEG = 8'b01000001;
          4'd7:  SEG = 8'b00011111;
          4'd8:  SEG = 8'b00000001;
          4'd9:  SEG = 8'b00011001;
          4'd10: SEG = 8'b00010001; 
          4'd11: SEG = 8'b11000001;
          4'd12: SEG = 8'b01100011;
          4'd13: SEG = 8'b10000101;
          4'd14: SEG = 8'b01100001;
          4'd15: SEG = 8'b01110001;
          default: SEG = 8'b11111111;
      endcase
end  
               

endmodule

