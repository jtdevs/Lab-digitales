//cada bit de la entrada flag controla si aparece o no el texto correspondiente en pantalla
//se usa igual que los leds casi
module flags(
    input CLK82MHZ,
    input [3:0] flags,
    input [10:0]hc_visible,
    input [10:0]vc_visible,
    output drf
    );
    wire dr0,dr1,dr2,dr3;
    assign drf = ((dr0 & flags[0]) | (dr1 & flags[1]) | (dr2 & flags[2]) | (dr3 & flags[3]));
    show_one_line #(820, 186, 4, 3'd5) show_one_line_inst0(CLK82MHZ, 1'b0, hc_visible, vc_visible, {"z","e","r","o"},, dr0);
    show_one_line #(820, 242, 4, 3'd5) show_one_line_inst1(CLK82MHZ, 1'b0, hc_visible, vc_visible, {"n","g","t","v"},, dr1);
    show_one_line #(820, 298, 4, 3'd5) show_one_line_inst2(CLK82MHZ, 1'b0, hc_visible, vc_visible, {"c","r","r","y"},, dr2);
    show_one_line #(820, 354, 4, 3'd5) show_one_line_inst3(CLK82MHZ, 1'b0, hc_visible, vc_visible, {"o","f","l","w"},, dr3);
endmodule
