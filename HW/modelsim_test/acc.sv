`include "global.sv"
`include "timescale.sv"
module acc #(
	parameter INPUT_NUM = 1,   
	parameter WIGHT_SHIFT = 2, 
	parameter WDP 		=   9,
	parameter WDP_OUT	=17,
	parameter WDP_Q		=17,
	parameter WDP_WEIGHT =   9,
	parameter WDP_BIAS =   13
	)(
	input												clk,
	input												rstn,
	input												en,
	input												first_data,
	input												last_data,
	input		[WDP*INPUT_NUM-1:0]					data_i,
	input		[WDP_BIAS-1:0]							bias,
	input		[WDP_WEIGHT*INPUT_NUM-1:0]					weight,
	output reg											q_en,
	output reg	[WDP_Q-1:0]									q

	);


	wire	[WDP_OUT-1:0]		q_mac;
	wire				q_mac_en;

	reg		[15:0]	first_data_d;
	always @(*)	first_data_d[0] = first_data;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			first_data_d[15:1] <= 0;
		end
		else begin
			first_data_d[15:1] <= first_data_d;
		end
	end
	reg		[15:0]	last_data_d;
	always @(*)	last_data_d[0] = last_data;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			last_data_d[15:1] <= 0;
		end
		else begin
			last_data_d[15:1] <= last_data_d;
		end
	end
	reg		[15:0][WDP_BIAS-1:0]	bias_d;
	always @(*)	bias_d[0] = bias;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			bias_d[15:1] <= 0;
		end
		else begin
			bias_d[15:1] <= bias_d;
		end
	end
	reg		[15:0]	q_mac_en_d;
	always @(*)	q_mac_en_d[0] = q_mac_en;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			q_mac_en_d[15:1] <= 0;
		end
		else begin
			q_mac_en_d[15:1] <= q_mac_en_d;
		end
	end
	
	reg		[WDP*INPUT_NUM-1:0]		data_i_d1;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			data_i_d1 <= 0;
		end
		else begin
			data_i_d1 <= data_i;
		end
	end
	reg		[WDP_WEIGHT*INPUT_NUM-1:0]		weight_d1;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			weight_d1 <= 0;
		end
		else begin
			weight_d1 <= weight;
		end
	end
	reg		[0:0]		en_d1;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			en_d1 <= 0;
		end
		else begin
			en_d1 <= en;
		end
	end
	// delay 1+$clog2(KERNEL_SIZE_SQ)
	mac #(
		.INPUT_NUM		(INPUT_NUM),
		.WDP			(WDP),
		.WDP_OUT		(WDP_OUT),
		.WDP_WEIGHT		(WDP_WEIGHT),
		.WDP_BIAS		(WDP_BIAS)
		)mac(
		.clk			(clk),
		.rstn			(rstn),
		.d_en			(en_d1),
		.d				(data_i_d1),
		.w				(weight_d1),
		.q_en_b1		(q_mac_en_b1),
		.q_en			(q_mac_en),
		.q				(q_mac)	
		);
	reg	[WDP_OUT-1:0]		q_mac_acc;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			q_mac_acc <= 0;
		end
		else if (q_mac_en) begin
			if(first_data_d[1+$clog2(INPUT_NUM) + 1]) begin
				q_mac_acc <= $signed(q_mac) + $signed(bias_d[1+$clog2(INPUT_NUM)+1]);
			end
			else begin
				q_mac_acc <= $signed(q_mac) + $signed(q_mac_acc);
			end
		end
	end
	always @(*) q = q_mac_acc[WDP_OUT-1:WIGHT_SHIFT]; // related to "q = acc_q" 
	
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			q_en <= 0;
		end
		else begin
			q_en <= last_data_d[1+$clog2(INPUT_NUM)+1]&q_mac_en;
		end
	end
endmodule

