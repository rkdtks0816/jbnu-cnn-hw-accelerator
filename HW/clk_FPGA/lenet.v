`include "global.sv"
`include "timescale.sv"
module lenet(
	input						clk,
	input						rstn,
	input						go,
	input		[`WD:0]			qa_src,

	output					ready,
	output	reg				en_text_lcd,
	output	reg	[5:0]			digit,
	output					cena_src,
	output		[11:0]			aa_src
	);
	
	wire		[11:0]								aa_weight_conv1;
	wire		[`WDP_WEIGHT*`OUTPUT_NUM_CONV1-1:0]		qa_weight_conv1;
	
	wire		[`W_OUTPUT_BATCH:0]					aa_bias_conv1;
	wire		[`WDP_BIAS_CONV1*`OUTPUT_NUM_CONV1 -1:0]	qa_bias_conv1;

	wieght_conv1_rom wieght_conv1_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.aa				(aa_weight_conv1),
		.cena			(cena_src),
//output
		.qa				(qa_weight_conv1)
		);
	bias_conv1_rom bias_conv1_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.aa				(aa_bias_conv1),
		.cena			(cena_src),
//output
		.qa				(qa_bias_conv1)
		);
	wire	conv1_go = go;
	iterator_conv  #(
		.OUTPUT_BATCH	(`OUTPUT_BATCH_CONV1),
		.KERNEL_SIZEX	(`KERNEL_SIZEX_CONV1),
		.KERNEL_SIZEY	(`KERNEL_SIZEY_CONV1),
		.STEP			(1),
		.INPUT_WIDTH	(`INPUT_WIDTH),
		.INPUT_HEIGHT	(`INPUT_HEIGHT)
		)iterator_conv1(
//input
		.clk				(clk),
		.rstn				(rstn),
		.go					(conv1_go),
//output
		.first_data			(first_data),
		.last_data			(last_data),
		.aa_bias			(aa_bias_conv1),
		.aa_data			(aa_src),
		.aa_weight			(aa_weight_conv1),
		.cena				(cena_src),
		.ready          	(conv1_ready)
	); 
	
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
	reg		[15:0]	cena_src_d;
	always @(*)	cena_src_d[0] = cena_src;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cena_src_d[15:1] <= 0;
		end
		else begin
			cena_src_d[15:1] <= cena_src_d;
		end
	end
	wire	[`WDP_Q_CONV1*`OUTPUT_NUM_CONV1 -1:0] q_conv1;	
	
	conv #(
		.INPUT_NUM		(`INPUT_NUM),
		.OUTPUT_NUM		(`OUTPUT_NUM),
		.WIGHT_SHIFT		(`WIGHT_SHIFT_CONV1),
		.WDP			(`WDP),
		.WDP_OUT		(`WDP_CONV1),
		.WDP_Q			(`WDP_Q_CONV1),
		.WDP_WEIGHT		(`WDP_WEIGHT),
		.WDP_BIAS		(`WDP_BIAS_CONV1)
		)conv1(
//input
		.clk			(clk),
		.rstn			(rstn),
		.en				(~cena_src_d[1]),
		.first_data		(first_data_d[1]),
		.last_data		(last_data_d[1]),
		.data_i			(qa_src),
		.bias			(qa_bias_conv1),
		.weight			(qa_weight_conv1),
//output
		.q              (q_conv1),
		.q_en           (q_conv1_en)
		);
	wire		[11:0]	aa_conv1_buf;
	wire				cena_conv1_buf;
	reg		[11:0]	ab_conv1_buf;
	reg		[`WDP_Q_CONV1*`OUTPUT_NUM_CONV1 -1:0]	db_conv1_buf;
	reg				cenb_conv1_buf;
	wire	[`WDP_Q_CONV1*`OUTPUT_NUM_CONV1 -1:0]	qa_conv1_buf;
	
	buffer #(
		.WWORD	(`WDP_Q_CONV1*`OUTPUT_NUM_CONV1),
		.DEPTH	(576)
		)buffer_conv1(
//input
		.clka   (clk),
		.cena   (cena_conv1_buf),
		.aa     (aa_conv1_buf),
		.clkb   (clk),
		.cenb   (cenb_conv1_buf),
		.ab     (ab_conv1_buf),
		.db     (db_conv1_buf),
//output
		.qa     (qa_conv1_buf)
		);
	
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			db_conv1_buf <= 0;
		end
		else begin
			db_conv1_buf <= q_conv1;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cenb_conv1_buf <= 1;
		end
		else	begin
			cenb_conv1_buf <= ~q_conv1_en;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			ab_conv1_buf <= 0;
		end
		else if (conv1_go) begin
			ab_conv1_buf <= 0;
		end
		else if (!cenb_conv1_buf) begin
			ab_conv1_buf <= ab_conv1_buf + 1;
		end
	end
	wire	pooling1_go = conv1_ready;
	iterator_pooling #(
		.OUTPUT_BATCH		(1),
		.KERNEL_SIZEX		(2),
		.KERNEL_SIZEY		(2),
		.STEP				(2),
		.INPUT_WIDTH		(`INPUT_WIDTH - `KERNEL_SIZE_CONV1 + 1),
		.INPUT_HEIGHT		(`INPUT_HEIGHT - `KERNEL_SIZE_CONV1 + 1)
	) iterator_pooling1(
//input
		.clk				(clk),
		.rstn				(rstn),
		.go					(pooling1_go),
//output
		.aa_data			(aa_conv1_buf),
		.cena				(cena_conv1_buf),
		.first_data			(first_data_pooling1),
		.last_data			(last_data_pooling1),
		.ready				(pooling1_ready)
	); 
	
	reg		[15:0]	cena_conv1_buf_d;
	always @(*)	cena_conv1_buf_d[0] = cena_conv1_buf;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cena_conv1_buf_d[15:1] <= 0;
		end
		else begin
			cena_conv1_buf_d[15:1] <= cena_conv1_buf_d;
		end
	end
	reg		[15:0]	first_data_pooling1_d;
	always @(*)	first_data_pooling1_d[0] = first_data_pooling1;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			first_data_pooling1_d[15:1] <= 0;
		end
		else begin
			first_data_pooling1_d[15:1] <= first_data_pooling1_d;
		end
	end
	reg		[15:0]	last_data_pooling1_d;
	always @(*)	last_data_pooling1_d[0] = last_data_pooling1;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			last_data_pooling1_d[15:1] <= 0;
		end
		else begin
			last_data_pooling1_d[15:1] <= last_data_pooling1_d;
		end
	end	
			
	wire	[`WDP_Q_CONV1*`OUTPUT_NUM_CONV1 -1:0] qa_pooling1;		
	
	max_pool #(
		.INPUT_NUM 	(`OUTPUT_NUM_CONV1),   // input plane_num
		.WDP		(`WDP_Q_CONV1)
	) max_pooling1(
//input
		.clk				(clk),
		.rstn				(rstn),
		.en					(!cena_conv1_buf_d[1]),
		.first_data			(first_data_pooling1_d[1]),
		.last_data			(last_data_pooling1_d[1]),
		.data_i				(qa_conv1_buf),
//output
		.q_en				(qa_pooling1_en),
		.q					(qa_pooling1)
		);
	wire	[`WDP_Q_CONV1*`OUTPUT_NUM_CONV1 -1:0] qa_relu1;		
	relu #(
		.INPUT_NUM 	(`OUTPUT_NUM_CONV1),   // input plane_num
		.WDP		(`WDP_Q_CONV1)
	) relu1(
//input
		.clk				(clk),
		.rstn				(rstn),
		.en					(qa_pooling1_en),
		.data_i				(qa_pooling1),
//output		
		.q_en				(qa_relu1_en),
		.q					(qa_relu1)
		
	);
	wire		[11:0]	aa_relu1_buf;
	wire				cena_relu1_buf;
	reg		[11:0]	ab_relu1_buf;
	reg		[`WDP_Q_CONV1*`OUTPUT_NUM_CONV1 -1:0]	db_relu1_buf;
	reg				cenb_relu1_buf;
	wire	[`WDP_Q_CONV1*`OUTPUT_NUM_CONV1 -1:0]	qa_relu1_buf;

	buffer #(
		.WWORD	(`WDP_Q_CONV1*`OUTPUT_NUM_CONV1),
		.DEPTH	(144)
		)buffer_relu1(
//input
		.clka   (clk),
		.cena   (cena_relu1_buf),
		.aa     (aa_relu1_buf),
		.clkb   (clk),
		.cenb   (cenb_relu1_buf),
		.ab     (ab_relu1_buf),
		.db     (db_relu1_buf),
//output
		.qa     (qa_relu1_buf)
		);
	
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			db_relu1_buf <= 0;
		end
		else begin
			db_relu1_buf <= qa_relu1;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cenb_relu1_buf <= 1;
		end
		else begin
			cenb_relu1_buf <= ~qa_relu1_en;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			ab_relu1_buf <= 0;
		end
		else if (pooling1_go) begin
			ab_relu1_buf <= 0;
		end
		else if (!cenb_relu1_buf) begin
			ab_relu1_buf <= ab_relu1_buf + 1;
		end
	end
	
	//=============================================================================
	
	wire		[`WDP_WEIGHT*`OUTPUT_NUM_CONV1*`OUTPUT_NUM_CONV2 -1:0]	qa_weight_conv2;
	wire		[11:0]											aa_weight_conv2;
	wieght_conv2_rom wieght_conv2_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.aa				(aa_weight_conv2),
		.cena			(cena_relu1_buf),
