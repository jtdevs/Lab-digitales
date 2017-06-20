module previa_6_1(
	input CLK100MHZ,
	input PS2_CLK,
	input PS2_DATA,
	output JA1, JA2, JA3, JA4, JA7, JA8
);
	wire [7:0] data;
	wire [2:0] data_type;
	wire kbs_tot;
	assign JA1 = PS2_CLK;
	assign JA2 = PS2_DATA;
	assign JA3 = kbs_tot;
	assign JA4 = (data_type == 3'b001); // make code
	assign JA7 = (data_type == 3'b011); // break code
	assign JA8 = (data == 8'h5A); // is_enter

	kbd_ms m_kd(
            .clk(CLK1MHZ),
            .rst(1'b0),
            .kd(PS2_DATA),
            .kc(PS2_CLK),
            .new_data(data),
            .data_type(data_type),
            .kbs_tot(kbs_tot),
            .parity_error()
		);
    clock_divider #(.CONSTANT(50))
            clock_divider_inst(
                .clk_in(CLK100MHZ),
                .rst(1'd0),
                .clk_out(CLK1MHZ)
        );

endmodule