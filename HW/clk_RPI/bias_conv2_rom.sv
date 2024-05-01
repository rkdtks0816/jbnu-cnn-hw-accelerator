`include "global.sv"
`include "timescale.sv"
module bias_conv2_rom(
	input							clk,
	input							rstn,
	input	[`W_OUTPUT_BATCH:0]		aa,
	input							cena,
	output reg		[`WDP_BIAS*`OUTPUT_NUM_CONV2 -1:0]	qa
	);
	
	logic [0:`OUTPUT_BATCH_CONV2-1][0:`OUTPUT_NUM_CONV2-1][`WD_BIAS:0] weight	 = {
-34'd167012672,  34'd210449312,  34'd169529776,  34'd491355872,  -34'd27928892,  -34'd93609704,  34'd469565216,  34'd396735872,  -34'd230282720,  34'd58802812,  -34'd255118960,  -34'd416269824,  -34'd20920164,  -34'd97691856,  34'd267190480,  -34'd141673920
	};	
	always @(`CLK_RST_EDGE)
		if (`RST)			qa <= 0;
		else if (!cena)		qa <= weight[aa];	
endmodule



