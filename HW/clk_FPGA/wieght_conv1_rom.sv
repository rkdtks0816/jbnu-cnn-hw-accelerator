`include "global.sv"
`include "timescale.sv"
module wieght_conv1_rom(
	input			clk,
	input			rstn,
	input	[11:0]	aa,
	input			cena,
	output reg		[`WDP_WEIGHT*`OUTPUT_NUM_CONV1 -1:0]	qa
	);
	
	
	logic [0:`KERNEL_SIZE_CONV1*`KERNEL_SIZE_CONV1-1][0:`OUTPUT_NUM_CONV1-1][`WDP_WEIGHT-1:0] weight	 = {
18'd16401,  18'd3236,  18'd18873,  18'd14580,  -18'd26774,  18'd13586,  
18'd9116,  18'd10907,  18'd26038,  -18'd17968,  -18'd11729,  -18'd14320,  
18'd18766,  -18'd13655,  18'd9816,  -18'd5035,  18'd2603,  -18'd36662,  
-18'd5559,  -18'd15869,  -18'd4202,  18'd17782,  18'd7442,  -18'd12995,  
-18'd26239,  18'd4159,  18'd7564,  -18'd5027,  18'd12507,  -18'd2790,  

18'd25969,  18'd17706,  -18'd2359,  18'd13862,  -18'd10709,  -18'd1248,  
18'd5955,  18'd12365,  18'd8588,  -18'd11305,  18'd3565,  -18'd19938,  
18'd37,  -18'd23430,  18'd6907,  -18'd6259,  18'd14998,  -18'd34947,  
18'd2616,  -18'd19819,  -18'd9046,  18'd11994,  18'd13367,  18'd225,  
-18'd27380,  18'd343,  18'd6858,  18'd14215,  18'd10878,  18'd14737,  

18'd27034,  18'd25701,  18'd8605,  -18'd10490,  -18'd21324,  18'd3279,  
18'd12556,  18'd7357,  -18'd8416,  -18'd29110,  18'd10483,  -18'd23786,  
18'd10574,  -18'd26084,  -18'd19393,  -18'd16584,  18'd7762,  -18'd15189,  
-18'd18273,  -18'd4562,  -18'd29022,  18'd21984,  18'd30225,  -18'd8357,  
-18'd22777,  18'd5028,  18'd11953,  18'd3829,  18'd29554,  18'd9389,  

18'd17395,  18'd21184,  -18'd2568,  -18'd10042,  -18'd13133,  18'd18400,  
18'd18158,  18'd16682,  18'd3872,  -18'd18350,  -18'd10331,  -18'd11811,  
18'd2211,  -18'd24331,  -18'd14669,  -18'd1965,  18'd17903,  -18'd428,  
-18'd14675,  -18'd3192,  -18'd42447,  18'd7468,  18'd27635,  18'd13131,  
-18'd32741,  18'd14308,  -18'd18,  -18'd2722,  18'd8596,  18'd23860,  

18'd19030,  18'd16889,  18'd18787,  18'd12193,  -18'd139,  18'd17205,  
18'd24905,  18'd14305,  18'd1775,  18'd12307,  -18'd12883,  18'd11704,  
18'd3864,  -18'd14810,  -18'd16638,  18'd13161,  18'd15665,  18'd26936,  
-18'd6963,  -18'd12408,  -18'd22718,  18'd6010,  18'd18778,  18'd18961,  
-18'd24156,  -18'd5395,  18'd27685,  -18'd9025,  18'd17964,  18'd19317
		};
	
	always @(posedge clk) begin
		if (rstn == 0) begin
			qa <= 0;
		end
		else if (!cena) begin
			qa <= weight[aa];
		end
	end
	
endmodule	

