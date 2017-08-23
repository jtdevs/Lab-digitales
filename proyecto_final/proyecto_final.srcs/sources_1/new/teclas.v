module teclas #(parameter pos_x = 20, pos_y = 100, width = 75, height = 250)(
    input [9:0] hc,
    input [9:0] vc,
    output lines,
    output inside);
    reg vert_l, vert_r, hor_up, hor_dwn, hor, vert, in_hor, in_vert;
    
    always @ (*)
    begin
        hor_up = (vc >= pos_y - 10'd1) && (vc <= pos_y + 10'd1);
        hor_dwn = (vc >= pos_y - 10'd1 + height) && (vc <= pos_y + 10'd1 + height);
        hor = (hc >= pos_x - 10'd1) && (hc <= pos_x + 10'd1 + width);
        vert_l = (hc >= pos_x - 10'd1) && (hc <= pos_x + 10'd1);
        vert_r = (hc >= pos_x - 10'd1 + width) && (hc <= pos_x + 10'd1 + width);
        vert = (vc >= pos_y - 10'd1) && (vc <= pos_y + 10'd1 + height);
        in_hor = (hc > pos_x + 10'd1) && (hc < pos_x - 10'd1 + width);
        in_vert = (vc >= pos_y + 10'd1) && (vc <= pos_y -10'd1 + height);
    end
    
    assign lines = ((hor_up || hor_dwn) && hor) || ((vert_l || vert_r) && vert);
    assign inside = in_hor && in_vert;
endmodule