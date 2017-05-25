module pwm(
    input CLK100MHZ,               // ingreso el reloj principal 
    input duty,                    // me indicara si quiero ciclo de trabajo de 5% (0) o de 20% (1)
    output reg signal
    );
    reg [31:0] count;
    wire [31:0]count_next;            // hacemos un contador que recorra los ciclos de trabajo y se reinicie tantas veces sea necesario
    
    assign count_next=(count < 32'd100000-32'd1)?count + 'd1: 'd0;
    always@(posedge CLK100MHZ)   
        count <= count_next;
    
    
    reg CLK_5;                  //estos seran los dos estados que me indicaran que ciclo de trabajo quiero usar
    reg CLK_20;
    
    always@(*) begin              //entones cuando la frecuencia sea menor a 5000, el CLK_5 estara encendido
        if (count < 32'd5000)    //lo mismo pasa con la frecuencia de 20000
            CLK_5 = 1'b1;
        else 
            CLK_5 = 1'b0;
    end

    always@(*) begin
        if (count < 32'd20000)
            CLK_20 = 1'b1;
        else 
            CLK_20 = 1'b0;
    end
    
    always@(*) begin               //entonces si duty es 0, la señal sera CLK_5 que esta dependera de CLK100MHZ
        if (duty == 1'b0)
            signal = CLK_5;
        else
            signal = CLK_20;
   end 
            
    
    
    
endmodule
