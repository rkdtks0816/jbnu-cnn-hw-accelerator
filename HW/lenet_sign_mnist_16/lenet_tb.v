`include "global.sv"
`include "timescale.sv"
module lenet_tb;
	reg	clk;
	reg	rstn;
	reg	en;
	reg	go;

	wire	[`WD:0]	q_data;
	wire		ready_sign_mnist;

	wire	[`WD:0]	qa_src_rom;
	wire		ready_src_rom;

	wire 		cena_src_rom;
	wire	[11:0]	aa_src_rom;
	wire		ready_lenet;
	wire	[5:0]	digit_text_lcd;

	wire		lcd_en;
	wire		lcd_rs;
	wire		lcd_rw;
	wire		lcd_on;
	wire	[7:0] 	lcd_dout;
	wire		ready;

		sign_mnist sign_mnist(
		.clk		(clk),
		.rstn		(rstn),
		.en		(en),
		.go		(go),

		.q_data		(q_data),
		.ready		(ready_sign_mnist)
		);

		src_rom src_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.go			(ready_sign_mnist),
		.data_i			(q_data),
		.cena			(cena_src_rom),
		.aa			(aa_src_rom),
//output
		.ready			(ready_src_rom),
		.qa			(qa_src_rom)
		);

	lenet lenet(
		.clk		(clk),
		.rstn		(rstn),
		.go		(ready_src_rom),
		.qa_src		(qa_src_rom),
		
		.aa_src		(aa_src_rom),
		.cena_src	(cena_src_rom),
		.ready		(ready_lenet),
		.digit		(digit_text_lcd),
		.en_text_lcd	(en_text_lcd)
	);

	text_lcd text_lcd(
		.clk		(clk),
		.rstn		(rstn),
		.en		(en_text_lcd),
		.go		(ready_lenet),
		.digit		(digit_text_lcd),

		.lcd_en		(lcd_en),
		.lcd_rs		(lcd_rs),
		.lcd_rw		(lcd_rw),
		.lcd_on		(lcd_on),
		.lcd_dout	(lcd_dout),
		.ready		(ready)
	);

	reg		[27:0]	digit_cnt;
	always @(`CLK_RST_EDGE)
		if (`RST)			digit_cnt <= 0;
		else if (ready)	begin
			$display("T%d==process a frame %d, digit %d =============", $time, digit_cnt, lcd_dout);
			digit_cnt <= digit_cnt + 1;
		end
	
	initial begin
		rstn = `RESET_ACTIVE;
		#(`RESET_DELAY); 
		$display("T%d rstn done#############################", $time);
		rstn = `RESET_IDLE;
	end

	initial begin
		clk = 1;
		en = 1;
		go = 1;
		forever	begin
			clk = ~clk;
			#(`CLK_PERIOD_DIV2);
		end
	end



endmodule
	