//output
		.qa				(qa_weight_conv2)
		);
		
	wire		[`W_OUTPUT_BATCH:0]					aa_bias_conv2;
	wire		[`WDP_BIAS*`OUTPUT_NUM_CONV2 -1:0]	qa_bias_conv2;
	bias_conv2_rom bias_conv2_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.aa				(aa_bias_conv2),
		.cena			(cena_relu1_buf),
//output
		.qa				(qa_bias_conv2)
		);
	
	wire	conv2_go = pooling1_ready;
	iterator_conv  #(
		.OUTPUT_BATCH	(`OUTPUT_BATCH_CONV2),
		.KERNEL_SIZEX	(`KERNEL_SIZEX_CONV2),
		.KERNEL_SIZEY	(`KERNEL_SIZEY_CONV2),
		.STEP			(1),
		.INPUT_WIDTH	(`INPUT_WIDTH_CONV2),
		.INPUT_HEIGHT	(`INPUT_HEIGHT_CONV2)
		)iterator_conv2(
//input		
		.clk				(clk),
		.rstn				(rstn),
		.go					(conv2_go),
//output
		.first_data			(first_data_conv2),
		.last_data			(last_data_conv2),
		.aa_bias			(aa_bias_conv2),
		.aa_data			(aa_relu1_buf),
		.aa_weight			(aa_weight_conv2),
		.cena				(cena_relu1_buf),
		.ready          	(conv2_ready)
		); 
	
	reg		[15:0]	cena_relu1_buf_d;
	always @(*)	cena_relu1_buf_d[0] = cena_relu1_buf;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cena_relu1_buf_d[15:1] <= 0;
		end
		else	begin
			cena_relu1_buf_d[15:1] <= cena_relu1_buf_d;
		end
	end
	reg		[15:0]	first_data_conv2_d;
	always @(*)	first_data_conv2_d[0] = first_data_conv2;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			first_data_conv2_d[15:1] <= 0;
		end
		else begin
			first_data_conv2_d[15:1] <= first_data_conv2_d;
		end
	end
	reg		[15:0]	last_data_conv2_d;
	always @(*)	last_data_conv2_d[0] = last_data_conv2;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			last_data_conv2_d[15:1] <= 0;
		end
		else begin
			last_data_conv2_d[15:1] <= last_data_conv2_d;
		end
	end

	wire	[`WDP_Q_CONV2*`OUTPUT_NUM_CONV2 -1:0] q_conv2;	

	conv #(
		.INPUT_NUM		(`OUTPUT_NUM_CONV1),
		.OUTPUT_NUM		(`OUTPUT_NUM_CONV2),
		.WIGHT_SHIFT		(`WIGHT_SHIFT_CONV2),
		.WDP			(`WDP_Q_CONV1),
		.WDP_OUT		(`WDP_CONV2),
		.WDP_Q			(`WDP_Q_CONV2),
		.WDP_WEIGHT		(`WDP_WEIGHT),
		.WDP_BIAS		(`WDP_BIAS)
		)conv2(
//input
		.clk			(clk),
		.rstn			(rstn),
		.en				(~cena_relu1_buf_d[1]),
		.first_data		(first_data_conv2_d[1]),
		.last_data		(last_data_conv2_d[1]),
		.data_i			(qa_relu1_buf),
		.bias			(qa_bias_conv2),
		.weight			(qa_weight_conv2),
//output
		.q              (q_conv2),
		.q_en           (q_conv2_en)
		);
	// 10*10*16
	wire		[11:0]	aa_conv2_buf;
	wire				cena_conv2_buf;
	reg		[11:0]	ab_conv2_buf;
	reg		[`WDP_Q_CONV2*`OUTPUT_NUM_CONV2 -1:0]	db_conv2_buf;
	reg				cenb_conv2_buf;
	wire	[`WDP_Q_CONV2*`OUTPUT_NUM_CONV2 -1:0]	qa_conv2_buf;
	
	buffer #(
		.WWORD	(`WDP_Q_CONV2*`OUTPUT_NUM_CONV2),
		.DEPTH	(64)
		)buffer_conv2(
//input
		.clka   (clk),
		.cena   (cena_conv2_buf),
		.aa     (aa_conv2_buf),
		.clkb   (clk),
		.cenb   (cenb_conv2_buf),
		.ab     (ab_conv2_buf),
		.db     (db_conv2_buf),
//output
		.qa     (qa_conv2_buf)
		);
	
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			db_conv2_buf <= 0;
		end
		else begin
			db_conv2_buf <= q_conv2;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cenb_conv2_buf <= 1;
		end
		else begin
			cenb_conv2_buf <= ~q_conv2_en;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			ab_conv2_buf <= 0;
		end
		else if (conv2_go) begin
			ab_conv2_buf <= 0;
		end
		else if (!cenb_conv2_buf) begin
			ab_conv2_buf <= ab_conv2_buf + 1;
		end
	end
	
	wire	pooling2_go= conv2_ready;
	iterator_pooling #(
		.OUTPUT_BATCH		(1),
		.KERNEL_SIZEX		(2),
		.KERNEL_SIZEY		(2),
		.STEP				(2),
		.INPUT_WIDTH		(`INPUT_WIDTH_CONV2 - `KERNEL_SIZE_CONV2 + 1),
		.INPUT_HEIGHT		(`INPUT_HEIGHT_CONV2 - `KERNEL_SIZE_CONV2 + 1)
	) iterator_pooling2(
//input
		.clk				(clk),
		.rstn				(rstn),
		.go					(pooling2_go),
//output
		.aa_data			(aa_conv2_buf),
		.cena				(cena_conv2_buf),
		.first_data			(first_data_pooling2),
		.last_data			(last_data_pooling2),
		.ready				(pooling2_ready)
	); 
	
	reg		[15:0]	cena_conv2_buf_d;
	always @(*)	cena_conv2_buf_d[0] = cena_conv2_buf;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cena_conv2_buf_d[15:1] <= 0;
		end
		else begin
			cena_conv2_buf_d[15:1] <= cena_conv2_buf_d;
		end
	end
	reg		[15:0]	first_data_pooling2_d;
	always @(*)	first_data_pooling2_d[0] = first_data_pooling2;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			first_data_pooling2_d[15:1] <= 0;
		end
		else begin
			first_data_pooling2_d[15:1] <= first_data_pooling2_d;
		end
	end
	reg		[15:0]	last_data_pooling2_d;
	always @(*)	last_data_pooling2_d[0] = last_data_pooling2;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			last_data_pooling2_d[15:1] <= 0;
		end
		else begin
			last_data_pooling2_d[15:1] <= last_data_pooling2_d;
		end
	end
	
	wire	[`WDP_Q_CONV2*`OUTPUT_NUM_CONV2 -1:0] qa_pooling2;	
	
	max_pool #(
		.INPUT_NUM (`OUTPUT_NUM_CONV2),   // input plane_num
		.WDP		(`WDP_Q_CONV2)
	) max_pooling2(
//input
		.clk				(clk),
		.rstn				(rstn),
		.en					(!cena_conv2_buf_d[1]),
		.first_data			(first_data_pooling2_d[1]),
		.last_data			(last_data_pooling2_d[1]),
		.data_i				(qa_conv2_buf),
//output
		.q_en				(qa_pooling2_en),
		.q					(qa_pooling2)
		);
	wire	[`WDP_Q_CONV2*`OUTPUT_NUM_CONV2 -1:0] qa_relu2;		
	relu #(
		.INPUT_NUM (`OUTPUT_NUM_CONV2),   // input plane_num
		.WDP		(`WDP_Q_CONV2)
	) relu2(
//input
		.clk				(clk),
		.rstn				(rstn),
		.en					(qa_pooling2_en),
		.data_i				(qa_pooling2),
//output	
		.q_en				(qa_relu2_en),
		.q					(qa_relu2)
	);
	// 5x5*16
	
	wire		[11:0]	aa_relu2_buf;
	wire				cena_relu2_buf;
	reg		[11:0]	ab_relu2_buf;
	reg		[`WDP_Q_CONV2*`OUTPUT_NUM_CONV2 -1:0]	db_relu2_buf;
	reg				cenb_relu2_buf;
	wire	[`WDP_Q_CONV2*`OUTPUT_NUM_CONV2 -1:0]	qa_relu2_buf;
	
	buffer #(
		.WWORD	(`WDP_Q_CONV2*`OUTPUT_NUM_CONV2),
		.DEPTH	(16)
		)buffer_relu2(
//input
		.clka   (clk),
		.cena   (cena_relu2_buf),
		.aa     (aa_relu2_buf),
		.clkb   (clk),
		.cenb   (cenb_relu2_buf),
		.ab     (ab_relu2_buf),
		.db     (db_relu2_buf),
//output
		.qa     (qa_relu2_buf)
		);
	
	
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			db_relu2_buf <= 0;
		end
		else begin
			db_relu2_buf <= qa_relu2;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cenb_relu2_buf <= 1;
		end
		else begin
			cenb_relu2_buf <= ~qa_relu2_en;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			ab_relu2_buf <= 0;
		end
		else if (pooling2_go) begin
			ab_relu2_buf <= 0;
		end
		else if (!cenb_relu2_buf) begin
			ab_relu2_buf <= ab_relu2_buf + 1;
		end
	end
	
	//======================= FC ================================	
	
	wire		[`WDP_WEIGHT*`OUTPUT_NUM_CONV2*`OUTPUT_NUM_FC1 -1:0]	qa_weight_FC1_rom;
	wire		[11:0]	aa_weight_FC1;
	wire		[`W_OUTPUT_BATCH:0]								aa_bias_FC1;
	wire		[`WDP_BIAS*`OUTPUT_NUM_FC1 -1:0]				qa_bias_FC1;
	
	wieght_fc1_rom wieght_fc1_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.aa				(aa_weight_FC1),
		.cena			(cena_relu2_buf),
