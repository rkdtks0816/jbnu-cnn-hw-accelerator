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
	always @(`CLK_RST_EDGE)
		if (`RST)				cnt_kx_e <= 0;
		else if (go)			cnt_kx_e <= 1;
		else if (end_cnt_kx_e)	cnt_kx_e <= 0;
	
	always @(`CLK_RST_EDGE)
		if (`RST)			cnt_kx <= 0;
		else if(cnt_kx_e)	cnt_kx <= cnt_kx_max_f? 0: cnt_kx + 1;
		else				cnt_kx <= 0;
	always @(`CLK_RST_EDGE)
		if (`RST)				cnt_ky <= 0;
		else if (cnt_kx_e) begin
			if (cnt_kx_max_f)	cnt_ky <= cnt_ky_max_f?  0 : cnt_ky+1;
		end 
		else 				cnt_ky <= 0;
	always @(`CLK_RST_EDGE)
		if (`RST)					col <= 0;
		else if (cnt_kx_e) begin	
			if (cnt_kx_max_f & cnt_ky_max_f)	col <= col_max_f? 0 : col + STEP;
		end else					col <= 0;
	always @(`CLK_RST_EDGE)
		if (`RST)					row <= 0;
		else if (cnt_kx_e) begin	
			if (cnt_kx_max_f & cnt_ky_max_f & col_max_f)	row <= row_max_f? 0 : row + STEP;
		end else					row <= 0;
	always @(`CLK_RST_EDGE)
		if (`RST)					batch_cnt <= 0;
		else if (cnt_kx_e) begin	
			if (cnt_kx_max_f & cnt_ky_max_f & col_max_f & row_max_f)	batch_cnt <= batch_cnt_max_f? 0 : batch_cnt + 1;
		end else					batch_cnt <= 0;
		//?? ??? ?????
		
		
		
	always @(`CLK_RST_EDGE)
		if (`RST)	aa_data <= 0;
		else 		aa_data <= row * INPUT_WIDTH + col + cnt_ky * INPUT_WIDTH + cnt_kx;
	always @(`CLK_RST_EDGE)
		if (`RST)	cena <= 1;
		else 		cena <= ~cnt_kx_e;
	always @(`CLK_RST_EDGE)
		if (`RST)	first_data <= 1;
		else 		first_data <= cnt_kx_e && cnt_ky==0 && cnt_kx==0;
	always @(`CLK_RST_EDGE)
		if (`RST)	last_data <= 1;
		else 		last_data <= cnt_kx_e && cnt_kx_max_f && cnt_ky_max_f;

	always @(`CLK_RST_EDGE)
		if (`RST)	ready <= 0;
		else 		ready <= end_cnt_kx_e;
endmodule
