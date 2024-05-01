`include "global.sv"
`include "timescale.sv"

module bias_conv1_rom(
	input							clk,
	input							rstn,
	input	[`W_OUTPUT_BATCH:0]		aa,
	input							cena,
	output reg		[`WDP_BIAS_CONV1*`OUTPUT_NUM_CONV1 -1:0]	qa
	);
	
	logic [0:`OUTPUT_BATCH_CONV1-1][0:`OUTPUT_NUM_CONV1-1][`WDP_BIAS_CONV1-1:0] weight	 = {	
26'd816700,  26'd218092,  26'd3719360,  26'd777449,  -26'd5816779,  26'd1286717
	};
	
	always @(`CLK_RST_EDGE)
		if (`RST)			qa <= 0;
		else if (!cena)		qa <= weight[aa];	
endmodule
