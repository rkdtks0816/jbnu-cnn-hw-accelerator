`include "global.sv"
`include "timescale.sv"
module mac#(
	parameter INPUT_NUM = 1,   // input plane_num
	parameter WIGHT_SHIFT = 2,
	parameter WDP =   9,
	parameter WDP_OUT =   17,
	parameter WDP_WEIGHT =   9,
	parameter WDP_BIAS =   13
	)(
	input									clk,
	input									rstn,
	input									d_en,
	input	[WDP*INPUT_NUM-1:0]			d,
	input	[WDP_WEIGHT*INPUT_NUM-1:0]			w,
	output									q_en,
	output									q_en_b1,
	output	[WDP_OUT-1:0]					q
	);
	
	parameter INPUT_NUM_PADING = 2**$clog2(INPUT_NUM);
	
	wire	[0:INPUT_NUM-1][WDP-1:0] 	d_in = d;
	wire	[0:INPUT_NUM-1][WDP_WEIGHT-1:0] 	w_in = w;
	reg		[0:INPUT_NUM_PADING-1][WDP_OUT-1:0]	mul = 0;
	
	reg		[15:0]	d_en_d;

	always @(*)	d_en_d[0] = d_en;
	always @(`CLK_RST_EDGE)
		if (`RST)	d_en_d[15:1] <= 0;
		else 		d_en_d[15:1] <= d_en_d;
		
	

	genvar i;
	genvar j;
	generate 
		for (i=0; i<INPUT_NUM; i=i+1) begin : multiply
			always @(`CLK_RST_EDGE)
				if (`RST)	mul[i] <= 0;
				else 		mul[i] <= $signed(d_in[i]) * $signed(w_in[i]);
		end
	endgenerate
	
	generate 
		if (INPUT_NUM_PADING>1) begin
			reg		[0:$clog2(INPUT_NUM_PADING)-1][0:(INPUT_NUM_PADING+1)/2 -1][WDP_OUT-1:0]	sum = 0;
			for (i=0; i<$clog2(INPUT_NUM_PADING); i=i+1) begin : for1
				for(j=0; j < INPUT_NUM_PADING/(2**(i+1)); j++) begin : for2
					if (i==0) begin
						always @(`CLK_RST_EDGE)
							if (`RST)	sum[i][j] <= 0;
							else		sum[i][j] <= $signed(mul[j*2]) + $signed(mul[j*2+1]);
					end 
					else begin
						always @(`CLK_RST_EDGE)
							if (`RST)	sum[i][j] <= 0;
							else		sum[i][j] <= $signed(sum[i-1][j*2]) + $signed(sum[i-1][j*2+1]);
					end
				end	
			end
			assign q = sum[$clog2(INPUT_NUM_PADING)-1][0];
			assign q_en = d_en_d[$clog2(INPUT_NUM_PADING)+1];
			assign q_en_b1 = d_en_d[$clog2(INPUT_NUM_PADING)];
		end else begin
			//assign q = sum[$clog2(INPUT_NUM)-1][0][`WDP*2-1-:`WDP];
			assign q = mul[0];
			assign q_en = d_en_d[$clog2(INPUT_NUM_PADING)+1];
			assign q_en_b1 = d_en_d[$clog2(INPUT_NUM_PADING)];
		end
	endgenerate
	
endmodule


