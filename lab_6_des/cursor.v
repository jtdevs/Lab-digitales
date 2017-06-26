module cursor(
    input [4:0] val,
    input [2:0] control,
    input [2:0] data_type,
    input kbs_tot,
    input reset,
    input clk,
    output reg [2:0] coord_x,
    output reg [1:0] coord_y,
    output reg enter
);
    
reg [2:0] coord_xnext;
reg [1:0] coord_ynext;
reg enter_next;

    always@(posedge clk) begin
        if(reset)
        begin
            coord_x <= 3'd5;
            coord_y <= 2'd3;
            enter <= 1'b0;
        end
        else
        begin
            coord_x <= coord_xnext;
            coord_y <= coord_ynext;
            enter <= enter_next;
        end
    end
    
    always@(*)
    begin
        coord_xnext = coord_x;
        coord_ynext = coord_y;
        enter_next = 1'b0;
        //meti los cambios que sugirio el busta, con un pequenno detalle
        //se tiene que considerar el break code para especial y normal, no cacho por que pero
        //si no no funciona, estuve como una hora pegado con eso xdd
        if(control==3'd3 & (data_type == 3'b100 | data_type == 3'b011) & kbs_tot == 1'b1)
        begin
            case(val)
                5'd17: coord_xnext = (coord_x == 3'd0) ? 3'd5 : coord_x-3'd1;
                5'd18: coord_xnext = (coord_x == 3'd5) ? 3'd0 : coord_x+3'd1;
                5'd19: coord_ynext = (coord_y == 2'd0) ? 2'd3 : coord_y-2'd1;
                5'd20: coord_ynext = (coord_y == 2'd3) ? 2'd0 : coord_y+2'd1;
            endcase
        end
        //ademas annadi esto para que me avise cuando hay un enter, con una duracion de 1 clk
        else if(control == 3'd2 & (data_type == 3'b100 | data_type == 3'b011) & kbs_tot == 1'b1)
            enter_next = 1'b1;
    end
endmodule