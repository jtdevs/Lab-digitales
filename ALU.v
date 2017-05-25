module ALU #(parameter size = 16)(
    input clk,
    input [size-1:0] A,
    input [size-1:0] B,
	input [3:0] control,
    output reg [size-1:0] res,
	output reg [3:0] flags,
	output [2:0] rgb
    );
    wire r,g,b;
    assign rgb = {r,g,b};
    reg [2:0] duty; //control del ciclo del PWM
    always @(*)
    begin
		flags = 4'd0;
		case(control)
			4'b1000:
			begin
			     res = A + B;
			     duty = 3'b000;
			     if((A+B)>{(size){1'd1}})
			         flags = flags | 4'b0010;
			end
			4'b0100:
			begin
			     duty = 3'b001;
			     if(B > A)
			         begin
                          res = B - A;
						  flags = flags | 4'b1010;
					 end
				 else
				     begin
						  res = A - B;
					 end
			end
			4'b0010:
			begin
			     res = A * B;
			     duty = 3'b010;
			end
			4'b0001:
			begin
                 res = A & B;
                 duty = 3'b011;
            end
			4'b1100:
			begin
                 res = A | B;
                 duty = 3'b100;
            end
			default:
			begin
			     res = {(size){1'd0}};
			     duty = 3'b111;
			end
		endcase
		if(res == {(size){1'd0}})
			flags = flags | 4'b0100;
    end
    
    pwm red(
        .CLK100MHZ(clk),
        .duty(duty[2]),
        .signal(r)
    );
    
    pwm green(
        .CLK100MHZ(clk),
        .duty(duty[1]),
        .signal(g)
    );
    
    pwm blue(
        .CLK100MHZ(clk),
        .duty(duty[0]),
        .signal(b)
    );
endmodule
