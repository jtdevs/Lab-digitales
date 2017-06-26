module lab_6(
	input CLK100MHZ,
	input PS2_CLK,
	input PS2_DATA,
	input CPU_RESETN,
	output VGA_HS,
	output VGA_VS,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B
	);

	localparam CUADRILLA_XI = 		212;
	localparam CUADRILLA_XF = 		812;
	localparam CUADRILLA_YI = 		184;
	localparam CUADRILLA_YF = 		584;

	wire [10:0]vc_visible,hc_visible;
	wire CLK82MHZ;
	wire [2:0] x;
    wire [1:0] y;
    wire [10:0]hc_template, vc_template;
    wire [2:0]matrix_x;
    wire [1:0]matrix_y;
    wire lines;
    wire enter, dr, drf;
    wire [39:0] mostrar;
    wire [79:0] converted_line;
    
    reg [11:0]VGA_COLOR;

	clk_wiz_0 inst( .clk_out1(CLK82MHZ), .reset(1'b0), .locked(), .clk_in1(CLK100MHZ) );
	driver_vga_1024x768 m_driver(CLK82MHZ, VGA_HS, VGA_VS, hc_visible, vc_visible);
	template_6x4_600x400 template_1(CLK82MHZ, hc_visible, vc_visible, matrix_x, matrix_y, lines);
    salida salida_inst( .CLK100MHZ(CLK82MHZ), .PS2_CLK(PS2_CLK), .PS2_DATA(PS2_DATA), .CPU_RESETN(CPU_RESETN), .coordx(x), .coordy(y), .enter(enter) );
    disp_pix pixinst(.CLK82MHZ(CLK82MHZ), .hc_visible(hc_visible), .vc_visible(vc_visible), .mostrar(converted_line), .dr(dr));
    input_handler handler(.x(x), .y(y), .enter(enter), .mostrar(mostrar));
    num2line converter_inst(.num(mostrar), .line(converted_line));
    flags flags_inst(.CLK82MHZ(CLK82MHZ), .hc_visible(hc_visible), .vc_visible(vc_visible), .flags(4'b1011), .drf(drf));
    
    assign {VGA_R, VGA_G, VGA_B} = VGA_COLOR;
    
	always@(*)
	begin
		if((hc_visible != 0) && (vc_visible != 0))
		begin
			if(dr)
				VGA_COLOR = 12'h000;
			else if(drf)
			    VGA_COLOR = 12'h0FF;
			else if((vc_visible == 174)&&((hc_visible > CUADRILLA_XI) && (hc_visible < CUADRILLA_XI+400)))
                VGA_COLOR = 12'd0;
            else if((vc_visible == 74)&&((hc_visible > CUADRILLA_XI) && (hc_visible < CUADRILLA_XI+400)))
                VGA_COLOR = 12'd0;
            else if((hc_visible == CUADRILLA_XI)&&((vc_visible > 74) && (vc_visible < 174)))
                VGA_COLOR = 12'd0;
            else if((hc_visible == CUADRILLA_XI+400)&&((vc_visible > 74) && (vc_visible < 174)))
                VGA_COLOR = 12'd0;
			else if((hc_visible > CUADRILLA_XI) && (hc_visible <= CUADRILLA_XF) && (vc_visible > CUADRILLA_YI) && (vc_visible <= CUADRILLA_YF))
				if(lines)
					VGA_COLOR = 12'h000;
				else if((x == matrix_x) && (y == matrix_y))
				    VGA_COLOR = 12'hF00;
				else
					VGA_COLOR = 12'hFFF;
			else
				VGA_COLOR = 12'hFFF;
		end
		else
			VGA_COLOR = 12'd0;
	end
endmodule
