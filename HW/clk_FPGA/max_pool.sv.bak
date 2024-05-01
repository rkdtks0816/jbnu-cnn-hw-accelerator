`include "global.sv"
`include "timescale.sv"
module max_pool #(
	parameter INPUT_NUM = 6,   // input plane_num  
	parameter WDP =   9
	)(
	input												clk,
	input												rstn,
	input												en,
	input												first_data,
	input												last_data,
	input		[WDP*INPUT_NUM-1:0]					data_i,
	output reg											q_en,
	output reg	[WDP*INPUT_NUM-1:0]					q
	);
	
	
	reg		[0:0]		en_d1;
	always @(`CLK_RST_EDGE)
		if (`ZST)	en_d1 <= 0;
		else 		en_d1 <= en;
	reg		[0:0]		first_data_d1;
	always @(`CLK_RST_EDGE)
		if (`ZST)	first_data_d1 <= 0;
		else 		first_data_d1 <= first_data;	
	reg		[0:0]		last_data_d1;
	always @(`CLK_RST_EDGE)
		if (`ZST)	last_data_d1 <= 0;
		else 		last_data_d1 <= last_data;
	
	reg		[0:INPUT_NUM-1][WDP-1:0]	d_in;
	reg		[0:INPUT_NUM-1][WDP-1:0]	max_temp;
	always @(`CLK_RST_EDGE)
		if (`ZST)	d_in <= 0;
		else 		d_in <= data_i;
	genvar i; 
	generate 
		for (i=0; i<INPUT_NUM; i=i+1) begin : out_num
			always @(`CLK_RST_EDGE)
				if (`RST)							max_temp[i] <= 0;
				else if (first_data_d1)			max_temp[i] <= d_in[i];
				else if ($signed(d_in[i]) > $signed(max_temp[i]))	max_temp[i] <= d_in[i];
		end
	endgenerate
	
	always @(`CLK_RST_EDGE)
		if (`RST)	q_en <= 0;
		else 		q_en <= en_d1 & last_data_d1;
	assign q = max_temp;

endmodule


