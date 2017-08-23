module teclado(
input clock,
input rst,
input [2:0] pulso, //data type teclado
input [7:0] ps2_data, //kbd
output reg [3:0] teclita,
output reg [2:0] octava
);

reg [2:0] octava_next;
initial octava = 3'd1;

always@(posedge clock) begin
if(rst==1'b1)
octava <= 3'd1;
else
octava <= octava_next; end
    
always@ (*) begin
case(ps2_data)
8'h1C: begin begin if(pulso==3'd1)
             teclita = 4'd1;
             else
             teclita = 4'd0; end
       octava_next = octava; end
8'h1B: begin begin if(pulso==3'd1)
        teclita = 4'd3;
        else
                     teclita = 4'd0; end
       octava_next = octava; end
8'h23: begin begin if(pulso==3'd1)
teclita = 4'd5;
else
             teclita = 4'd0; end
       octava_next = octava; end
8'h2B: begin begin if(pulso==3'd1)
teclita = 4'd6;
else
             teclita = 4'd0; end
       octava_next = octava; end
8'h34: begin begin if(pulso==3'd1)
teclita = 4'd8;
else
             teclita = 4'd0; end
       octava_next = octava; end
8'h33: begin begin if(pulso==3'd1)
teclita = 4'd10;
else
             teclita = 4'd0; end
       octava_next = octava; end
8'h3B: begin begin if(pulso==3'd1)
teclita = 4'd12;
else
             teclita = 4'd0; end
       octava_next = octava; end
8'h42: begin begin if(pulso==3'd1)
teclita = 4'd13;
else
             teclita = 4'd0; end
       octava_next = octava; end
8'h1D: begin begin if(pulso==3'd1)
 teclita = 4'd2;
else
             teclita = 4'd0; end
       octava_next = octava; end
8'h24: begin begin if(pulso==3'd1)
teclita = 4'd4;
else
             teclita = 4'd0; end
       octava_next = octava; end
8'h2C: begin begin if(pulso==3'd1)
teclita = 4'd7;
else
             teclita = 4'd0; end
       octava_next = octava; end
8'h35: begin begin if(pulso==3'd1)
teclita = 4'd9;
else
             teclita = 4'd0; end
       octava_next = octava; end
8'h3C: begin begin if(pulso==3'd1)
teclita = 4'd11;
else
             teclita = 4'd0; end
       octava_next = octava; end
8'h16: begin teclita = 4'd0;
             octava_next = 3'd1; end
8'h1E: begin teclita = 4'd0;
             octava_next = 3'd2; end
8'h26: begin teclita = 4'd0;
             octava_next = 3'd3; end
8'h25: begin teclita = 4'd0;
             octava_next = 3'd4; end
8'h2E: begin teclita = 4'd0;
             octava_next = 3'd5; end
default: begin teclita = 4'd0; 
               octava_next = octava; end
endcase end

endmodule
