`timescale 1ns / 1ps
module shift_reg1_tb(
    );
     reg [11:0]frame_out;
     reg stop_bits,data_lenth;
     reg baud_out, send, rst;
     reg [1:0] parity_type;
     wire data_out;
     wire p_parity_out;
     wire tx_active,tx_done;
  // clock priod
  localparam T = 20;
  
  //clock generation
 always begin
          baud_out = 0; #(T/2);
          baud_out = 1; #(T/2);
        end
  //instance
  shift_reg1 s1(.frame_out(frame_out), .stop_bits(stop_bits) ,.data_lenth(data_lenth),
    .baud_out(baud_out), .send(send), .rst(rst),.parity_type(parity_type),
     .data_out(data_out),.p_parity_out(p_parity_out),
    .tx_active(tx_active),.tx_done(tx_done)
      );      
  //initial signals
  localparam start = 1'b0,
             stop  = 1'b1,
             parity_bit = 1'b1; 
  initial 
  begin            
   parity_type = 2'b01; //odd parity
   data_lenth = 1'b0;
   stop_bits = 1'b0;
   frame_out[11:0] = {1'b1,1'b1,stop,parity_bit,1'b1,1'b0,1'b1,1'b0,1'b1,1'b1,1'b1 ,start};
   rst = 1;
   send = 1;
  end 
  
  initial
  
   begin
    #(3*T/2); rst = 0;
    send = 0;
    #(T); send = 1;
    #(15*T);
    parity_type = 2'b10; //even parity
    data_lenth = 1'b0;
    stop_bits = 1'b0; 
    frame_out[11:0] = {1'b1,1'b1,stop,parity_bit,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b1 ,start};
    send = 0;
    repeat(2) @(negedge baud_out);
    send = 1;
    #(20*T);
    $stop;
   end
   
endmodule
