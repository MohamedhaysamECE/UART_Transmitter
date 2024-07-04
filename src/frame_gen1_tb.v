`timescale 1ns/1ns
module frame_gen1_tb();
    reg rst;
    reg [7:0] data_in;
    reg [1:0] parity_type;
    reg stop_bits, parity_out;
    reg data_length;
    wire [11:0] frame_out;


    frame_gen1 uut (
        .rst(rst),
  .parity_bit(parity_out),
        .data_in(data_in),
        .parity_type(parity_type),
        .stop_bits(stop_bits),
        .data_length(data_length),
        .frame_out(frame_out)
    );

    initial begin
        // Test case 1: 7 data bits, no parity, 1 stop bit
        data_in = 8'b1010101;
        parity_type = 2'b00;
        stop_bits = 1'b0;
        data_length = 1'b0;
    parity_out = 0;
    rst = 1;
        #10;
        rst = 0;
        
    
    #10;
        // Test case 2: 8 data bits, even parity, 1 stop bit
        data_in = 8'b10101010;
        parity_type = 2'b01;
        stop_bits = 1'b0;
        data_length = 1'b1;
    parity_out = 0;
        
   
    #10;
        // Test case 3: 8 data bits, odd parity, 2 stop bits
        data_in = 8'b11110000;
        parity_type = 2'b10;
        stop_bits = 1'b1;
        data_length = 1'b1;
    parity_out= 1;
    
    
        #10;
        $stop;
    end
endmodule
