module salida(
input CLK100MHZ,
input PS2_CLK,
input PS2_DATA,
input CPU_RESETN,
output coordy,
output enter
    );

wire [2:0] data_type;
wire [7:0] dato;
wire [4:0] valor;
wire [2:0] control;
wire kbs_tot;

    kbd_ms kbd_ms_inst(
        .clk(CLK100MHZ),
        .rst(!CPU_RESETN),
        .kd(PS2_DATA),
        .kc(PS2_CLK),
        .new_data(dato),
        .data_type(data_type),
        .kbs_tot(kbs_tot),
        .parity_error()
    );
    
    lab6_prev_2 lab6_prev_2_inst(
        .ps2_data(dato),
        .val(valor),
        .control(control)
    );   
    
    cursor cursor_inst(
        .val(valor),
        .control(control),
        .data_type(data_type),
        .kbs_tot(kbs_tot),
        .reset(!CPU_RESETN),
        .clk(CLK100MHZ),
        .coord_y(coordy),
        .enter(enter)
    );
    
endmodule

module cursor(
    input [4:0] val,
    input [2:0] control,
    input [2:0] data_type,
    input kbs_tot,
    input reset,
    input clk,
    output reg coord_y,
    output reg enter
);
    
reg coord_ynext;
reg enter_next;

    always@(posedge clk) begin
        if(reset)
        begin
            coord_y <= 1'b0;
            enter <= 1'b0;
        end
        else
        begin
            coord_y <= coord_ynext;
            enter <= enter_next;
        end
    end
    
    always@(*)
    begin
        coord_ynext = coord_y;
        enter_next = enter;
        //meti los cambios que sugirio el busta, con un pequenno detalle
        //se tiene que considerar el break code para especial y normal, no cacho por que pero
        //si no no funciona, estuve como una hora pegado con eso xdd
        if(control==3'd3 & (data_type == 3'b100 | data_type == 3'b011) & kbs_tot == 1'b1)
        begin
            case(val)
                5'd17: enter_next = 1'b0;
                5'd19: coord_ynext = (coord_y == 1'b1) ? 1'b0 : 1'b1;
                5'd20: coord_ynext = (coord_y == 1'b0) ? 1'b1 : 1'b0;
            endcase
        end
        //ademas annadi esto para que me avise cuando hay un enter, con una duracion de 1 clk
        else if(control == 3'd2 & (data_type == 3'b100 | data_type == 3'b011) & kbs_tot == 1'b1)
            enter_next = 1'b1;
    end
endmodule