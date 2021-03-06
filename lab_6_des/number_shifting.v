//este modulo es un wrapper, instancia otros modulos que estan descritos mas abajo
//lo que hace es armar el numero que se muestra en el visor de la calc
//le pasa las coordenadas del cuadro que esta en rojo en este momento al modulo decode_value
//y ese modulo devuelve el numero o letra correspondiente al recuadro
//con ese numero, cuando se apriete enter se va a correr todos los digitos un espacio a la 
//izq para insertar este a la derecha
//las salidas exe y ce tienen un pulso de duracion
module input_handler(
    input CLK82MHZ,
    input [2:0] x,
    input [1:0] y,
    input enter,
    input ext_ce,
    output ce,
    output exe,
    output [2:0]op,
    output [39:0] mostrar
);
    assign ce = ((x==3'd5)&(y==2'd2)&(enter));
    assign exe = ((x==3'd4)&(y==2'd3)&(enter));
    wire [3:0] num;
    decode_value val_1(.x(x),.y(y),.value(num));
    number_shifting shift_1(
        .clk(CLK82MHZ),
        .shift(enter&(x<=3'd3)&(y<=2'd3)), //que solo ingrese el digito si esta dentro de los cuadros que corresponden a digitos
        .num(num),
        .mostrar(mostrar), 
        .reset(ce|ext_ce)//que se resetee tanto si selecciono ce en la interfaz o si la calc lo requiere
    );
    decode_op op_1(.x(x), .y(y), .op(op));
endmodule

//devuelve el valor del numero o letra(hex) en la casilla en que se encuentra el cursor
//lo devuelve SIEMPRE, no solo cuando se aprieta enter, ojo con eso
module decode_value(
    input [2:0] x,
    input [1:0] y,
    output reg [3:0] value
);
    wire [4:0] coord;
    assign coord = {x,y};
    always@(*)
    begin
        case(coord)
            5'b00000: value = 4'd0;
            5'b00100: value = 4'd1;
            5'b01000: value = 4'd2;
            5'b01100: value = 4'd3;
            5'b00001: value = 4'd4;
            5'b00101: value = 4'd5;
            5'b01001: value = 4'd6;
            5'b01101: value = 4'd7;
            5'b00010: value = 4'd8;
            5'b00110: value = 4'd9;
            5'b01010: value = 4'd10;
            5'b01110: value = 4'd11;
            5'b00011: value = 4'd12;
            5'b00111: value = 4'd13;
            5'b01011: value = 4'd14;
            5'b01111: value = 4'd15;
            default: value = 4'd0;
        endcase
    end
endmodule

//devuelve el valor de la operacion en la casilla en que se encuentra el cursor
//lo devuelve SIEMPRE, no solo cuando se aprieta enter, ojo con eso
module decode_op(
    input [2:0] x,
    input [1:0] y,
    output reg [2:0] op
);
    wire [4:0] coord;
    assign coord = {x,y};
    always@(*)
    begin
        case(coord)
            5'b10000: op = 3'd1;//+
            5'b10100: op = 3'd2;//-
            5'b10001: op = 3'd3;//*
            5'b10010: op = 3'd4;//&
            5'b10101: op = 3'd5;//|
            default: op = 3'd0;//devuelve 0 si no es una operacion
        endcase
    end
endmodule

module number_shifting(
    input clk,
    input shift,
    input [3:0] num,
    input reset,
    output [39:0] mostrar
    );
    
    reg [3:0] digit0,digit1,digit2,digit3,digit4,digit5,digit6,digit7,digit8,digit9;
    reg [3:0] digit0_next,digit1_next,digit2_next,digit3_next,digit4_next,digit5_next,digit6_next,digit7_next,digit8_next,digit9_next;

    always@(posedge clk)
    begin
        if(reset)
                {digit9,digit8,digit7,digit6,digit5,digit4,digit3,digit2,digit1,digit0} = 40'd0;
        else
        begin
            digit0 <= digit0_next;
            digit1 <= digit1_next;
            digit2 <= digit2_next;
            digit3 <= digit3_next;
            digit4 <= digit4_next;
            digit5 <= digit5_next;
            digit6 <= digit6_next;
            digit7 <= digit7_next;
            digit8 <= digit8_next;
            digit9 <= digit9_next;
        end
    end
    
    always@(*)
    begin
        if(shift)
        begin
            digit9_next = digit8;
            digit8_next = digit7;
            digit7_next = digit6;
            digit6_next = digit5;
            digit5_next = digit4;
            digit4_next = digit3;
            digit3_next = digit2;
            digit2_next = digit1;
            digit1_next = digit0;
            digit0_next = num;
        end
        else
        begin
            digit9_next = digit9;
            digit8_next = digit8;
            digit7_next = digit7;
            digit6_next = digit6;
            digit5_next = digit5;
            digit4_next = digit4;
            digit3_next = digit3;
            digit2_next = digit2;
            digit1_next = digit1;
            digit0_next = digit0;
        end
    end
    
    assign mostrar = {digit9,digit8,digit7,digit6,digit5,digit4,digit3,digit2,digit1,digit0};
    
endmodule

//esta weaita genuina transforma un numero de 40 bits (10 digitos de 4 bits) en una cadena de 10 codigos
//de 8 bits que corresponden a cada digito del visor
module num2line(
    input [39:0]num,
    output [79:0]line
    );
    wire [7:0] pix0,pix1,pix2,pix3,pix4,pix5,pix6,pix7,pix8,pix9;
    num2pix dig0(num[3:0],pix0);
    num2pix dig1(num[7:4],pix1);
    num2pix dig2(num[11:8],pix2);
    num2pix dig3(num[15:12],pix3);
    num2pix dig4(num[19:16],pix4);
    num2pix dig5(num[23:20],pix5);
    num2pix dig6(num[27:24],pix6);
    num2pix dig7(num[31:28],pix7);
    num2pix dig8(num[35:32],pix8);
    num2pix dig9(num[39:36],pix9);
    assign line = {pix9,pix8,pix7,pix6,pix5,pix4,pix3,pix2,pix1,pix0};
endmodule
//esta weaita mapea cada numero en su representacion en caracter (incluso las letras hex)
module num2pix(
    input [3:0] num,
    output reg [7:0] pix
);
    always@(*)
    begin
        case(num)
            4'd0: pix = "0";
            4'd1: pix = "1";
            4'd2: pix = "2";
            4'd3: pix = "3";
            4'd4: pix = "4";
            4'd5: pix = "5";
            4'd6: pix = "6";
            4'd7: pix = "7";
            4'd8: pix = "8";
            4'd9: pix = "9";
            4'd10: pix = "a";
            4'd11: pix = "b";
            4'd12: pix = "c";
            4'd13: pix = "d";
            4'd14: pix = "e";
            4'd15: pix = "f";
        endcase
    end
endmodule