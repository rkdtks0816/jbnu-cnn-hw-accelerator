`include "global.sv"
`include "timescale.sv"
module iterator_pooling #(
	parameter OUTPUT_BATCH = 5,   //
	parameter KERNEL_SIZEX = 5,   //
	parameter KERNEL_SIZEY = 5,   //
	parameter STEP = 1,
	parameter INPUT_WIDTH = 28,//32,
	parameter INPUT_HEIGHT = 28//32
	)(
	input					clk,
	input					rstn,
	input					go,
	output reg				first_data,
	output reg				last_data,
	output reg	[11:0]		aa_data,	
	output reg				cena,
	output reg				ready
	);
	
	reg		[`W_OUTPUT_BATCH :0] 	batch_cnt;
	reg		[`W_PLANEW :0] 	col;
	reg		[`W_PLANEH :0] 	row;
	reg		[`W_KERNEL :0] 	cnt_kx, cnt_ky;
	
	reg							cnt_kx_e;
	wire						cnt_kx_max_f = cnt_kx == KERNEL_SIZEX-1;
	wire						cnt_ky_max_f = cnt_ky == KERNEL_SIZEY-1;
	wire						col_max_f = col == INPUT_WIDTH - KERNEL_SIZEX + 1 -1;   
	wire						row_max_f = row == INPUT_HEIGHT - KERNEL_SIZEY + 1 -1;
	wire						batch_cnt_max_f = batch_cnt == OUTPUT_BATCH -1;
	
	wire		end_cnt_kx_e = cnt_kx_max_f & cnt_ky_max_f & col_max_f & row_max_f & batch_cnt_max_f;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cnt_kx_e <= 0;
		end
		else if (go) begin
			cnt_kx_e <= 1;
		end
		else if (end_cnt_kx_e) begin
			cnt_kx_e <= 0;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cnt_kx <= 0;
		end
		else if(cnt_kx_e) begin
			cnt_kx <= cnt_kx_max_f? 0: cnt_kx + 1;
		end
		else begin
			cnt_kx <= 0;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cnt_ky <= 0;
		end
		else if (cnt_kx_e) begin
			if (cnt_kx_max_f) begin
				cnt_ky <= cnt_ky_max_f?  0 : cnt_ky+1;
			end
		end 
		else begin
			cnt_ky <= 0;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			col <= 0;
		end
		else if (cnt_kx_e) begin	
			if (cnt_kx_max_f & cnt_ky_max_f)	begin
				col <= col_max_f? 0 : col + STEP;
			end
		end 
		else begin
			col <= 0;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			row <= 0;
		end
		else if (cnt_kx_e) begin	
			if (cnt_kx_max_f & cnt_ky_max_f & col_max_f) begin
				row <= row_max_f? 0 : row + STEP;
			end
		end 
		else begin
			row <= 0;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			batch_cnt <= 0;
		end
		else if (cnt_kx_e) begin	
			if (cnt_kx_max_f & cnt_ky_max_f & col_max_f & row_max_f) begin
				batch_cnt <= batch_cnt_max_f? 0 : batch_cnt + 1;
			end
		end 
		else begin
			batch_cnt <= 0;
		end
	end
		//?? ??? ?????
		
		
		
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			aa_data <= 0;
		end
		else begin
			aa_data <= row * INPUT_WIDTH + col + cnt_ky * INPUT_WIDTH + cnt_kx;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cena <= 1;
		end
		else begin
			cena <= ~cnt_kx_e;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			first_data <= 1;
		end
		else begin
			first_data <= cnt_kx_e && cnt_ky==0 && cnt_kx==0;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			last_data <= 1;
		end
		else begin
			last_data <= cnt_kx_e && cnt_kx_max_f && cnt_ky_max_f;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			ready <= 0;
		end
		else begin
			ready <= end_cnt_kx_e;
		end
	end

endmodule
