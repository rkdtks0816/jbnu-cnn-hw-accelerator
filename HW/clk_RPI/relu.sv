`include "global.sv"
`include "timescale.sv"
module relu #(
	parameter INPUT_NUM = 6,   // input plane_num 
	parameter WDP =   9
	)(
	input												clk,
	input												rstn,
	input												en,
	input		[WDP*INPUT_NUM-1:0]					data_i,
	output reg											q_en,
	output reg	[WDP*INPUT_NUM-1:0]					q
	);
	

	wire	[0:INPUT_NUM-1][WDP-1:0]		d_in = data_i;
	reg		[0:INPUT_NUM-1][WDP-1:0]	max_temp;
	
	genvar i;
	generate 
		for (i=0; i<INPUT_NUM; i=i+1) begin : out_num
			always @(`CLK_RST_EDGE)
				if (`RST)						max_temp[i] <= 0;
				else if (d_in[i][WDP-1])				max_temp[i] <= 0;
				else							max_temp[i] <= d_in[i];
		end
	endgenerate
	
	always @(`CLK_RST_EDGE)
		if (`RST)	q_en <= 0;
		else 		q_en <= en;
	assign q = max_temp;
endmodule


