module teclado_to_note(
    input [2:0] nro_octava,
    input [3:0] nota_entrada,
    output reg [7:0] nota_final    
    );
    
always @(*) begin
    case({nro_octava,nota_entrada}) 
        {3'd1,4'd1}: nota_final =  8'd1;
        {3'd1,4'd2}: nota_final =  8'd2;
        {3'd1,4'd3}: nota_final =  8'd3;
        {3'd1,4'd4}: nota_final =  8'd4;
        {3'd1,4'd5}: nota_final =  8'd5;
        {3'd1,4'd6}: nota_final =  8'd6;
        {3'd1,4'd7}: nota_final =  8'd7;
        {3'd1,4'd8}: nota_final =  8'd8;
        {3'd1,4'd9}: nota_final =  8'd9;
        {3'd1,4'd10}: nota_final = 8'd10;
        {3'd1,4'd11}: nota_final = 8'd11;
        {3'd1,4'd12}: nota_final = 8'd12;
        {3'd1,4'd13}: nota_final = 8'd13;
        {3'd2,4'd1}: nota_final =  8'd14;
        {3'd2,4'd2}: nota_final =  8'd15;
        {3'd2,4'd3}: nota_final =  8'd16;
        {3'd2,4'd4}: nota_final =  8'd17;
        {3'd2,4'd5}: nota_final =  8'd18;
        {3'd2,4'd6}: nota_final =  8'd19;
        {3'd2,4'd7}: nota_final =  8'd20;
        {3'd2,4'd8}: nota_final =  8'd21;
        {3'd2,4'd9}: nota_final =  8'd22;
        {3'd2,4'd10}: nota_final = 8'd23;
        {3'd2,4'd11}: nota_final = 8'd24;
        {3'd2,4'd12}: nota_final = 8'd25;
        {3'd2,4'd13}: nota_final = 8'd26;
        {3'd3,4'd1}: nota_final =  8'd27;
        {3'd3,4'd2}: nota_final =  8'd28;
        {3'd3,4'd3}: nota_final =  8'd29;
        {3'd3,4'd4}: nota_final =  8'd30;
        {3'd3,4'd5}: nota_final =  8'd31;
        {3'd3,4'd6}: nota_final =  8'd32;
        {3'd3,4'd7}: nota_final =  8'd33;
        {3'd3,4'd8}: nota_final =  8'd34;
        {3'd3,4'd9}: nota_final =  8'd35;
        {3'd3,4'd10}: nota_final = 8'd36;
        {3'd3,4'd11}: nota_final = 8'd37;
        {3'd3,4'd12}: nota_final = 8'd38;
        {3'd3,4'd13}: nota_final = 8'd39;
        {3'd4,4'd1}: nota_final =  8'd40;
        {3'd4,4'd2}: nota_final =  8'd41;
        {3'd4,4'd3}: nota_final =  8'd42;
        {3'd4,4'd4}: nota_final =  8'd43;
        {3'd4,4'd5}: nota_final =  8'd44;
        {3'd4,4'd6}: nota_final =  8'd45;
        {3'd4,4'd7}: nota_final =  8'd46;
        {3'd4,4'd8}: nota_final =  8'd47;
        {3'd4,4'd9}: nota_final =  8'd48;
        {3'd4,4'd10}: nota_final = 8'd49;
        {3'd4,4'd11}: nota_final = 8'd50;
        {3'd4,4'd12}: nota_final = 8'd51;
        {3'd4,4'd13}: nota_final = 8'd52;
        {3'd5,4'd1}: nota_final =  8'd53;
        {3'd5,4'd2}: nota_final =  8'd54;
        {3'd5,4'd3}: nota_final =  8'd55;
        {3'd5,4'd4}: nota_final =  8'd56;
        {3'd5,4'd5}: nota_final =  8'd57;
        {3'd5,4'd6}: nota_final =  8'd58;
        {3'd5,4'd7}: nota_final =  8'd59;
        {3'd5,4'd8}: nota_final =  8'd60;
        {3'd5,4'd9}: nota_final =  8'd61;
        {3'd5,4'd10}: nota_final = 8'd62;
        {3'd5,4'd11}: nota_final = 8'd63;
        {3'd5,4'd12}: nota_final = 8'd64;
        {3'd5,4'd13}: nota_final = 8'd65;
        default: nota_final=8'd0;
          
           
   endcase
end    
    
endmodule
