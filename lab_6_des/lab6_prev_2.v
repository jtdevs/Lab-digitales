module lab6_prev_2(
input [7:0] ps2_data,
output reg [4:0] val,
output reg [2:0] control
);

always@ (*) begin
case(ps2_data)
8'h45: begin
	val = 5'd0;
	control = 3'd1; end
8'h16: begin
	val = 5'd1;
	control = 3'd1; end
8'h1E: begin
	val = 5'd2;
	control = 3'd1; end
8'h26: begin
	val = 5'd3;
	control = 3'd1; end
8'h25: begin
	val = 5'd4;
	control = 3'd1; end
8'h2E: begin
	val = 5'd5;
	control = 3'd1; end
8'h36: begin
	val = 5'd6;
	control = 3'd1; end
8'h3D: begin
	val = 5'd7;
	control = 3'd1; end
8'h3E: begin
	val = 5'd8;
	control = 3'd1; end
8'h46: begin
	val = 5'd9;
	control = 3'd1; end
8'h1C: begin 
	val = 5'd10;
	control = 3'd1; end
8'h32: begin
	val = 5'd11;
	control = 3'd1; end
8'h21: begin
	val = 5'd12;
	control = 3'd1; end
8'h23: begin
	val = 5'd13;
	control = 3'd1; end
8'h24: begin
	val = 5'd14;
	control = 3'd1; end
8'h2B: begin
	val = 5'd15;
	control = 3'd1; end
8'h5A: begin
	val = 5'd16;
	control = 3'd2; end
8'h6B: begin
	val = 5'd17;
	control = 3'd3; end
8'h74: begin
	val = 5'd18;
	control = 3'd3; end
8'h75: begin
	val = 5'd19;
	control = 3'd3; end
8'h72: begin
	val = 5'd20;
	control = 3'd3; end
8'h79: begin
	val = 5'd21;
	control = 3'd4; end
8'h7B: begin
	val = 5'd22;
	control = 3'd4; end
8'h7C: begin
	val = 5'd23;
	control = 3'd4; end
8'h35: begin
	val = 5'd24;
	control = 3'd4; end
8'h44: begin
	val = 5'd25;
	control = 3'd4; end
default: begin
	val = 5'd0;
	control = 3'd5; end
endcase end
endmodule