`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company:			UTFSM

// Engineer:		Mauricio Solis

// 

// Create Date:		09:01:45 29/04/2015 

// Design Name: 

// Module Name:		kbd_ms

// Project Name:	Experiencia 5

// Target Devices: 

// Tool versions: 

// Description:		Es un driver para el teclado y es capaz de 

//					indicar si llego un make code,break code, E0 make code

//					y E0 break code

//

// Dependencies:	ps2_read_ms

// Additional Comments: Cada vez que llega un paquete, se genera un pulso en kbs_tot

//                      en data_type se indica el tipo de dato recibido.

//                      y en new_data estará el dato.

//////////////////////////////////////////////////////////////////////////////////



`define MAKE_CODE		3'b001

`define MAKE_CODE_E0	3'b010

`define BRAKE_CODE		3'b011

`define BRAKE_CODE_E0	3'b100



`define KBD_STATE_INIT			4'b0001

`define KBD_STATE_F0			4'b0010		//F0 detected

`define KBD_STATE_F0_MAKE		4'b0011		//F0 and then code

`define KBD_STATE_E0			4'b0100		//E0 detected

`define KBD_STATE_E0_F0			4'b0101		//E0 and then F0 

`define KBD_STATE_E0_F0_MAKE	4'b0110		//E0_F0 and then code

`define KBD_STATE_E0_MAKE		4'b0111		//E0 and then code

`define KBD_STATE_MAKE			4'b1000		//make code

`define KBD_STATE_GEN_KBS		4'b1001		//To generate a kbs





module kbd_ms(clk,rst,kd,kc,new_data,data_type,kbs_tot,parity_error);

	input clk,rst,kd,kc;

	output reg[7:0] new_data;

	output reg[2:0]data_type;

	output reg kbs_tot;

	output parity_error;

	

	reg [3:0] kds_state_machine=`KBD_STATE_INIT;

	reg [3:0] kds_state_machine_next;

	

	wire [7:0]ps2_value;

	wire kbs;





	ps2_read_ms m_ps2read(clk, rst, kd, kc, kbs, ps2_value, parity_error);

	

	//maquina de estados para saber que dato esta llegando

	reg kbs_0=1'b0;

	wire kbs_pe;

	

	always@(posedge clk or posedge rst)

		if (rst)

			kbs_0 <= 1'b0;

		else

			kbs_0 <= kbs;



	assign kbs_pe = (kbs & ( ~kbs_0 ) );



	always@(*)

		if(kbs_pe)

			case(kds_state_machine)

				`KBD_STATE_INIT:		kds_state_machine_next=(ps2_value == 8'HF0)?`KBD_STATE_F0:

																(ps2_value == 8'HE0)?`KBD_STATE_E0:

																`KBD_STATE_MAKE;

																	

				`KBD_STATE_F0:			kds_state_machine_next = `KBD_STATE_F0_MAKE;

				

				`KBD_STATE_E0:			kds_state_machine_next = (ps2_value == 8'HF0)?`KBD_STATE_E0_F0:

																`KBD_STATE_E0_MAKE;

																	

				`KBD_STATE_E0_F0:		kds_state_machine_next=`KBD_STATE_E0_F0_MAKE;



				default:				kds_state_machine_next=kds_state_machine;

			endcase

		else

			case(kds_state_machine)

				`KBD_STATE_INIT,

				`KBD_STATE_F0,

				`KBD_STATE_E0,

				`KBD_STATE_E0_F0:		kds_state_machine_next=kds_state_machine;



				`KBD_STATE_F0_MAKE,

				`KBD_STATE_E0_F0_MAKE,

				`KBD_STATE_E0_MAKE,

				`KBD_STATE_MAKE:		kds_state_machine_next=`KBD_STATE_GEN_KBS;

				`KBD_STATE_GEN_KBS:		kds_state_machine_next=`KBD_STATE_INIT;

				default:				kds_state_machine_next=`KBD_STATE_INIT;

			endcase

	

	wire rst_state_machine;

	assign rst_state_machine = parity_error|rst;



	always@(posedge clk or posedge rst_state_machine)

		if(rst_state_machine)

			kds_state_machine <= `KBD_STATE_INIT;

		else

			kds_state_machine <= kds_state_machine_next;

	

	//describiendo las salidas new_data

	reg [7:0]new_data_next;



	always@(*)

		case(kds_state_machine)

			`KBD_STATE_F0_MAKE,`KBD_STATE_E0_F0_MAKE,`KBD_STATE_E0_MAKE,`KBD_STATE_MAKE:

				new_data_next = ps2_value;

			default: new_data_next = new_data;

		endcase

		

	always@(posedge clk or posedge rst)

		if(rst)

			new_data <= 8'd0;

		else

			new_data <= new_data_next;



	//describiendo la salida data_type;

	reg [2:0]data_type_next;



	always@(*)

		case(kds_state_machine)

			`KBD_STATE_F0_MAKE:		data_type_next = `BRAKE_CODE;

			`KBD_STATE_E0_F0_MAKE:	data_type_next = `BRAKE_CODE_E0;

			`KBD_STATE_E0_MAKE:		data_type_next = `MAKE_CODE_E0;

			`KBD_STATE_MAKE:		data_type_next = `MAKE_CODE;

			default:				data_type_next = data_type;

		endcase

	

	always@(posedge clk or posedge rst)

		if(rst)

			data_type <= 3'd0;

		else

			data_type <= data_type_next;

	

	//describiendo la salida kbs_tot;

	reg kbs_tot_next;



	always@(*)

		if(kds_state_machine == `KBD_STATE_GEN_KBS)

			kbs_tot_next = 1'b1;

		else

			kbs_tot_next = 1'b0;

			

	always@(posedge clk)

		kbs_tot <= kbs_tot_next;

		

endmodule
