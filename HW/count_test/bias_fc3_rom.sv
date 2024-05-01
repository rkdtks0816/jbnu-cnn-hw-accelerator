`include "global.sv"
`include "timescale.sv"
module bias_fc3_rom(
	input			clk,
	input							rstn,
	input	[`W_OUTPUT_BATCH:0]		aa,
	input							cena,
	output reg		[`WDP_BIAS*`OUTPUT_NUM_FC3 -1:0]	qa
	);
	
	logic [0:`OUTPUT_BATCH_FC3-1][0:`OUTPUT_NUM_FC3-1][`WD_BIAS:0] weight	 = {
-34'd103524808,  34'd750085376,  -34'd118753480,  -34'd207873552,  -34'd227947360,  -34'd251433840,  34'd535552224,  34'd527561600,  34'd98252248,  -34'd358155328,  -34'd525942528,  -34'd325847168,  34'd262553280,  -34'd272816128,  -34'd616584640,  34'd885878592,  
-34'd581494976,  34'd167463088,  -34'd250992400,  -34'd192038592,  34'd311188672,  -34'd201962544,  34'd482863552,  -34'd169263968,  34'd155831712
	};

	always @(`CLK_RST_EDGE)
		if (`RST)			qa <= 0;
		else if (!cena)		qa <= weight[aa];	
endmodule