//output
		.qa				(qa_weight_FC1_rom)
		);
	bias_fc1_rom bias_fc1_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.aa				(aa_bias_FC1),
		.cena			(cena_relu2_buf),
//output
		.qa				(qa_bias_FC1)
		);
	
		
	wire	fc1_go = pooling2_ready;
	iterator_conv  #(
		.OUTPUT_BATCH	(`OUTPUT_BATCH_FC1),
		.KERNEL_SIZEX	(`KERNEL_SIZEX_FC1),
		.KERNEL_SIZEY	(`KERNEL_SIZEY_FC1),
		.STEP			(1),
		.INPUT_WIDTH	(`INPUT_WIDTH_FC1),
		.INPUT_HEIGHT	(`INPUT_HEIGHT_FC1)
		)iterator_FC1(
//input
		.clk				(clk),
		.rstn				(rstn),
		.go					(fc1_go),
//output
		.first_data			(first_data_FC1),
		.last_data			(last_data_FC1),
		.aa_bias			(aa_bias_FC1),
		.aa_data			(aa_relu2_buf),
		.aa_weight			(aa_weight_FC1),
		.cena				(cena_relu2_buf),
		.ready          	(fc1_ready)
	); 
	
	reg		[15:0]	cena_relu2_buf_d;
	always @(*)	cena_relu2_buf_d[0] = cena_relu2_buf;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cena_relu2_buf_d[15:1] <= 0;
		end
		else begin
			cena_relu2_buf_d[15:1] <= cena_relu2_buf_d;
		end
	end
	reg		[15:0]	first_data_FC1_d;
	always @(*)	first_data_FC1_d[0] = first_data_FC1;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			first_data_FC1_d[15:1] <= 0;
		end
		else begin
			first_data_FC1_d[15:1] <= first_data_FC1_d;
		end
	end
	reg		[15:0]	last_data_FC1_d;
	always @(*)	last_data_FC1_d[0] = last_data_FC1;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			last_data_FC1_d[15:1] <= 0;
		end
		else begin
			last_data_FC1_d[15:1] <= last_data_FC1_d;
		end
	end
	wire	[`WDP_Q_FC1*`OUTPUT_NUM_FC1 -1:0] q_fc1;		
	conv #(
		.INPUT_NUM		(`OUTPUT_NUM_CONV2),
		.OUTPUT_NUM		(`OUTPUT_NUM_FC1),
		.WIGHT_SHIFT		(`WIGHT_SHIFT_FC1),
		.WDP			(`WDP_Q_CONV2),
		.WDP_OUT		(`WDP_FC1),
		.WDP_Q			(`WDP_Q_FC1),
		.WDP_WEIGHT		(`WDP_WEIGHT),
		.WDP_BIAS		(`WDP_BIAS)
		)conv_fc1(
//input
		.clk			(clk),
		.rstn			(rstn),
		.en				(~cena_relu2_buf_d[1]),
		.first_data		(first_data_FC1_d[1]),
		.last_data		(last_data_FC1_d[1]),
		.data_i			(qa_relu2_buf),
		.bias			(qa_bias_FC1),
		.weight			(qa_weight_FC1_rom),
//output
		.q              (q_fc1),
		.q_en           (q_fc1_en)
		);
	wire	[`WDP_Q_FC1*`OUTPUT_NUM_FC1 -1:0] qa_relu_fc1;		
	relu #(
		.INPUT_NUM (`OUTPUT_NUM_FC1),   // input plane_num
		.WDP		(`WDP_Q_FC1)
	) relu_fc1(
//input
		.clk				(clk),
		.rstn				(rstn),
		.en				(q_fc1_en),
		.data_i				(q_fc1),
//output	
		.q_en				(qa_relu_fc1_en),
		.q					(qa_relu_fc1)
	);	
	wire		[11:0]	aa_relu_fc1_buf;
	wire				cena_relu_fc1_buf;
	reg		[11:0]	ab_relu_fc1_buf;
	reg		[`WDP_Q_FC1*`OUTPUT_NUM_FC1 -1:0]	db_relu_fc1_buf;
	reg				cenb_relu_fc1_buf;
	wire	[`WDP_Q_FC1*`OUTPUT_NUM_FC1 -1:0]	qa_relu_fc1_buf;
	
	buffer #(
		.WWORD	(`WDP_Q_FC1*`OUTPUT_NUM_FC1),
		.DEPTH	(64)
		)buffer_relu_fc1(
//input
		.clka   (clk),
		.cena   (cena_relu_fc1_buf),
		.aa     (aa_relu_fc1_buf),
		.clkb   (clk),
		.cenb   (cenb_relu_fc1_buf),
		.ab     (ab_relu_fc1_buf),
		.db     (db_relu_fc1_buf),
//output
		.qa     (qa_relu_fc1_buf)
		);

	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			db_relu_fc1_buf <= 0;
		end
		else begin
			db_relu_fc1_buf <= qa_relu_fc1;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cenb_relu_fc1_buf <= 1;
		end
		else begin
			cenb_relu_fc1_buf <= ~qa_relu_fc1_en;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			ab_relu_fc1_buf <= 0;
		end
		else if (fc1_go) begin
			ab_relu_fc1_buf <= 0;
		end
		else if (!cenb_relu_fc1_buf) begin
			ab_relu_fc1_buf <= ab_relu_fc1_buf + 1;
		end
	end
	//=================FC2============================================================
	
	wire		[`WDP_WEIGHT*`OUTPUT_NUM_FC1*`OUTPUT_NUM_FC2 -1:0]		qa_weight_fc2_rom;
	wire		[11:0]	aa_weight_fc2;
	wire		[`W_OUTPUT_BATCH:0]								aa_bias_fc2;
	wire		[`WDP_BIAS*`OUTPUT_NUM_FC2 -1:0]				qa_bias_fc2;
	
	wieght_fc2_rom wieght_fc2_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.aa				(aa_weight_fc2),
		.cena			(cena_relu_fc1_buf),
//output
		.qa				(qa_weight_fc2_rom)
		);
	bias_fc2_rom bias_fc2_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.aa				(aa_bias_fc2),
		.cena			(cena_relu_fc1_buf),
//output
		.qa				(qa_bias_fc2)
		);
	
		
	wire	fc2_go = fc1_ready;
	iterator_conv  #(
		.OUTPUT_BATCH	(`OUTPUT_BATCH_FC2),
		.KERNEL_SIZEX	(`KERNEL_SIZEX_FC2),
		.KERNEL_SIZEY	(`KERNEL_SIZEY_FC2),
		.STEP			(1),
		.INPUT_WIDTH	(`INPUT_WIDTH_FC2),
		.INPUT_HEIGHT	(`INPUT_HEIGHT_FC2)
		)iterator_fc2(
//input
		.clk				(clk),
		.rstn				(rstn),
		.go				(fc2_go),
//output
		.first_data			(first_data_fc2),
		.last_data			(last_data_fc2),
		.aa_bias			(aa_bias_fc2),
		.aa_data			(aa_relu_fc1_buf),
		.aa_weight			(aa_weight_fc2),
		.cena				(cena_relu_fc1_buf),
		.ready          	(fc2_ready)
	); 
	
	reg		[15:0]	cena_relu_fc1_buf_d;
	always @(*)	cena_relu_fc1_buf_d[0] = cena_relu_fc1_buf;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cena_relu_fc1_buf_d[15:1] <= 0;
		end
		else begin
			cena_relu_fc1_buf_d[15:1] <= cena_relu_fc1_buf_d;
		end
	end
	reg		[15:0]	first_data_fc2_d;
	always @(*)	first_data_fc2_d[0] = first_data_fc2;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			first_data_fc2_d[15:1] <= 0;
		end
		else begin
			first_data_fc2_d[15:1] <= first_data_fc2_d;
		end
	end
	reg		[15:0]	last_data_fc2_d;
	always @(*)	last_data_fc2_d[0] = last_data_fc2;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			last_data_fc2_d[15:1] <= 0;
		end
		else begin
			last_data_fc2_d[15:1] <= last_data_fc2_d;
		end
	end
	wire	[`WDP_Q_FC2*`OUTPUT_NUM_FC2 -1:0] q_fc2;		
	conv #(
		.INPUT_NUM		(`OUTPUT_NUM_FC1),
		.OUTPUT_NUM		(`OUTPUT_NUM_FC2),
		.WIGHT_SHIFT		(`WIGHT_SHIFT_FC2),
		.WDP			(`WDP_Q_FC1),
		.WDP_OUT		(`WDP_FC2),
		.WDP_Q			(`WDP_Q_FC2),
		.WDP_WEIGHT		(`WDP_WEIGHT),
		.WDP_BIAS		(`WDP_BIAS)
		)conv_fc2(
//input
		.clk			(clk),
		.rstn			(rstn),
		.en				(~cena_relu_fc1_buf_d[1]),
		.first_data		(first_data_fc2_d[1]),
		.last_data		(last_data_fc2_d[1]),
		.data_i			(qa_relu_fc1_buf),
		.bias			(qa_bias_fc2),
		.weight			(qa_weight_fc2_rom),
//output
		.q              (q_fc2),
		.q_en           (q_fc2_en)
		);
	wire	[`WDP_Q_FC2*`OUTPUT_NUM_FC2 -1:0] qa_relu_fc2;		
	relu #(
		.INPUT_NUM (`OUTPUT_NUM_FC2),   // input plane_num
		.WDP		(`WDP_Q_FC2)
	) relu_fc2(
//input
		.clk				(clk),
		.rstn				(rstn),
		.en				(q_fc2_en),
		.data_i				(q_fc2),
//output	
		.q_en				(qa_relu_fc2_en),
		.q				(qa_relu_fc2)
	);	
	wire		[11:0]	aa_relu_fc2_buf;
	wire				cena_relu_fc2_buf;
	reg		[11:0]	ab_relu_fc2_buf;
	reg		[`WDP_Q_FC2*`OUTPUT_NUM_FC2 -1:0]	db_relu_fc2_buf;
	reg				cenb_relu_fc2_buf;
	wire	[`WDP_Q_FC2*`OUTPUT_NUM_FC2 -1:0]	qa_relu_fc2_buf;
	
	buffer #(
		.WWORD	(`WDP_Q_FC2*`OUTPUT_NUM_FC2),
		.DEPTH	(32)
		)buffer_relu_fc2(
//input
		.clka   (clk),
		.cena   (cena_relu_fc2_buf),
		.aa     (aa_relu_fc2_buf),
		.clkb   (clk),
		.cenb   (cenb_relu_fc2_buf),
		.ab     (ab_relu_fc2_buf),
		.db     (db_relu_fc2_buf),
//output
		.qa     (qa_relu_fc2_buf)
		);

	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			db_relu_fc2_buf <= 0;
		end
		else begin
			db_relu_fc2_buf <= qa_relu_fc2;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cenb_relu_fc2_buf <= 1;
		end
		else begin
			cenb_relu_fc2_buf <= ~qa_relu_fc2_en;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			ab_relu_fc2_buf <= 0;
		end
		else if (fc2_go) begin
			ab_relu_fc2_buf <= 0;
		end
		else if (!cenb_relu_fc2_buf) begin
			ab_relu_fc2_buf <= ab_relu_fc2_buf + 1;
		end
	end
	
	//=================FC3============================================================

	wire		[`WDP_WEIGHT*`OUTPUT_NUM_FC2*`OUTPUT_NUM_FC3 -1:0]		qa_weight_fc3_rom;
	wire		[11:0]	aa_weight_fc3;
	wire		[`W_OUTPUT_BATCH:0]								aa_bias_fc3;
	wire		[`WDP_BIAS*`OUTPUT_NUM_FC3 -1:0]				qa_bias_fc3;
	
	wieght_fc3_rom wieght_fc3_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.aa			(aa_weight_fc3),
		.cena			(cena_relu_fc2_buf),
