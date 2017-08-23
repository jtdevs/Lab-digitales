module mostrar(
input [3:0] teclita,
input [2:0] octava,
output reg [31:0] resultado
    );
    
always@ (*) begin
case(teclita)
4'd1: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd13, 4'd0, 4'd9};
4'd2: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd6, 4'd14, 4'd11};
4'd3: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd6, 4'd14, 4'd9};
4'd4: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd8, 4'd1, 4'd11};
4'd5: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd8, 4'd1, 4'd9};
4'd6: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd15, 4'd10, 4'd9};
4'd7: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd5, 4'd0, 4'd7, 4'd11};
4'd8: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd5, 4'd0, 4'd7, 4'd9};
4'd9: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd7, 4'd10, 4'd11};
4'd10: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd7, 4'd10, 4'd9};
4'd11: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd5, 4'd1, 4'd11};
4'd12: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd5, 4'd1, 4'd9};
4'd13: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd13, 4'd0, 4'd9};
default: resultado = {1'b0, octava, 4'd14, 4'd5, 4'd12, 4'd9, 4'd9, 4'd9, 4'd9};
endcase end

endmodule
