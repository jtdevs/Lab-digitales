module memoria(
    input clk100mhz, // clockero de 100mhz
    input SW0,
    input [7:0] nota,
    output wire [7:0] salida
);

  
wire quincemil;
wire veinte;
reg [8:0] grabar;
reg [8:0] leer;
reg [8:0] counter;

clock_divider #(.constantNumber(3000)) clk_15_inst (.clk(clk100mhz), .rst(1'b0), .clk_div(quincemil));
clock_divider #(.constantNumber(2000000)) clk_20_inst (.clk(clk100mhz), .rst(1'b0), .clk_div(veinte));

always@(posedge veinte) begin
    if(SW0) begin
    grabar <= grabar+9'd1;
    leer <= 9'd0;
    end
    else begin
    grabar <= 9'd0;
    leer <= leer+9'd1;
    end 
end

always@(*) begin
    case(SW0)
    1'b0: counter = leer;
    1'b1: counter = grabar;
    endcase 
end

dist_mem_gen_0 dist_mem_gen_0_inst(
    .clk(quincemil), // 10000 a 20000 HZ
    .a(counter), // direcciones de la memoria Aca poner un contador, para que vaya tomando las direcciones en donde se guarada el dato
    .d(nota), // dato de entrada: nota
    .we(SW0), // modo lectura o modo escritura (0 lect, 1 escr)
    .spo(salida) // salida
);



endmodule