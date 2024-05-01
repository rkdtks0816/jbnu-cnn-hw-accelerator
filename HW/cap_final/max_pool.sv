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
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			en_d1 <= 0;
		end	
		else begin
			en_d1 <= en;
		end
	end
	reg		[0:0]		first_data_d1;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			first_data_d1 <= 0;
		end
		else begin
			first_data_d1 <= first_data;
		end
	end
	reg		[0:0]		last_data_d1;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			last_data_d1 <= 0;
		end
		else begin
			last_data_d1 <= last_data;
		end
	end
	reg		[0:INPUT_NUM-1][WDP-1:0]	d_in;
	reg		[0:INPUT_NUM-1][WDP-1:0]	max_temp;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			d_in <= 0;
		end
		else begin
			d_in <= data_i;
		end
	end
	genvar i; 
	generate 
		for (i=0; i<INPUT_NUM; i=i+1) begin : out_num
			always @(posedge clk, negedge rstn) begin
				if (rstn == 0) begin
					max_temp[i] <= 0;
				end
				else if (first_data_d1)	begin
					max_temp[i] <= d_in[i];
				end
				else if ($signed(d_in[i]) > $signed(max_temp[i])) begin
					max_temp[i] <= d_in[i];
				end
			end
		end
	endgenerate
	
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			q_en <= 0;
		end
		else begin
			q_en <= en_d1 & last_data_d1;
		end
	end
	assign q = max_temp;

endmodule


