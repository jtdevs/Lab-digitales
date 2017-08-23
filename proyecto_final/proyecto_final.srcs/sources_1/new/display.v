module display(
input reloj,
input [31:0] resultado,
output reg [3:0] numero,
output reg [7:0] anodos
    );
    
reg [3:0] counter;

always@(posedge reloj)
        begin
            counter <= counter+4'b1;
        end

 always@(*)
           begin
               case (counter) 
                       4'd0 :    begin
                                   anodos[7:0] = 8'b11111110;
                                   numero = resultado[3:0];
                               end
                       4'd1 :     begin
                                   anodos[7:0] = 8'b11111101;
                                   numero = resultado[7:4];
                               end
                               
                      4'd2 :    begin
                                                                  anodos[7:0] = 8'b11111011;
                                                                  numero = resultado[11:8];
                                                              end
                                                      4'd3 :    begin
                                                                  anodos[7:0] = 8'b11110111;
                                                                  numero = resultado[15:12];
                                                              end
                                                      4'd4 :    begin
                                                                  anodos[7:0] = 8'b11101111;
                                                                  numero = resultado[19:16];
                                                              end
                                                      4'd5 :    begin
                                                                  anodos[7:0] = 8'b11011111;
                                                                  numero = resultado[23:20];
                                                              end
                                                      4'd6 :    begin
                                                                  anodos[7:0] = 8'b10111111;
                                                                  numero = resultado[27:24];
                                                              end
                                                      4'd7 :    begin
                                                                  anodos[7:0] = 8'b01111111;
                                                                  numero = resultado[31:28];
                                                              end
                       default :   begin
                                       anodos[7:0] = 8'b11111111;
                                       numero = 4'd0;
                                   end
               endcase
           end
endmodule
