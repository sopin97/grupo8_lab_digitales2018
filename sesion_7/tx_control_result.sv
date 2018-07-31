module tx_control(
    input logic clk, reset,tx_busy,
    input logic [1:0] stateID,
    input logic [15:0] raw_data,
    output logic tx_start,
    output logic [7:0] tx_data,
    //temporal
    output logic [2:0] id
    );
    
    //Declaracion estados modulo
    enum logic [2:0] {IDLE,Wait_register,delay_cycle,Send_0,Send_1} state, next_state;
    assign  id  =   state;
    
    //Logica interna
    logic [15:0] temp_data, next_data; //Registro del resultado
    logic [7:0] data_chunk_1,data_chunk_2,next_1,next_2,tx_next;

    always_comb begin
        //defaults
        next_state  =   state;
        next_1      =   data_chunk_1;
        next_2      =   data_chunk_2;
        tx_start    =   'd0;
        next_data   =   temp_data; //revisar
        tx_next     =   tx_data;
        
        case(state)
            IDLE:   begin
                if (stateID ==  2'b11) begin
                    next_state  =   Wait_register;
                    end
                end
            Wait_register:  begin
                if (stateID ==  2'b00) begin
                    next_state  =   delay_cycle;
                    end
                next_data   =   raw_data;
                //next_1      =   raw_data[7:0];
                //next_2      =   raw_data[15:0];
                end
            delay_cycle:    begin
                        next_state  =   Send_0;
                        next_1      =   temp_data[7:0];
                        end            
            Send_0: begin
                if(~tx_busy ==  1'b1) begin
                    next_state  =   Send_1;
                    end
                next_2      =   temp_data[15:8];
                tx_start    =   1'b1;
                tx_next     =   data_chunk_1;
                end
            Send_1: begin
                if(~tx_busy ==  1'b1) begin
                    next_state  =   IDLE;
                    end
                tx_start    =   1'b1;
                tx_next     =   data_chunk_2;
                end
            endcase
    end
    
    always_ff @(posedge clk) begin
        if(reset) begin
            state       <=  IDLE;
            end
        if (state  ==  Wait_register) begin
            temp_data   <=  next_data;  
            end
        state           <=  next_state;  
        data_chunk_1    <=  next_1;
        data_chunk_2    <=  next_2;
        tx_data         <=  tx_next;    
    end
            
endmodule
