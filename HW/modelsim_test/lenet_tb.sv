// Copyright (c) 2018  LulinChen, All Rights Reserved
// AUTHOR : 	LulinChen
// AUTHOR'S EMAIL : lulinchen@aliyun.com 
// Release history
// VERSION Date AUTHOR DESCRIPTION

`include "global.sv"
`include "timescale.sv"
`define	MAX_PATH			256
module lenet_tb();

	parameter  FRAME_WIDTH = 112;
	parameter  FRAME_HEIGHT = 48;
	parameter  SIM_FRAMES = 2;
	reg						rstn;
	reg						clk;
	reg						ee_clk;
	wire		rstn_ee = rstn;

	initial begin
		rstn = 1000;
		#(1000); 
		$display("T%d rstn done#############################", $time);
		rstn = 1'b1;
	end
	
	initial begin
		clk = 1;
		forever begin
			clk = ~clk;
			#(1000);
		end
	end
	
	initial begin
		ee_clk = 1;
		forever begin
			ee_clk = ~ee_clk;
			#(1670);
		end
	end
	
	reg			[15:0]			frame_width_0;
	reg			[15:0]			frame_height_0 ;
	reg			[27:0]			pic_to_sim ;
	reg		[`MAX_PATH*8-1:0]	sequence_name_0;
		
	itf_frame_feed 		itf(clk);
	
	wire		[5:0]	digit;
	wire				ready;
	wire				go =  itf.go;
	assign 				itf.ready = ready;
	
	initial begin
		#(1000)
		#(1000)
		itf.drive_frame(25);
		#(1000)
		$finish();
	end	
	
	
	wire	[11:0]			aa_src_rom;
	wire	[`WD:0]			qa_src_rom;
	wire cena_src_rom;
		
	lenet lenet(
//input
		.clk				(clk),
		.rstn				(rstn),
		.go				(go),				
		.qa_src				(qa_src_rom),
//output
		.aa_src				(aa_src_rom),
		.cena_src			(cena_src_rom),	
		.digit				(digit),		
		.ready				(ready)
		);
	

	src_rom src_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.aa			(aa_src_rom),
		.cena			(cena_src_rom),
//output
		.qa			(qa_src_rom)
		);
	reg		[27:0]	digit_cnt;
	always @(posedge clk, negedge rstn)
		if (rstn == 0)			digit_cnt <= 0;
		else if (ready)	begin
			$display("T%d==process a frame %d, digit %d =============", $time, digit_cnt, digit);
			digit_cnt <= digit_cnt + 1;
		end

	
	
`ifdef DUMP_FSDB 
	initial begin
	$fsdbDumpfile("fsdb/xx.fsdb");
	$fsdbDumpvars();
	end
`endif
	
endmodule
