`include "global.sv"
`include "timescale.sv"

module src_rom(
	input				clk,
	input				rstn,
	input				go,
	input		[`WD:0]		data_i,
	input				cena,
	input		[11:0]		aa,

	output	reg			ready,
	output	reg	[`WD:0]		qa
	);

	reg	[`WD:0]		db;
	reg	[10:0]		ab;
	reg			cenb;
	wire			ab_max = ab == 10'd783;
	wire			end_cenb = ab_max;

	always @(`CLK_RST_EDGE)
		if (`RST)			cenb <= 0;
		else if (go)			cenb <= 1;
		else if (end_cenb)		cenb <= 0;

	always @(`CLK_RST_EDGE)
		if (`RST)	ab <= 0;
		else if(cenb)	ab <= ab_max? 0: ab + 1;

	always @(`CLK_RST_EDGE)
		if (`RST)	ready <= 0;
		else 		ready <= end_cenb;

	always @(`CLK_RST_EDGE)
		if (`RST)	db <= 0;
		else 		db <= data_i;
	
	reg				[`WD:0]	mem[0:784];

	always @(posedge clk) if (cenb)	mem[ab] <= db;

	always @(posedge clk) if (!cena)	qa <= mem[aa];
	
endmodule
