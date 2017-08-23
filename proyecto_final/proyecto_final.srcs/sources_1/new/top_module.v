module top_module(
    input CLK100MHZ,
    input SW0,
    input CPU_RESETN,
    input PS2_DATA,
    input PS2_CLK,
    output AUD_PWM,
    output AUD_SD,
    output [7:0] AN,
    output CA, CB, CC, CD, CE, CF, CG,
    output [3:0]VGA_R,
    output [3:0]VGA_G,
    output [3:0]VGA_B,
    output VGA_HS,
    output VGA_VS
    );
assign AUD_SD = 1'b1;

wire [7:0] notatotal;
wire [7:0] played_note;
wire [2:0] pulso;
wire [7:0] dato;
wire [3:0] teclita;
wire [2:0] octava; 
wire [31:0] res;
wire [3:0] num;
wire clocki;

reg [7:0] nota_vgn;
reg [3:0] teclita_display;
reg [2:0] octava_display;
wire [3:0] nota_entrada;
wire [2:0] nro_octava;
wire option, selected;
always @(*) begin
    case(option && selected)
        1'b1: if(SW0==1'b0) begin
              nota_vgn = played_note;
              teclita_display = nota_entrada; 
              octava_display = nro_octava;
              end
              else begin
              nota_vgn = notatotal;
              teclita_display = teclita;
              octava_display = octava; end
        1'b0: begin
              nota_vgn = (selected)?notatotal:8'd0;
              teclita_display = (selected)?teclita:4'd0;
              octava_display = (selected)?octava:4'd0;
              end
    endcase
end

salida salidita(CLK100MHZ,PS2_CLK,PS2_DATA,CPU_RESETN,option,selected);
graphics pantalla(CLK100MHZ, teclita_display, octava_display,option, selected,SW0,VGA_R,VGA_G,VGA_B,VGA_HS,VGA_VS);

music music_inst(
    .clk(CLK100MHZ),
    .fullnote (nota_vgn),
    .speaker(AUD_PWM)
);

teclado_to_note teclado_to_note_inst (
    .nro_octava(octava), //3bits
    .nota_entrada(teclita), //4bits
    .nota_final(notatotal) //8bits
);

memoria memoria_inst(
    .clk100mhz(CLK100MHZ),
    .SW0(SW0),
    .nota(notatotal),
    .salida(played_note)
);

kbd_ms kbd_ms_inst(
        .clk(CLK100MHZ),
        .rst(!CPU_RESETN),
        .kd(PS2_DATA),
        .kc(PS2_CLK),
        .new_data(dato),
        .data_type(pulso),
        .kbs_tot(),
        .parity_error()
        );

teclado teclado_inst(
.clock(CLK100MHZ),
.rst(!CPU_RESETN),
.pulso(pulso),
.ps2_data(dato),
.teclita(teclita),
.octava(octava)
);

display display_inst(
.reloj(clocki),
.resultado(res),
.numero(num),
.anodos(AN)
);

segmentos segmentos_inst(
.numero(num),
.seg({CA, CB, CC, CD, CE, CF, CG})
);

mostrar mostrar_inst(
.teclita(teclita_display),
.octava(octava_display),
.resultado(res)
);

record_to_display record_to_display_inst(
    .nota_grabada(nota_vgn), //salida memoria
    .nro_octava(nro_octava),
    .nota_entrada(nota_entrada)
    );

clk_divider_2 #(.CONSTANT(10_000)) clk_divider_2_inst(.clk_in(CLK100MHZ),.rst(1'd0),.clk_out(clocki));
endmodule