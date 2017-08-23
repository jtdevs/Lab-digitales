module record_to_display(
    input [7:0] nota_grabada, //salida memoria
    output reg [2:0] nro_octava,
    output reg [3:0] nota_entrada
    );
    
always @(*) begin
        case(nota_grabada) 
            8'd1: begin 
                  nro_octava=3'd1;
                  nota_entrada=4'd1;
                  end
            8'd2: begin 
                  nro_octava=3'd1;
                  nota_entrada=4'd2;
                  end
            8'd3: begin 
                  nro_octava=3'd1;
                  nota_entrada=4'd3;
                  end
            8'd4: begin 
                  nro_octava=3'd1;
                  nota_entrada=4'd4;
                  end
            8'd5: begin 
                                    nro_octava=3'd1;
                                    nota_entrada=4'd5;
                                    end
            8'd6: begin 
                                 nro_octava=3'd1;
                                 nota_entrada=4'd6;
                                 end
            8'd7: begin 
                  nro_octava=3'd1;
                  nota_entrada=4'd7;
                  end
            8'd8: begin 
                                    nro_octava=3'd1;
                                    nota_entrada=4'd8;
                                    end
            8'd9: begin 
                             nro_octava=3'd1;
                             nota_entrada=4'd9;
                               end
            8'd10: begin 
                           nro_octava=3'd1;
                           nota_entrada=4'd10;
                           end
            8'd11: begin 
                           nro_octava=3'd1;
                           nota_entrada=4'd11;
                           end
            8'd12: begin 
                           nro_octava=3'd1;
                           nota_entrada=4'd12;
                           end
            8'd13: begin 
                           nro_octava=3'd1;
                           nota_entrada=4'd13;
                           end
8'd14: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd1;
                           end
8'd15: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd2;
                           end
8'd16: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd3;
                           end
8'd17: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd4;
                           end
8'd18: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd5;
                           end
8'd19: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd6;
                           end
8'd20: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd7;
                           end
8'd21: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd8;
                           end
8'd22: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd9;
                           end
8'd23: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd10;
                           end
8'd24: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd11;
                           end
8'd25: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd12;
                           end
8'd26: begin 
                           nro_octava=3'd2;
                           nota_entrada=4'd13;
                           end
8'd27: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd1;
                           end
8'd28: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd2;
                           end
8'd29: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd3;
                           end
8'd30: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd4;
                           end
8'd31: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd5;
                           end
8'd32: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd6;
                           end
8'd33: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd7;
                           end
8'd34: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd8;
                           end
8'd35: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd9;
                           end
8'd36: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd10;
                           end
8'd37: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd11;
                           end
8'd38: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd12;
                           end
8'd39: begin 
                           nro_octava=3'd3;
                           nota_entrada=4'd13;
                           end
8'd40: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd1;
                           end
8'd41: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd2;
                           end
8'd42: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd3;
                           end
8'd43: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd4;
                           end
8'd44: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd5;
                           end
8'd45: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd6;
                           end
8'd46: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd7;
                           end
8'd47: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd8;
                           end
8'd48: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd9;
                           end
8'd49: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd10;
                           end
8'd50: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd11;
                           end
8'd51: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd12;
                           end
8'd52: begin 
                           nro_octava=3'd4;
                           nota_entrada=4'd13;
                           end
8'd53: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd1;
                           end
8'd54: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd2;
                           end
8'd55: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd3;
                           end
8'd56: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd4;
                           end
8'd57: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd5;
                           end
8'd58: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd6;
                           end
8'd59: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd7;
                           end
8'd60: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd8;
                           end
8'd61: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd9;
                           end
8'd62: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd10;
                           end
8'd63: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd11;
                           end
8'd64: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd12;
                           end
8'd65: begin 
                           nro_octava=3'd5;
                           nota_entrada=4'd13;
                           end
            default: begin
                     nro_octava=3'd1;
                     nota_entrada=4'd0;
                     end  
            endcase
   end
endmodule