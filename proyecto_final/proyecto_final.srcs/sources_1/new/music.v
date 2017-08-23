// Music demo verilog file
// (c) fpga4fun.com 2003-2015

// Plays a little tune on a speaker
// Use a 25MHz clock if possible (other frequencies will 
// change the pitch/speed of the song)

// Page: http://www.fpga4fun.com/MusicBox3.html
// Editado por: Mario Marin 
// Los cambios proncipales fueron los siguientes:
// -Se removio el paso 1 (Step 1). Adicionalmente se implemento que fullnote fuera una entrada del modulo "music"
// -Se agrego la condicion "fullnote!=0" al ultimo always de el modulo "music", esto se hizo con la intencion de que
//  el modulo no reprodujera nada cuando fullnote es 0
/////////////////////////////////////////////////////
module music(clk, speaker,fullnote);
input clk;
output reg speaker;
input [7:0] fullnote;

wire [2:0] octave;
wire [3:0] note;
//clk_divider #(.CONSTANT(25000000)) slow_clk (.clk_in(clk), .rst(1'b0), .clk_out(clk_25M));
clock_divider #(.constantNumber(2)) slow_clk_inst (.clk(clk), .rst(1'b0), .clk_div(clk_25M));

divide_by12 divby12(.numerator(fullnote[5:0]), .quotient(octave), .remainder(note));

reg [8:0] clkdivider;
always @(note)begin
clkdivider = 0;
case(note)
  0: clkdivider = 512-1; // A 
  1: clkdivider = 483-1; // A#/Bb
  2: clkdivider = 456-1; // B 
  3: clkdivider = 431-1; // C 
  4: clkdivider = 406-1; // C#/Db
  5: clkdivider = 384-1; // D 
  6: clkdivider = 362-1; // D#/Eb
  7: clkdivider = 342-1; // E 
  8: clkdivider = 323-1; // F 
  9: clkdivider = 304-1; // F#/Gb
  10: clkdivider = 287-1; // G 
  11: clkdivider = 271-1; // G#/Ab
endcase
end
reg [8:0] counter_note;
always @(posedge clk_25M) if(counter_note==0) counter_note <= clkdivider; else counter_note <= counter_note-1;

reg [7:0] counter_octave;
always @(posedge clk_25M)
if(counter_note==0)
begin
 if(counter_octave==0)
  counter_octave <= (octave==0?255:octave==1?127:octave==2?63:octave==3?31:octave==4?15:7);
 else
  counter_octave <= counter_octave-1;
end

always @(posedge clk_25M) if(counter_note==0 && counter_octave==0 && fullnote!=0) speaker <= ~speaker;
endmodule
/////////////////////////////////////////////////////
module divide_by12(
	input [5:0] numerator,  // value to be divided by 12
	output reg [2:0] quotient, 
	output [3:0] remainder
);

reg [1:0] remainder3to2;
always @(numerator[5:2])
case(numerator[5:2])
	 0: begin quotient=0; remainder3to2=0; end
	 1: begin quotient=0; remainder3to2=1; end
	 2: begin quotient=0; remainder3to2=2; end
	 3: begin quotient=1; remainder3to2=0; end
	 4: begin quotient=1; remainder3to2=1; end
	 5: begin quotient=1; remainder3to2=2; end
	 6: begin quotient=2; remainder3to2=0; end
	 7: begin quotient=2; remainder3to2=1; end
	 8: begin quotient=2; remainder3to2=2; end
	 9: begin quotient=3; remainder3to2=0; end
	10: begin quotient=3; remainder3to2=1; end
	11: begin quotient=3; remainder3to2=2; end
	12: begin quotient=4; remainder3to2=0; end
	13: begin quotient=4; remainder3to2=1; end
	14: begin quotient=4; remainder3to2=2; end
	15: begin quotient=5; remainder3to2=0; end
endcase

assign remainder[1:0] = numerator[1:0];  // the first 2 bits are copied through
assign remainder[3:2] = remainder3to2;  // and the last 2 bits come from the case statement
endmodule
/////////////////////////////////////////////////////

