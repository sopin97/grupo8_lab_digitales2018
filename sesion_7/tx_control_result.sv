module tx_control(
    input logic clk, reset,tx_busy,
    input logic [1:0] stateID,
    input logic [15:0] raw_data,
    output logic tx_start,
    output logic [7:0] tx_data
    //temporal
    );
    
    //Declaracion estados modulo
    enum logic [2:0] {IDLE,Wait_register,delay_cycle,Send_0,Send_1} state, next_state;
    
    //Logica interna
    logic [15:0] temp_data, temp; //Registro resultado
    logic [7:0] tx_next,tx_out;
    assign tx_out   =   tx_data;
    
    always_comb begin
        //defaults
        next_state      =   state;
        tx_start        =   'd0;
        temp            =   temp_data;
        tx_next         =   temp_data[7:0];
        
        case(state)
            IDLE:   begin
                if(stateID  ==  'b11)   begin
                    next_state  =   Wait_register;
                end
            end
            Wait_register:  begin
                if(stateID  ==  'b00)   begin
                    next_state  =   Send_0;
                end
                temp    =   raw_data;
            end
            Send_0: begin
                if(~tx_busy)    begin
                    next_state  =   Send_1;
                end
                tx_start    =   'd1;
            end
            Send_1: begin
                if(~tx_busy)    begin
                    next_state= IDLE;
                end
                tx_next =   temp_data[15:8];
                tx_start    =   'd1;
            end
            endcase
            end
     //logica del estado siguiente
    always_ff @(posedge clk) begin
        if (reset)
            state   <=   IDLE;
        else
            state   <=  next_state;
        end       
     //ff register
    always_ff @(posedge clk)    begin
        temp_data   <=  temp;
        tx_out     <=  tx_next;
        end           
    endmodule
