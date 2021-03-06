module elo211(
   input [3:0] D,
   output reg [7:0] SEG
   );

always @(*) 
begin
	case(D)
        4'd0: SEG <= 8'b01100001;
        4'd1: SEG <= 8'b11100011; 
        4'd2: SEG <= 8'b00000011;
        4'd3: SEG <= 8'b00100101;
        4'd4: SEG <= 8'b10011111;
        4'd5: SEG <= 8'b00100101;
        default: SEG <= 8'b11111111;
	endcase
end

endmodule
