`timescale 1ns / 1ns
module uart_tx_tb;
localparam T=52083.33333;
  // Inputs
  reg clock;
  reg rst;
  reg send;
  reg [1:0] baud_rate;
  reg [7:0] data_in;
  reg [1:0] parity_type;
  reg stop_bits;
  reg data_length;

  // Outputs
  wire data_out;
  wire p_parity_out;
  wire tx_active;
  wire tx_done;

 
  uart_tx uut (
    .clock(clock), 
    .rst(rst), 
    .send(send), 
    .baud_rate(baud_rate), 
    .data_in(data_in), 
    .parity_type(parity_type), 
    .stop_bits(stop_bits), 
    .data_length(data_length), 
    .data_out(data_out), 
    .p_parity_out(p_parity_out), 
    .tx_active(tx_active), 
    .tx_done(tx_done)
  );

  // Clock generation
  always begin
       clock = 1'b0;
       #(10); 
       clock = 1'b1;
       #(10);
end

  initial begin
    // Initialize Inputs
	 baud_rate = 2'b10;        //9600          
    data_in = 8'b01110100;
    parity_type = 2'b01;      // odd parity
    stop_bits = 1'b0;       
    data_length = 1'b0;    
    rst = 1'b1;
    send = 1'b1;
    #(2*T);
    rst = 1'b0;
	 send = 1'b0;
	 #(2*T)
	 send = 1'b1;
    #(20*T)
    $stop;
  end
      
endmodule
