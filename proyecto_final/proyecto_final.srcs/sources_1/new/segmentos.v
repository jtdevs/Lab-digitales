module segmentos(
input [3:0] numero,
output reg [6:0] seg
    );
always @(*) begin
    case(numero)
    4'd0: seg = 7'b0000001;
    4'd1: seg = 7'b1001111;
    4'd2: seg = 7'b0010010;
    4'd3: seg = 7'b0000110;
    4'd4: seg = 7'b1001100;
    4'd5: seg = 7'b0100100;
    4'd6: seg = 7'b1111010;
    4'd7: seg = 7'b1110001;
    4'd8: seg = 7'b0001001;
    4'd9: seg = 7'b1111111;
    4'd10: seg = 7'b0001000;
    4'd11: seg = 7'b1100000;
    4'd12: seg = 7'b0110001;
    4'd13: seg = 7'b1000010;
    4'd14: seg = 7'b0110000;
    4'd15: seg = 7'b0111000;
    default: seg = 7'b1111111;
    endcase
    end
endmodule
