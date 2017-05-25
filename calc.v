module top_module(
	input CLK100MHZ,
	input BTNC, BTNU, BTND, BTNL, BTNR, CPU_RESETN,
	input [15:0] SW,
	output [7:0] AN,
	output CA, CB, CC, CD, CE, CF, CG, DP,
	output LED16_R,LED16_G,LED16_B,
	output reg [15:0] LED
);
    reg [2:0] rgb_led;
    assign {LED16_R,LED16_G,LED16_B} = rgb_led;
    wire [2:0] _rgb;
    wire DBTNU, DBTND, DBTNL, DBTNR, DBTNC;//pulso de salida del debouncer
	wire [3:0] btns;//botones excepto el centro
    assign btns = {DBTNU, DBTND, DBTNL, DBTNR};

    wire encoding;//si hexa o bcd. 0->bcd
    assign encoding = DBTNL&DBTNR;
    
    //maquina de estados
	parameter ESPERANDO_OP1 = 2'd0;
	parameter ESPERANDO_OP2 = 2'd1;
	parameter ESPERANDO_OPERACION = 2'd2;
	parameter MOSTRAR_RESULTADO = 2'd3;
	reg [1:0] State, NextState;

	wire [15:0] operador1, operador2;//salida del modulo de retencion de valores (FDCE)
	wire [3:0] operacion;//salida del modulo de retencion de valores (FDCE)
	reg retain_op1, retain_op2, retain_op;//controlan la retención o no de cada valor
	
	reg [31:0] mostrar;//lo que actualmente se muestra en el display
	
	wire [15:0] resultado;//salida de la ALU
	wire [3:0] _flags;//flags de la ALU

	always @ (posedge CLK100MHZ)
	begin
	    if(!CPU_RESETN)
            State <= ESPERANDO_OP1;
	    else 
            State <= NextState;
    end

	always @ (*)
	begin
	    NextState = ESPERANDO_OP1;
		case(State)
			ESPERANDO_OP1:
				begin
					NextState = (DBTNC==1'b1)?ESPERANDO_OP2:ESPERANDO_OP1;
					mostrar = SW;
					LED = SW;
					rgb_led = 3'd0;
					retain_op = 1'b0;
					retain_op1 = 1'b0;
					retain_op2 = 1'b0;
				end

			ESPERANDO_OP2:
				begin
					NextState = (DBTNC==1'b1)?ESPERANDO_OPERACION:ESPERANDO_OP2;
                    mostrar = SW;
                    LED = SW;
                    rgb_led = 3'd0;
                    retain_op = 1'b0;
                    retain_op1 = 1'b1;
                    retain_op2 = 1'b0;
				end

			ESPERANDO_OPERACION:
				begin
				    NextState = (DBTNC==1'b1)?MOSTRAR_RESULTADO:ESPERANDO_OPERACION;
					mostrar = 16'd0;
				    LED = SW;
				    rgb_led = _rgb;
					retain_op = 1'b0;
                    retain_op1 = 1'b1;
                    retain_op2 = 1'b1;
				end

			MOSTRAR_RESULTADO:
				begin
					NextState = (DBTNC==1'b1)?ESPERANDO_OP1:MOSTRAR_RESULTADO;
					mostrar = resultado;
					LED = {12'd0,_flags};
					rgb_led = 3'd0;
					retain_op = 1'b1;
                    retain_op1 = 1'b1;
                    retain_op2 = 1'b1;
				end
		endcase
	end

	ALU #(.size(16)) ALU_inst(
	    .clk(CLK100MHZ),
		.control(operacion),
		.A(operador1),
		.B(operador2),
		.flags(_flags),
		.res(resultado),
		.rgb(_rgb)
	);

	display display_inst(
	    .clk_100mhz(CLK100MHZ),
		.num(mostrar),
		.puntos(8'd1),
		.anodos(AN),
		.enc(encoding),
		.segmentos({CA,CB,CC,CD,CE,CF,CG,DP})
	);
    
    retainer #(.N(16)) op1_retainer(
        .clk(CLK100MHZ),
        .reset(!CPU_RESETN),
        .switches(SW),
        .retain(retain_op1),
        .value(operador1)
    );

    retainer #(.N(16)) op2_retainer(
        .clk(CLK100MHZ),
        .reset(!CPU_RESETN),
        .switches(SW),
        .retain(retain_op2),
        .value(operador2)
    );
        retainer #(.N(4)) op_retainer(
        .clk(CLK100MHZ),
        .reset(!CPU_RESETN),
        .switches(btns),
        .retain(retain_op),
        .value(operacion)
    );


    
	PushButton_Debouncer debouncer_BTNL(
		.clock(CLK100MHZ),
        .reset(!CPU_RESETN),
        .PB(BTNL),
        .PB_pressed_state(DBTNL),
        .PB_pressed_pulse(),
        .PB_released_pulse()
	);
	
	PushButton_Debouncer debouncer_BTNR(
	    .clock(CLK100MHZ),
        .reset(!CPU_RESETN),
        .PB(BTNR),
        .PB_pressed_state(DBTNR),
        .PB_pressed_pulse(),
        .PB_released_pulse()
	);
	
	PushButton_Debouncer debouncer_BTNU(
		.clock(CLK100MHZ),
        .reset(!CPU_RESETN),
        .PB(BTNU),
        .PB_pressed_state(DBTNU),
        .PB_pressed_pulse(),
        .PB_released_pulse()
	);
	
	PushButton_Debouncer debouncer_BTND(
		.clock(CLK100MHZ),
        .reset(!CPU_RESETN),
        .PB(BTND),
        .PB_pressed_state(DBTND),
        .PB_pressed_pulse(),
        .PB_released_pulse()
	);
	
	PushButton_Debouncer debouncer_BTNC(
		.clock(CLK100MHZ),
        .reset(!CPU_RESETN),
        .PB(BTNC),
        .PB_pressed_state(),
        .PB_pressed_pulse(DBTNC),
        .PB_released_pulse()
	);
endmodule