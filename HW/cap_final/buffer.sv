`include "global.sv"
`include "timescale.sv"

module buffer #
	(
	parameter  WWORD = 32,
	parameter  DEPTH = 24
	)
	(
	input						clka,
	output reg		[WWORD-1:0]	qa,
	input			[11:0]	aa,
	input						cena,
	input						clkb,
	input			[WWORD-1:0]	db,
	input			[11:0]	ab,
	input						cenb
	);
	reg				[WWORD-1:0]	mem[0:DEPTH];
	
	always @(posedge clka) begin
		if (!cena) begin
			qa <= mem[aa];
		end
	end
	always @(posedge clkb) begin
		if (!cenb && ab < DEPTH) begin
			mem[ab] <= db;
		end
	end
endmodule

