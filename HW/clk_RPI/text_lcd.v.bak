`include "global.sv"
`include "timescale.sv"
module text_lcd(
	input			clk,
	input			rstn,
	input			go,
	input			en,
	input	[5:0]		digit,
	
	output	reg		ready,
	output			lcd_en,
	output			lcd_rs,
	output			lcd_rw,
	output			lcd_on,
	output	[7:0]		lcd_dout
	);
	
	reg	[16:0]		cnt_1k;
	reg			clk_1k;
	always @(posedge clk, negedge rstn) begin
		if (rstn == 0) begin
			cnt_1k	<=	17'd0;
			clk_1k	<=	1'b1;
		end
		else begin
			if(en == 1) begin
				if (cnt_1k == 17'd0) begin
					cnt_1k	<=	17'd24999;
					clk_1k	<=	~clk_1k;
				end
				else begin
					cnt_1k	<=	cnt_1k - 1'b1;
				end
			end
			else begin
				cnt_1k	<=	17'd0;
				clk_1k	<=	1'b1;
			end
		end
	end

	reg			rs;
	reg			rw;
	reg	[7:0]		dt;
	reg	[7:0]		cnt;
	
	reg			cnt_en;
	wire			cnt_max_f = cnt == 8'd17;
	wire			end_cnt_en = cnt_max_f;

	always @(posedge clk_1k, negedge rstn) begin
		if (rstn == 0) begin
			rs	<=	1'b0;
			rw	<=	1'b0;
			dt	<=	8'h00;
			cnt	<=	8'd0;
		end
		else	begin
			if (`RST)				cnt_en <= 1'b0;
			else if (go)			cnt_en <= 1'b1;
			else if (end_cnt_en)	cnt_en <= 1'b0;

			if (`RST)			cnt <= 1'b0;
			else if(cnt_en)	cnt <= cnt_max_f? 1'b0: cnt+ 1'b1;
			else				cnt <= 1'b0;

			if(digit == 5'd0) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h41};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd1) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h42};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd2) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h43};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd3) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd4) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd5) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h46};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd6) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h47};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd7) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h48};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd8) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd9) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h4a};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd10) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h4b};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd11) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h4c};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd12) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h4d};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd13) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd14) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h4f};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd15) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h50};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd16) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h51};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd17) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h52};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd18) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h53};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd19) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h54};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd20) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h55};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd21) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h56};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd22) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h57};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd23) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
			else if(digit == 5'd24) begin
				case (cnt)
						8'd0	:	{rs, rw, dt}	<=	{2'b00, 8'h80};
						8'd1	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd2	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd3	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd4	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd5	:	{rs, rw, dt}	<=	{2'b10, 8'h49};
						8'd6	:	{rs, rw, dt}	<=	{2'b10, 8'h4e};
						8'd7	:	{rs, rw, dt}	<=	{2'b10, 8'h44};
						8'd8	:	{rs, rw, dt}	<=	{2'b10, 8'h45};
						8'd9	:	{rs, rw, dt}	<=	{2'b10, 8'h58};
						8'd10	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd11	:	{rs, rw, dt}	<=	{2'b10, 8'h3a};
						8'd12	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd13	:	{rs, rw, dt}	<=	{2'b10, 8'h59};
						8'd14	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd15	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
						8'd16	:	{rs, rw, dt}	<=	{2'b10, 8'h20};
				endcase
			end
		end
	end
	
	assign	lcd_en = ~clk_1k;
	assign	lcd_rs = rs;
	assign	lcd_rw = rw;
	assign	lcd_dout = dt;
	assign	lcd_on = en;

	always @(`CLK_RST_EDGE)
		if (`RST)	ready <= 1'b0;
		else 		ready <= end_cnt_en;
	
endmodule