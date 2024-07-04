`timescale 1ns / 1ns
module parity_gen1_tb;
    reg rst;
    reg [7:0] data_in;
    reg [1:0] parity_type;
    wire parity_out;

    parity_gen1 uut (
        .rst(rst),
        .data_in(data_in),
        .parity_type(parity_type),
        .parity_out(parity_out)
    );

    initial begin
        // Test even parity
         rst = 1'b1;
        parity_type = 2'b10; // Even parity
        data_in = 8'b00000001; // Expected parity_out = 0
        #10;
        rst = 1'b0;
        data_in = 8'b00000001; // Expected parity_out = 1
        #10;
        data_in = 8'b00000011; // Expected parity_out = 0
        #10;
        data_in = 8'b11111111; // Expected parity_out = 0
        #10;

        // Test odd parity
        parity_type = 2'b01; // Odd parity
        data_in = 8'b00000000; // Expected parity_out = 1
        #10;
        data_in = 8'b00000001; // Expected parity_out = 0
        #10;
        data_in = 8'b00000011; // Expected parity_out = 1
        #10;
        data_in = 8'b11111111; // Expected parity_out = 1
        #10;

        $stop;
    end
endmodule
