`include "global.sv"
`include "timescale.sv"
module clk_R(
	input					clk,
	input					rstn,
	input					en,
	input					key_1,
	
	
	output	reg		push,	//GPIO_0 (11, GPIO.IN)
	output	reg		clk_R
	);
	
	
	reg	[1:0]			din;
	
	always @(posedge clk, negedge rstn) begin
		if(rstn == 0) begin
			din	<=	2'd0;
			push	<=	1'b0;
		end
		else begin
			if(en == 1) begin
				din[0]	<=	~key_1;
				din[1]	<=	din[0];
				if(din[0] == 1 && din[1] == 0) begin
					push	<=	1'b1;
				end
				else begin
					push	<=	1'b0;
				end
			end
			else begin
				din	<=	2'b0;
				push	<=	1'b0;
			end
		end
	end
	
	reg	[16:0]		cnt_R;
	
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cnt_R	<=	17'd0;
			clk_R	<=	1'b1;
		end
		else begin
			if(en == 1) begin
				if (cnt_R == 17'd0) begin
					cnt_R	<=	17'd2499;
					clk_R	<=	~clk_R;
				end
				else begin
					cnt_R	<=	cnt_R - 1'b1;
				end
			end
			else begin
				cnt_R	<=	17'd0;
				clk_R	<=	1'b1;
			end
		end
	end
endmodule
