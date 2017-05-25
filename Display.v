module display(
    input clk_100mhz,
	input [31:0] num, //numero a mostrar en hex
	input [7:0] puntos, //indica si hay que encender o no el punto asociado al display
	input enc,
	output [7:0] segmentos, //7 segmentos y el punto
	output reg [7:0] anodos
	);

    wire clk_display;
	wire [6:0] _seg;
	wire [31:0] _bcd;
	reg [31:0] _mostrar;
	reg [3:0] counter;
	reg [3:0] digit;

    assign segmentos = {_seg,puntos[counter]};
    
	always@(posedge clk_display)
    begin
        counter <= counter+4'b1;
    end
    always@(*)
    begin
        case(enc)
            1'b0: _mostrar = _bcd;
            1'b1: _mostrar = num;
        endcase
    end
    
    always@(*)
	begin
		case (counter) 
                4'd0 :	begin
							anodos[7:0] = 8'b11111110;
							digit = _mostrar[3:0];
						end
                4'd1 : 	begin
							anodos[7:0] = 8'b11111101;
							digit = _mostrar[7:4];
						end
                4'd2 :	begin
							anodos[7:0] = 8'b11111011;
							digit = _mostrar[11:8];
						end
                4'd3 :	begin
							anodos[7:0] = 8'b11110111;
							digit = _mostrar[15:12];
						end
                4'd4 :	begin
							anodos[7:0] = 8'b11101111;
							digit = _mostrar[19:16];
						end
                4'd5 :	begin
							anodos[7:0] = 8'b11011111;
							digit = _mostrar[23:20];
						end
                4'd6 :	begin
							anodos[7:0] = 8'b10111111;
							digit = _mostrar[27:24];
						end
                4'd7 :	begin
							anodos[7:0] = 8'b01111111;
							digit = _mostrar[31:28];
						end
                default :   begin
                                anodos[7:0] = 8'b11111111;
                                digit = 4'd0;
                            end
        endcase
	end
	
	clock_divider #(.CONSTANT(10_000))
    clock_divider_inst(
        .clk_in(clk_100mhz),
        .rst(1'd0),
        .clk_out(clk_display)
    );
	
	decoder_7_seg decoder_7_seg_inst (
        .N (digit),
        .SEG (_seg)
    );

    double_dabble dd_inst(
        .clk(clk_100mhz),            // Reloj
        .trigger(1'b1),        // Inicio de conversión
        .in(num),      // Número binario de entrada
        .idle(),      // Si vale 0, indica una conversión en proceso
        .bcd(_bcd) // Resultado de la conversión
    );
endmodule

