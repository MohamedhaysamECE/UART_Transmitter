module parity_gen1(
        input wire rst,
        input wire [7:0] data_in,
        input wire [1:0] parity_type, // 2-bit for different parity types
        output reg parity_out
    );
    
        always @(*) begin
            if (rst) begin
                parity_out = 0;
            end else begin
                case (parity_type)
                    2'b00: parity_out = 1'b0; // No parity
                    2'b01: parity_out = ~^data_in; // odd parity
                    2'b10: parity_out = ^data_in; // even parity
                    2'b11: parity_out = 1'b0; // no parity
                    default: parity_out = 1'b0; // Reserved (or no parity)
                endcase
            end
        end
    endmodule
