module baud_gen(
input clock,rst,
input [1:0] baud_rate,
output reg baud_out
);
//states encoding 
localparam [1:0] baud_2400  = 2'b00,
                 baud_4800  = 2'b01,
                 baud_9600  = 2'b10,
                 baud_19200 = 2'b11;
// internal signals
reg [14:0] tick;
reg [14:0] fin;

always @(*)
begin
    case (baud_rate)
        baud_2400 : fin = 15'd20833;    //   ticks  2400 baudrate.
        baud_4800 : fin = 15'd10416;    //   ticks  4800 baudrate.
        baud_9600 : fin = 15'd5208;     //   ticks  9600 baudrate.
        baud_19200: fin = 15'd2604;     //  ticks  19200 baudrate.
    endcase
end
always @(posedge clock or posedge rst)
begin
    if(rst)
    begin
        tick <= 14'd0; 
        baud_out <= 1'b0; 
    end
    else
    begin
     if (tick <= fin-1) 
     begin
      tick <= tick + 1'd1;    
      if(tick < fin / 2 )
      begin  
       baud_out <= 1'b1;  
      end 
      else 
      begin
       baud_out <= 1'b0; 
      end
     end 
      else 
      begin
       tick = 1'b0;
      end
   end 
end
endmodule