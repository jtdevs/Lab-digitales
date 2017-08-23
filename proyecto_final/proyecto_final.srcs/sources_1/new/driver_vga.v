module driver_vga(clk_vga, hs, vs, hc_visible, vc_visible);
	input clk_vga;	// 25 MHz !
	output hs, vs;
	output [9:0]hc_visible;
	output [9:0]vc_visible; 
	//640x480 original
	parameter hpixels = 10'd800;  // --Value of pixels in a horizontal line
	parameter hfp  = 10'd16;      // --Horizontal front porch
	parameter hsc  = 10'd64;      // --Horizontal sync
	parameter hbp  = 10'd80;      // --Horizontal back porch
	
	parameter vlines  = 10'd500;  // --Number of horizontal lines in the display
	parameter vfp  = 10'd3;       // --Vertical front porch
	parameter vsc  = 10'd4;       // --Vertical sync
	parameter vbp  = 10'd30;      // --Vertical back porch
	
	reg [9:0] hc, hc_next, vc, vc_next;             // --These are the Horizontal and Vertical counters    
	
	assign hc_visible = ((hc < (hpixels - hfp)) && (hc > (hsc + hbp)))?(hc -(hsc + hbp)):10'd0;
	assign vc_visible = ((vc < (vlines - vfp)) && (vc > (vsc + vbp)))?(vc - (vsc + vbp)):10'd0;
	
	// --Runs the horizontal counter
	always@(*)
		if(hc == hpixels)				// --If the counter has reached the end of pixel count
			hc_next = 10'd0;			// --reset the counter
		else
			hc_next = hc + 10'd1;		// --Increment the horizontal counter
	
	// --Runs the vertical counter
	always@(*)
		if(hc == 10'd0)
			if(vc == vlines)
				vc_next = 10'd0;
			else
				vc_next = vc + 10'd1;
		else
			vc_next = vc;
	
	always@(posedge clk_vga)
		{hc, vc} <= {hc_next, vc_next};
		
	assign hs = (hc < hsc) ? 1'b0 : 1'b1;   // --Horizontal Sync Pulse
	assign vs = (vc < vsc) ? 1'b0 : 1'b1;   // --Vertical Sync Pulse
endmodule