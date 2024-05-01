`include "global.sv"
`include "timescale.sv"
module conv #(
	parameter INPUT_NUM 	=1,   // input plane_num
	parameter OUTPUT_NUM 	=6,   
	parameter WIGHT_SHIFT 	=8,  
	parameter WDP 		=9, 
	parameter WDP_OUT	=17,
	parameter WDP_Q		=33,
	parameter WDP_WEIGHT	=9,
	parameter WDP_BIAS 	=13
	)(
	input												clk,
	input												rstn,
	input												en,
	input												first_data,
	input												last_data,
	input		[WDP*INPUT_NUM-1:0]					data_i,
	input		[WDP_BIAS*OUTPUT_NUM-1:0]				bias,
	input		[WDP_WEIGHT*INPUT_NUM*OUTPUT_NUM-1:0]			weight,
	output reg											q_en,
	output reg	[WDP_Q*OUTPUT_NUM-1:0]					q
	);
	

	wire	[0:OUTPUT_NUM-1][0:INPUT_NUM-1][WDP_WEIGHT-1:0] 	w_in = weight;
	wire	[0:OUTPUT_NUM-1][WDP_BIAS-1:0] 			bias_in = bias;
	wire	[0:OUTPUT_NUM-1]						acc_q_en;
	wire	[0:OUTPUT_NUM-1][WDP_Q-1:0] 				acc_q;
	

	
	assign q_en = acc_q_en[0];
	assign q = acc_q;

	genvar i;
	generate 
		for (i=0; i<OUTPUT_NUM; i=i+1) begin : out_num
			acc #(
				.INPUT_NUM		(INPUT_NUM),
				.WIGHT_SHIFT		(WIGHT_SHIFT),
				.WDP			(WDP),
				.WDP_OUT		(WDP_OUT),
				.WDP_Q			(WDP_Q),
				.WDP_WEIGHT		(WDP_WEIGHT),
				.WDP_BIAS		(WDP_BIAS)
				)acc(
				.clk			(clk),
				.rstn			(rstn),
				.en				(en),
				.first_data	(first_data),
				.last_data		(last_data),
				.data_i			(data_i),
				.bias			(bias_in[i]),
				.weight			(w_in[i]),
				.q_en			(acc_q_en[i]),
				.q              (acc_q[i])
				);
		end
	endgenerate


endmodule