//output
		.qa				(qa_weight_fc3_rom)
		);
	bias_fc3_rom bias_fc3_rom(
//input
		.clk			(clk),
		.rstn			(rstn),
		.aa				(aa_bias_fc3),
		.cena			(cena_relu_fc2_buf),
//outputfc3_ready
		.qa				(qa_bias_fc3)
		);
	
		
	wire	fc3_go = fc2_ready;
	iterator_conv  #(
		.OUTPUT_BATCH	(`OUTPUT_BATCH_FC3),
		.KERNEL_SIZEX	(`KERNEL_SIZEX_FC3),
		.KERNEL_SIZEY	(`KERNEL_SIZEY_FC3),
		.STEP			(1),
		.INPUT_WIDTH	(`INPUT_WIDTH_FC3),
		.INPUT_HEIGHT	(`INPUT_HEIGHT_FC3)
		)iterator_fc3(
//input
		.clk				(clk),
		.rstn				(rstn),
		.go				(fc3_go),
//output
		.first_data			(first_data_fc3),
		.last_data			(last_data_fc3),
		.aa_bias			(aa_bias_fc3),
		.aa_data			(aa_relu_fc2_buf),
		.aa_weight			(aa_weight_fc3),
		.cena				(cena_relu_fc2_buf),
		.ready         		 	(fc3_ready)
	); 
	
	reg		[15:0]	cena_relu_fc2_buf_d;
	always @(*)	cena_relu_fc2_buf_d[0] = cena_relu_fc2_buf;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cena_relu_fc2_buf_d[15:1] <= 0;
		end
		else begin
			cena_relu_fc2_buf_d[15:1] <= cena_relu_fc2_buf_d;
		end
	end
	reg		[15:0]	first_data_fc3_d;
	always @(*)	first_data_fc3_d[0] = first_data_fc3;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			first_data_fc3_d[15:1] <= 0;
		end
		else begin
			first_data_fc3_d[15:1] <= first_data_fc3_d;
		end
	end
	reg		[15:0]	last_data_fc3_d;
	always @(*)	last_data_fc3_d[0] = last_data_fc3;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			last_data_fc3_d[15:1] <= 0;
		end
		else begin
			last_data_fc3_d[15:1] <= last_data_fc3_d;
		end
	end
	
	wire	[`WDP_Q_FC3*`OUTPUT_NUM_FC3 -1:0] q_fc3;		
	conv #(
		.INPUT_NUM		(`OUTPUT_NUM_FC2),
		.OUTPUT_NUM		(`OUTPUT_NUM_FC3),
		.WIGHT_SHIFT		(`WIGHT_SHIFT_FC3),
		.WDP			(`WDP_Q_FC2),
		.WDP_OUT		(`WDP_FC3),
		.WDP_Q			(`WDP_Q_FC3),
		.WDP_WEIGHT		(`WDP_WEIGHT),
		.WDP_BIAS		(`WDP_BIAS)
		)conv_fc3(
//input
		.clk			(clk),
		.rstn			(rstn),
		.en				(~cena_relu_fc2_buf_d[1]),
		.first_data		(first_data_fc3_d[1]),
		.last_data		(last_data_fc3_d[1]),
		.data_i			(qa_relu_fc2_buf),
		.bias			(qa_bias_fc3),
		.weight			(qa_weight_fc3_rom),
//output
		.q         		(q_fc3),
		.q_en           	(q_fc3_en)
		);
	reg	signed	[`WDP_Q_FC3-1:0]	q_fc_fc3_max;
	reg			[5:0]	q_fc3_index;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			q_fc3_index <= 0;
		end
		else if (fc3_go) begin
			q_fc3_index <= 0;
		end
		else if (q_fc3_en) begin
			q_fc3_index <= q_fc3_index + 1;
		end
	end
	
	wire	gt_f = $signed(q_fc3) > $signed(q_fc_fc3_max);
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			q_fc_fc3_max <= 0;
		end
		else if (fc3_go) begin
			q_fc_fc3_max <= 1 << (`WDP_Q_FC3-1);
		end
		else if (q_fc3_en) begin		
			if (gt_f) begin
				q_fc_fc3_max <= q_fc3;
			end
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			digit <= 0;
		end
		else if (fc3_go) begin
			digit <= 0;
		end
		else if (q_fc3_en) begin	
			if (gt_f) begin
				digit <= q_fc3_index;	
			end
		end
	end
	reg		[15:0]	fc3_ready_d;
	always @(*)	fc3_ready_d[0] = fc3_ready;

	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			en_text_lcd <= 1;
		end
		else begin
			en_text_lcd <= ~q_fc3_en;
		end
	end
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			fc3_ready_d[15:1] <= 0;
		end
		else begin
			fc3_ready_d[15:1] <= fc3_ready_d;
		end
	end
	assign ready = 	fc3_ready_d[6];
	
endmodule
