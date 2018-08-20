module visible_area #(parameter X_POS = 0, parameter Y_POS = 0) (
  input logic [10:0] hc, vc,
  input logic clk, rst,
  output logic visible
);
  localparam WIDTH = 480;
  localparam HEIGHT = 360;
  

  logic [10:0]hc_visible;
  logic [10:0]vc_visible;
  logic next_visible;
  
  always_ff @(posedge clk) begin
    if (rst)
      visible <= 'd0;
    else
      visible <= next_visible;
  end
	
	assign hc_visible = ((hc < (X_POS + WIDTH)) && (hc > (X_POS)))?(hc - X_POS)):11'd0;
	assign vc_visible = ((vc < (Y_POS + HEIGHT)) && (vc > (Y_POS)))?(vc - Y_POS):11'd0;
  
	assign  next_visible = (|hc_visible) & (|vc_visible);

endmodule
