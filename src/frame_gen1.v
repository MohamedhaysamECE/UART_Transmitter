module frame_gen1(
    input  rst,
    input [7:0] data_in,
    input  [1:0]parity_type,
    input  parity_out,
    input  stop_bits, 
    input  data_length, 
    output reg [11:0] frame_out // 1 start bit, 8 data bits, 1 parity bit, 1 stop bit
);
    /*localparam stop_bit = 1'b1,
               start_bit = 1'b0;*/
    always @(*) begin
        if (rst) begin
            frame_out = 12'd0;
         end 
        else 
         begin
         //mohamed haysam 
           /* // Start bit
           frame_out[0] = start_bit;           
            case ({data_length,stop_bits,parity_type})
                4'b0001:   frame_out[11:1] = {2'b11,stop_bit,parity_out,data_in[6:0]}; //data_in >> farme_out [8:1] , parity_out >>> frame_out[9], stop_bit >>> frame_out[10]
                4'b0010:   frame_out[11:1] = {2'b11,stop_bit,parity_out,data_in[6:0]}; //data_in >> farme_out [7:1] , parity_out >>> frame_out[9], stop_bit >>> frame_out[10:9;
                4'b0000:   frame_out[11:1] = {3'b111,stop_bit,data_in[6:0]};
                4'b0011:   frame_out[11:1] = {3'b111,stop_bit,data_in[6:0]};
                4'b0101:   frame_out[11:1] = {1'b1,stop_bit,stop_bit,parity_out,data_in[6:0]};
                4'b0110:   frame_out[11:1] = {1'b1,stop_bit,stop_bit,parity_out,data_in[6:0]};
                4'b0100:   frame_out[11:1] = {2'b11,stop_bit,stop_bit,data_in[6:0]};
                4'b0111:   frame_out[11:1] = {2'b11,stop_bit,stop_bit,data_in[6:0]};
                4'b1001:   frame_out[11:1] = {1'b1,stop_bit,parity_out,data_in[7:0]};
                4'b1010:   frame_out[11:1] = {1'b1,stop_bit,parity_out,data_in[7:0]};
                4'b1000:   frame_out[11:1] = {2'b11,stop_bit,data_in[7:0]};
                4'b1011:   frame_out[11:1] = {2'b11,stop_bit,data_in[7:0]};
                4'b1101:   frame_out[11:1] = {stop_bit,stop_bit,parity_out,data_in[7:0]};
                4'b1110:   frame_out[11:1] = {stop_bit,stop_bit,parity_out,data_in[7:0]};
                4'b1100:   frame_out[11:1] = {1'b1,stop_bit,stop_bit,data_in[7:0]};
                4'b1111:   frame_out[11:1] = {1'b1,stop_bit,stop_bit,data_in[7:0]};
                default:   frame_out[11:1] = 10'b1111111111; 
                            endcase*/
                 /// Ahmed rashwan
                 case ({data_length, stop_bits})
                               // 7 data bits, 1 stop bit
                               2'b00: begin
                                   if (parity_type == 2'b01 || parity_type == 2'b10) begin
                                       frame_out = {2'b11,1'b1,parity_out,data_in[6:0],1'b0}; // 1 stop bit, 2 padding bits
                                                   
                                   end else begin
                                       frame_out = {  3'b111,1'b1,data_in[6:0],1'b0}; // 1 stop bit, 3 padding bits
                                   end
                               end
               
                               // 7 data bits, 2 stop bits
                               2'b01: begin
                                   if (parity_type == 2'b01 || parity_type == 2'b10) begin
                                       frame_out = { 1'b1 ,2'b11,parity_out,data_in[6:0],1'b0}; // 2 stop bits, 1 padding bit
                                   end else begin
                                       frame_out = { 2'b11,2'b11,data_in[6:0],1'b0}; // 2 stop bits, 2 padding bits
                                   end
                               end
               
                               // 8 data bits, 1 stop bit
                               2'b10: begin
                                   if (parity_type == 2'b01 || parity_type == 2'b10) begin
                                       frame_out = {1'b1,1'b1,parity_out,data_in[7:0],1'b0}; // 1 bit padding
                                   end else begin
                                       frame_out = { 2'b11,1'b1,data_in[7:0],1'b0}; // 2 bit badding
                                   end
                               end
               
                               // 8 data bits, 2 stop bits
                               2'b11: begin
                                   if (parity_type == 2'b01 || parity_type == 2'b10) begin
                                       frame_out = { 2'b11,parity_out,data_in[7:0],1'b0 }; // 2 stop bits
                                   end else begin
                                       frame_out = { 1'b1,2'b11,data_in[7:0],1'b0}; // 2 stop bits, 1 padding bit
                                   end
                               end
                           endcase
        end
    end
endmodule