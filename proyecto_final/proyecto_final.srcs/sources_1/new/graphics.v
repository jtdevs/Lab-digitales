module graphics(
    input CLK100MHZ,
    input [3:0] tecla,
    input [2:0] escala,
    input option,
    input selected,
    input graban2,
    output [3:0]VGA_R,
    output [3:0]VGA_G,
    output [3:0]VGA_B,
    output VGA_HS,
    output VGA_VS
    );
    wire [11:0] menu_color, piano_color;
    wire CLK25MHZ;
    wire [9:0] hc_visible, vc_visible;
    clock_divider #(.constantNumber(2)) slow_clk_inst (.clk(CLK100MHZ), .rst(1'b0), .clk_div(CLK25MHZ));
    driver_vga m_driver(CLK25MHZ, VGA_HS, VGA_VS, hc_visible, vc_visible);
    menu menu_inst(CLK25MHZ,hc_visible,vc_visible,option,menu_color);
    pianito pianito_inst(CLK25MHZ,tecla,escala,graban2,vc_visible,hc_visible, piano_color);
    assign {VGA_R,VGA_G,VGA_B} = (!selected)?menu_color:piano_color;
endmodule
