module salida(
input CLK100MHZ,
input PS2_CLK,
input PS2_DATA,
input CPU_RESETN,
output [2:0] coordx,
output [1:0] coordy,
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
        .coord_x(coordx),
        .coord_y(coordy),
        .enter(enter)
    );
    
endmodule
