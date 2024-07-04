module uart_tx(

        input clock, rst, send,
        input [1:0] baud_rate,
        input [7:0] data_in, 
        input [1:0] parity_type,     //refer to the block comment above. 
        input         stop_bits,         //low when using 1 stop bit, high when using two stop bits
        input         data_length,     //low when using 7 data bits, high when using 8.
        
        output      data_out,         //Serial data_out
        output      p_parity_out,     //parallel odd parity output, low when using the frame parity.
        output      tx_active,         //high when Tx is transmitting, low when idle.
        output      tx_done        //high when transmission is done, low when not.
     );
        
		  wire parity_out, baud_out;
        wire [11:0] frame_out;

    

        

        
        //sub_modules
        parity_gen1 g1(
                 .rst(rst),
                  .data_in(data_in),
                  .parity_type(parity_type), // 2-bit for different parity types
                 .parity_out(parity_out)
            );
            
            
        frame_gen1  F1( .rst(rst),
            .data_in(data_in),
           .parity_type(parity_type),
           .parity_out(parity_out),
           .stop_bits(stop_bits), 
           .data_length(data_length), 
            .frame_out(frame_out) );
            
        baud_gen b1(
            .clock(clock),.rst(rst),
           .baud_rate(baud_rate),
           .baud_out(baud_out)
           );
        
       shift_reg1 s1(
            .frame_out(frame_out),
            .stop_bits(stop_bits),.data_length(data_length),
            .baud_out(baud_out), .send(send), .rst(rst),
            .parity_type(parity_type),
            .data_out(data_out),
            .p_parity_out(p_parity_out),
            .tx_active(tx_active),.tx_done(tx_done)
              );
            
    
    endmodule    
	 

