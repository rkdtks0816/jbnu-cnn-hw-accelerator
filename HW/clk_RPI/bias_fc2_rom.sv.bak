`include "global.sv"
`include "timescale.sv"
module bias_fc2_rom(
	input			clk,
	input							rstn,
	input	[`W_OUTPUT_BATCH:0]		aa,
	input							cena,
	output reg		[`WDP_BIAS*`OUTPUT_NUM_FC2 -1:0]	qa
	);
	
	logic [0:`OUTPUT_BATCH_FC2-1][0:`OUTPUT_NUM_FC2-1][`WD_BIAS:0] weight	 = {
34'd176565280,  34'd566251520,  -34'd328163904,  34'd750612416,  -34'd240777488,  34'd20304584,  34'd65128500,  34'd244027664,  34'd481274592,  34'd42220532,  34'd355306752,  34'd214575664,  34'd538336256,  34'd102371536,  34'd167570848,  34'd239924384,  
34'd331247264,  -34'd31785422,  34'd302462560,  34'd441014656,  -34'd125561944,  -34'd362087424,  -34'd244473360,  34'd87160872,  -34'd195471520,  34'd314760544,  -34'd471283072,  -34'd672013056,  34'd200273776,  34'd0,  -34'd305332256,  34'd458068160
	};
	always @(`CLK_RST_EDGE)
		if (`RST)			qa <= 0;
		else if (!cena)		qa <= weight[aa];	
endmodule



