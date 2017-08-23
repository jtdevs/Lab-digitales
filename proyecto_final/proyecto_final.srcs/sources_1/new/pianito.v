module pianito(
    input CLK25MHZ,
    input [3:0] tecla,
    input [2:0] escala,
    input grabando,
    input [9:0]vc_visible, 
    input [9:0]hc_visible,
    output reg [11:0]piano_color
    );
    
    wire lines1,lines2,lines3,lines4,lines5,lines6,lines7,lines8,lines9,lines10,lines11,lines12,lines13;
    wire inside1,inside2,inside3,inside4,inside5,inside6,inside7,inside8,inside9,inside10,inside11,inside12,inside13;
    wire esc, grab;
    reg blancas, negras, blancas_in, negras_in;
    reg rojo_blanca, rojo_negra;
    always @ (*)
    begin
        blancas =lines1|lines2|lines3|lines4|lines5|lines6|lines7|lines8;
        negras = lines9|lines10|lines11|lines12|lines13;
        blancas_in = inside1|inside2|inside3|inside4|inside5|inside6|inside7|inside8;
        negras_in = inside9|inside10|inside11|inside12|inside13;
        if((hc_visible != 0) && (vc_visible != 0))
            if(grab && grabando)
                piano_color = 12'hF00;
            else if(esc)
                piano_color = 12'h000;
            else if((blancas|negras)&&!negras_in&&!blancas_in)
                piano_color = 12'h000;
            else if (rojo_blanca&!negras_in)
                piano_color = 12'hF00;
            else if (rojo_negra)
                piano_color = 12'hF00;
            else if (blancas_in&!negras_in)
                piano_color = 12'hFFF;
            else if (negras_in)
                piano_color = 12'h000;
            else
                piano_color = 12'h888;
        else
            piano_color = 12'd0;
    end
    
    always @ (*)
    begin
        rojo_blanca = 1'b0;
        rojo_negra = 1'b0;
        case(tecla)
            4'd1: begin rojo_blanca = inside1; end
            4'd2: begin rojo_negra = inside9; end
            4'd3: begin rojo_blanca = inside2; end
            4'd4: begin rojo_negra = inside10; end
            4'd5: begin rojo_blanca = inside3; end
            4'd6: begin rojo_blanca = inside4; end
            4'd7: begin rojo_negra = inside11; end
            4'd8: begin rojo_blanca = inside5; end
            4'd9: begin rojo_negra = inside12; end
            4'd10: begin rojo_blanca = inside6; end
            4'd11: begin rojo_negra = inside13; end
            4'd12: begin rojo_blanca = inside7; end
            4'd13: begin rojo_blanca = inside8; end
        endcase
    end
    
    teclas #(.pos_x(20), .pos_y(260), .width(75), .height(200)) blancas_1 (
        .hc(hc_visible), 
        .vc(vc_visible), 
        .lines(lines1),
        .inside(inside1)
    );
    
    teclas #(.pos_x(95), .pos_y(260), .width(75), .height(200)) blancas_2 (
        .hc(hc_visible), 
        .vc(vc_visible), 
        .lines(lines2),
        .inside(inside2)
    );
    
    teclas #(.pos_x(170), .pos_y(260), .width(75), .height(200)) blancas_3 (
        .hc(hc_visible), 
        .vc(vc_visible), 
        .lines(lines3),
        .inside(inside3)
    );
    
    teclas #(.pos_x(245), .pos_y(260), .width(75), .height(200)) blancas_4 (
        .hc(hc_visible), 
        .vc(vc_visible), 
        .lines(lines4),
        .inside(inside4)
    );
    teclas #(.pos_x(320), .pos_y(260), .width(75), .height(200)) blancas_5 (
        .hc(hc_visible), 
        .vc(vc_visible), 
        .lines(lines5),
        .inside(inside5)
    );
    teclas #(.pos_x(395), .pos_y(260), .width(75), .height(200)) blancas_6 (
        .hc(hc_visible), 
        .vc(vc_visible), 
        .lines(lines6),
        .inside(inside6)
    );
    teclas #(.pos_x(470), .pos_y(260), .width(75), .height(200)) blancas_7 (
        .hc(hc_visible), 
        .vc(vc_visible), 
        .lines(lines7),
        .inside(inside7)
    );
    teclas #(.pos_x(545), .pos_y(260), .width(75), .height(200)) blancas_8 (
        .hc(hc_visible), 
        .vc(vc_visible), 
        .lines(lines8),
        .inside(inside8)
    );
    teclas #(.pos_x(65), .pos_y(260), .width(60), .height(150)) negras_1 (
            .hc(hc_visible), 
            .vc(vc_visible), 
            .lines(lines9),
            .inside(inside9)
    );
    teclas #(.pos_x(140), .pos_y(260), .width(60), .height(150)) negras_2 (
            .hc(hc_visible), 
            .vc(vc_visible), 
            .lines(lines10),
            .inside(inside10)
    );
    teclas #(.pos_x(290), .pos_y(260), .width(60), .height(150)) negras_3 (
            .hc(hc_visible), 
            .vc(vc_visible), 
            .lines(lines11),
            .inside(inside11)
    );
    teclas #(.pos_x(365), .pos_y(260), .width(60), .height(150)) negras_4 (
            .hc(hc_visible), 
            .vc(vc_visible), 
            .lines(lines12),
            .inside(inside12)
    );
    teclas #(.pos_x(440), .pos_y(260), .width(60), .height(150)) negras_5 (
            .hc(hc_visible), 
            .vc(vc_visible), 
            .lines(lines13),
            .inside(inside13)
    );
    show_one_line #(11'd100,11'd100 , 8, 3'd5) graban2(CLK25MHZ, 1'b0, hc_visible, vc_visible, {8'd103,8'd114,8'd97,8'd98,8'd97,8'd110,8'd100,8'd111},, grab);
    show_one_line #(11'd100,11'd150 , 8, 3'd5) esk(CLK25MHZ, 1'b0, hc_visible, vc_visible, {8'd101,8'd115,8'd99,8'd97,8'd108,8'd97,8'd32,8'd48+escala},, esc);

endmodule
