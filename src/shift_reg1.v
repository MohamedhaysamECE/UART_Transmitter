module shift_reg1(
 input [11:0]frame_out,
 input stop_bits,data_length,
 input baud_out, send, rst,
 input [1:0] parity_type,
 output reg data_out,
 output reg p_parity_out,
 output reg tx_active,tx_done
    );
 
  localparam idle = 1'b1;
  //parallel input serial output register
 reg [3:0] count = 4'b0000;
 reg [11:0] temb;
 always@(posedge baud_out, posedge rst)
  begin
   if(rst)
    begin
	 count <= 4'b0000;
    end
   else begin
     if(count == 4'b1100 || send == 1'b0)
       count <= 4'b0000;
     else
       count <= count+1;
	end
  end
 always@(posedge baud_out)
  begin
     if(send == 1'b1)
      begin
      temb[0]  <= temb[1];
      temb[1]  <= temb[2];
      temb[2]  <= temb[3];
      temb[3]  <= temb[4];
      temb[4]  <= temb[5];
      temb[5]  <= temb[6];
      temb[6]  <= temb[7];
      temb[7]  <= temb[8];
      temb[8]  <= temb[9];
      temb[9]  <= temb[10];
      temb[10] <= temb[11];
      end
     else
      begin
      temb[0] <= frame_out[0];
      temb[1] <= frame_out[1];
      temb[2] <= frame_out[2];
      temb[3] <= frame_out[3];
      temb[4] <= frame_out[4];
      temb[5] <= frame_out[5];
      temb[6] <= frame_out[6];
      temb[7] <= frame_out[7];
      temb[8] <= frame_out[8];
      temb[9] <= frame_out[9];
      temb[10] <= frame_out[10];
      temb[11] <= frame_out[11];
      end
     end 

  
  /* the output signals:
   p_parity_out
   tx_done
  */
  always@(*)
   begin
    if (rst == 1'b0)
    begin
    tx_done = 1'b0;
      case({data_length,stop_bits,parity_type})
         4'b0001 : begin
                    p_parity_out = frame_out[8];
                      if(count == 4'b1010)
                       begin
                        tx_done = 1'b1;
                       end
                      else
                       begin
                        tx_done = 1'b0;
                       end 
                   end
         4'b0010 : begin
                         p_parity_out = 1'b0;
                                if(count == 4'b1010)
                                 begin
                                  tx_done = 1'b1;
                                 end
                                else
                                 begin
                                  tx_done = 1'b0;
                                 end 
                    end   
         4'b0000 : begin
                        p_parity_out = 1'b0;
                                 if(count == 4'b1001)
                                  begin
                                   tx_done = 1'b1;
                                  end
                                 else
                                  begin
                                   tx_done = 1'b0;
                                  end 
                     end    
         4'b0011 : begin
                       p_parity_out = 1'b0;
                                if(count == 4'b1001)
                                    begin
                                    tx_done = 1'b1;
                                    end
                                 else
                                   begin
                                  tx_done = 1'b0;
                                  end 
                       end   
         4'b0101 : begin
                                  p_parity_out = frame_out[8];
                                    if(count == 4'b1011)
                                     begin
                                      tx_done = 1'b1;
                                     end
                                    else
                                     begin
                                      tx_done = 1'b0;
                                     end 
                                 end                                             
         4'b0110: begin
                                   p_parity_out = 1'b0;
                                    if(count == 4'b1011)
                                       begin
                                        tx_done = 1'b1;
                                        end
                                     else
                                     begin
                                      tx_done = 1'b0;
                                     end 
                   end                       
                       
         4'b0100 : begin
                                   p_parity_out = 1'b0;
                                    if(count == 4'b1010)
                                      begin
                                       tx_done = 1'b1;
                                       end
                                      else
                                       begin
                                        tx_done = 1'b0;
                                       end 
                  end  
         4'b0111 : begin
                                  p_parity_out = 1'b0;
                                   if(count == 4'b1010)
                                     begin
                                       tx_done = 1'b1;
                                     end
                                     else
                                      begin
                                       tx_done = 1'b0;
                                      end 
                           end                                          
         4'b1001 : begin
                                    p_parity_out = frame_out[9];
                                     if(count == 4'b1011)
                                       begin
                                        tx_done = 1'b1;
                                       end
                                       else
                                       begin
                                         tx_done = 1'b0;
                                       end 
                    end                          
         4'b1010 : begin
                                     p_parity_out = 1'b0;
                                       if(count == 4'b1011)
                                       begin
                                        tx_done = 1'b1;
                                       end
                                       else
                                       begin
                                        tx_done = 1'b0;
                                       end 
                    end   
         4'b1000 : begin
                                      p_parity_out = 1'b0;
                                       if(count == 4'b1010)
                                       begin
                                       tx_done = 1'b1;
                                       end
                                       else
                                       begin
                                       tx_done = 1'b0;
                                       end 
                   end   
         4'b1011 : begin
                                       p_parity_out = 1'b0;
                                        if(count == 4'b1010)
                                         begin
                                          tx_done = 1'b1;
                                         end
                                         else
                                         begin
                                          tx_done = 1'b0;
                                         end 
                   end   
          4'b1101 : begin
                                        p_parity_out = frame_out[9];
                                         if(count == 4'b1100)
                                          begin
                                          tx_done = 1'b1;
                                          end
                                          else
                                          begin
                                          tx_done = 1'b0;
                                          end 
                    end   
          4'b1110 : begin
                                         p_parity_out = 1'b0;
                                          if(count == 4'b1100)
                                            begin
                                             tx_done = 1'b1;
                                            end
                                          else
                                            begin
                                             tx_done <= 1'b0;
                                            end 
                    end                
          4'b1100 : begin
                                          p_parity_out = 1'b0;
                                            if(count == 4'b1100)
                                              begin
                                                tx_done = 1'b1;
                                               end
                                              else
                                               begin
                                                tx_done = 1'b0;
                                               end 
                    end       
         4'b1111 : begin
                                            p_parity_out = 1'b0;
                                             if(count == 4'b1011)
                                                begin
                                                 tx_done = 1'b1;
                                                end
                                                else
                                                begin
                                                 tx_done = 1'b0;
                                                end 
                   end                                                                                                                                                                                                                                                                                                                                           
         default :begin
                     p_parity_out = 1'b0;
                     tx_done = 1'b0;
                  end 
       endcase
     end
   else
     begin 
      p_parity_out = 1'b0;
      tx_done = 1'b0;
      //data_out = 1'b0;
     end
   end

   
//output signal tx_active 
always@(*)
 begin
  if(rst == 0)
   begin
    if(send == 1'b1 && tx_done == 1'b0)
     tx_active = 1'b1;
    else
     tx_active =1'b0;  
   end
  else 
   tx_active = 1'b0; 
 end
 
 //output signal data_out
 always@(posedge baud_out, posedge rst)
  begin
   if(rst)
    begin
     data_out = 1'b0;
	 end
   else begin
     if( tx_done == 1'b1 || send == 1'b0)
      data_out = idle;
     else
      data_out = temb[0];  
    end
  end
endmodule
