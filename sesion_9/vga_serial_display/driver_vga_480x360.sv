module driver_vga_480x360(
	input clk_vga,                      // 16,750 MHz ! 75Hz
	output hs, vs, 
	output visible
); 
	logic [10:0]hc_visible;
	logic [10:0]vc_visible;
	//1024x768@75Hz
	localparam hpixels = 11'd592;  // --Value of pixels in a horizontal line
	localparam vlines  = 11'd379;  // --Number of horizontal lines in the display

	localparam hfp  = 11'd16;      // --Horizontal front porch
	localparam hsc  = 11'd40;      // --Horizontal sync
	localparam hbp  = 11'd56;      // --Horizontal back porch
	
	localparam vfp  = 11'd3;       // --Vertical front porch
	localparam vsc  = 11'd4;       // --Vertical sync
	localparam vbp  = 11'd12;      // --Vertical back porch
	
	
	logic [10:0] hc, hc_next, vc, vc_next;             // --These are the Horizontal and Vertical counters    
	
	assign hc_visible = ((hc < (hpixels - hfp)) && (hc > (hsc + hbp)))?(hc -(hsc + hbp)):11'd0;
	assign vc_visible = ((vc < (vlines - vfp)) && (vc > (vsc + vbp)))?(vc - (vsc + vbp)):11'd0;
	assign visible = (|hc_visible) & (|vc_visible);
	
	// --Runs the horizontal counter

	always_comb
		if(hc == hpixels)				// --If the counter has reached the end of pixel count
			hc_next = 11'd0;			// --reset the counter
		else
			hc_next = hc + 11'd1;		// --Increment the horizontal counter

	
	// --Runs the vertical counter
	always_comb
		if(hc == 11'd0)
			if(vc == vlines)
				vc_next = 11'd0;
			else
				vc_next = vc + 11'd1;
		else
			vc_next = vc;
	
	always_ff@(posedge clk_vga)
		{hc, vc} <= {hc_next, vc_next};
		
	assign hs = (hc < hsc) ? 1'b0 : 1'b1;   // --Horizontal Sync Pulse
	assign vs = (vc < vsc) ? 1'b0 : 1'b1;   // --Vertical Sync Pulse
endmodule
