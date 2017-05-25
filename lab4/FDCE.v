module retainer #(parameter N=16)(
	input clk,
	input reset,
	input [N-1:0] switches,
	input retain,
	output [N-1:0] value
);

    reg [N-1:0] Q, Q_next;
    
    assign value = Q;

    always @(posedge clk)
    begin
        if(reset)
            Q <= 2'd0;
        else
            Q <= Q_next;
    end

    always @(*)
    begin
        Q_next = Q;
        case (retain)
           1'b0:   Q_next = switches;
           1'b1:;
        endcase
    end

endmodule
