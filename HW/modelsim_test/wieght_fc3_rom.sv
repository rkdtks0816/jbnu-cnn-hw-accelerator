`include "global.sv"
`include "timescale.sv"
module wieght_fc3_rom(
	input			clk,
	input			rstn,
	input	[11:0]	aa,
	input			cena,
	output reg		[`WDP_WEIGHT*`OUTPUT_NUM_FC2*`OUTPUT_NUM_FC3 -1:0]	qa
	);
	
	logic [0:`OUTPUT_BATCH_FC3*`KERNEL_SIZEX_FC3*`KERNEL_SIZEY_FC3-1][0:`OUTPUT_NUM_FC3-1][0:`OUTPUT_NUM_FC2-1][`WDP_WEIGHT-1:0] weight	 = {
-18'd15487,  18'd1373,  18'd2281,  18'd2147,  18'd26429,  18'd3049,  -18'd19424,  -18'd18746,  18'd15327,  18'd19634,  18'd1717,  -18'd31854,  -18'd14666,  -18'd3148,  -18'd33814,  -18'd29960,  
-18'd10978,  18'd17670,  -18'd39002,  -18'd28914,  -18'd19903,  18'd17168,  -18'd16459,  -18'd28991,  -18'd11675,  -18'd26041,  18'd7223,  18'd24071,  18'd942,  18'd8037,  18'd6150,  18'd10806,  

18'd31,  -18'd7437,  -18'd8530,  -18'd14203,  -18'd15972,  -18'd14633,  18'd1853,  18'd32909,  -18'd8661,  18'd23468,  -18'd23206,  18'd12301,  18'd12818,  -18'd11235,  -18'd563,  -18'd24049,  
18'd6694,  -18'd25032,  -18'd33912,  18'd30659,  18'd16442,  -18'd2199,  -18'd2276,  -18'd16071,  -18'd2523,  -18'd4601,  -18'd19457,  -18'd16663,  18'd22532,  -18'd6867,  -18'd18024,  -18'd28156,  

18'd30386,  -18'd6956,  18'd16768,  18'd4375,  18'd11564,  18'd6636,  -18'd20124,  -18'd37399,  -18'd2247,  -18'd12757,  -18'd26645,  -18'd7633,  18'd26614,  18'd15273,  -18'd11876,  -18'd47724,  
18'd9911,  -18'd958,  18'd14081,  -18'd3440,  -18'd30166,  -18'd10751,  18'd16778,  18'd18560,  -18'd17380,  18'd828,  18'd7978,  -18'd37886,  18'd1440,  -18'd12020,  -18'd6307,  -18'd14547,  

-18'd23635,  18'd28276,  -18'd1062,  -18'd8824,  18'd23602,  -18'd26267,  18'd509,  -18'd9812,  18'd18021,  18'd15430,  18'd7933,  -18'd25462,  -18'd5709,  18'd1652,  18'd12683,  18'd2257,  
-18'd14763,  -18'd22837,  18'd13735,  18'd26535,  18'd5045,  -18'd48045,  18'd5635,  -18'd42672,  18'd9311,  -18'd14696,  -18'd16605,  -18'd142,  -18'd25803,  18'd8383,  -18'd33834,  -18'd31605,  

18'd20707,  -18'd11540,  -18'd5765,  -18'd28528,  18'd10508,  18'd25879,  18'd6948,  -18'd3158,  -18'd16411,  18'd17702,  -18'd61029,  -18'd16545,  18'd17332,  18'd11872,  18'd13517,  -18'd48632,  
-18'd5474,  -18'd25055,  -18'd25300,  18'd2615,  18'd9938,  -18'd30190,  -18'd11075,  18'd19154,  18'd13724,  -18'd10639,  -18'd48940,  18'd173,  -18'd28754,  -18'd7926,  -18'd656,  18'd12924,  

18'd15262,  -18'd37472,  18'd29109,  -18'd12493,  18'd1480,  -18'd19880,  -18'd1010,  18'd15387,  18'd11213,  18'd3162,  -18'd39263,  18'd834,  -18'd25092,  18'd6661,  -18'd23488,  18'd6665,  
-18'd1525,  18'd17934,  18'd8507,  18'd21120,  -18'd9373,  18'd21294,  -18'd57227,  -18'd17496,  18'd19917,  -18'd37641,  18'd5465,  -18'd10419,  -18'd6263,  -18'd11830,  -18'd52435,  18'd20313,  

18'd12070,  -18'd8949,  -18'd14679,  -18'd5494,  18'd10675,  -18'd44125,  18'd5119,  -18'd18281,  18'd20650,  -18'd40303,  18'd13086,  18'd8965,  18'd13173,  18'd2080,  -18'd16320,  18'd4454,  
18'd32181,  -18'd3968,  18'd19527,  18'd6050,  -18'd38425,  -18'd20330,  -18'd23393,  18'd12808,  18'd22249,  18'd33584,  18'd1182,  -18'd26070,  -18'd12507,  -18'd18851,  -18'd58162,  18'd5791,  

-18'd30070,  18'd3089,  18'd1779,  18'd1676,  18'd19898,  -18'd40121,  18'd24310,  -18'd39626,  18'd21509,  18'd6030,  18'd18558,  18'd16801,  18'd21901,  -18'd21027,  -18'd2868,  -18'd25860,  
-18'd8618,  -18'd6884,  18'd14952,  -18'd7501,  18'd28333,  -18'd17438,  18'd1925,  -18'd14769,  -18'd46276,  18'd31997,  -18'd17432,  -18'd12232,  18'd16687,  -18'd19870,  -18'd36202,  18'd10124,  

-18'd27273,  -18'd12584,  18'd27938,  18'd19699,  -18'd8382,  18'd19661,  -18'd18189,  18'd22446,  18'd605,  18'd15474,  18'd13479,  -18'd100811,  -18'd41545,  18'd3028,  18'd3799,  -18'd24959,  
18'd23341,  18'd11155,  18'd11752,  -18'd25134,  -18'd38387,  -18'd5731,  -18'd7570,  -18'd6533,  -18'd10086,  -18'd11026,  -18'd12904,  -18'd13940,  -18'd1670,  18'd7651,  -18'd19021,  18'd20412,  

18'd9372,  -18'd11411,  -18'd5275,  -18'd552,  18'd5794,  18'd3397,  18'd10187,  -18'd25545,  -18'd419,  -18'd19073,  -18'd26067,  18'd10943,  18'd7731,  18'd20048,  -18'd9976,  -18'd10528,  
-18'd4900,  -18'd19495,  -18'd10060,  -18'd30131,  18'd5880,  -18'd27956,  -18'd27666,  18'd6350,  -18'd24683,  -18'd22919,  -18'd19419,  -18'd3229,  -18'd2428,  -18'd7580,  -18'd14023,  -18'd15970,  

-18'd15220,  18'd28149,  18'd19003,  18'd6635,  -18'd42449,  -18'd34152,  -18'd11576,  18'd4578,  -18'd18197,  18'd3280,  18'd26599,  18'd40187,  -18'd8975,  -18'd29310,  -18'd9720,  18'd8009,  
18'd849,  -18'd24747,  -18'd24531,  -18'd1646,  18'd20393,  -18'd14472,  -18'd7808,  18'd4005,  18'd122,  18'd19358,  18'd7556,  18'd23998,  -18'd3410,  -18'd4995,  18'd7584,  -18'd26734,  

18'd14266,  -18'd30591,  18'd32427,  -18'd20416,  -18'd5997,  18'd4692,  -18'd7065,  -18'd29671,  18'd17931,  -18'd35153,  18'd15791,  -18'd36022,  -18'd35826,  18'd18075,  18'd663,  -18'd13111,  
18'd22883,  18'd19467,  18'd11701,  18'd5344,  -18'd39326,  18'd12137,  18'd17512,  18'd21830,  -18'd6970,  18'd8153,  18'd17706,  -18'd23653,  18'd1133,  18'd13,  -18'd7625,  18'd6178,  

-18'd24118,  -18'd40942,  -18'd60811,  -18'd1791,  18'd18697,  18'd24246,  18'd13875,  18'd6341,  18'd12908,  18'd6736,  -18'd2494,  -18'd40309,  18'd1151,  18'd10414,  -18'd2051,  -18'd35787,  
-18'd24529,  18'd11988,  18'd18852,  -18'd18139,  -18'd9507,  -18'd43091,  -18'd9616,  18'd32367,  -18'd4756,  -18'd3138,  18'd4536,  -18'd3594,  18'd17160,  18'd8162,  -18'd47579,  -18'd6521,  

18'd16306,  18'd23077,  -18'd39573,  -18'd17285,  18'd15025,  18'd19727,  -18'd17655,  -18'd16749,  18'd23493,  18'd19074,  18'd9051,  -18'd10794,  18'd10968,  -18'd2231,  -18'd22994,  -18'd31072,  
-18'd47589,  18'd12196,  18'd8236,  -18'd15396,  18'd11959,  -18'd14056,  18'd2252,  -18'd22092,  -18'd2566,  18'd20290,  18'd16942,  18'd3212,  -18'd1593,  -18'd8926,  18'd5986,  -18'd38538,  

18'd19550,  -18'd54734,  18'd2259,  -18'd5618,  18'd8463,  18'd1493,  18'd10105,  18'd10473,  -18'd24901,  18'd12678,  -18'd36551,  18'd3899,  18'd23625,  -18'd8531,  -18'd45360,  -18'd16815,  
18'd22161,  -18'd1534,  18'd12407,  -18'd585,  -18'd782,  18'd29073,  -18'd236,  18'd5038,  -18'd19989,  18'd15154,  18'd1080,  18'd11279,  18'd8908,  18'd12726,  18'd17335,  -18'd26069,  

18'd10832,  18'd25576,  18'd5182,  18'd17248,  -18'd33374,  18'd8726,  -18'd34750,  -18'd19768,  -18'd37524,  -18'd13028,  18'd25083,  -18'd2600,  18'd22578,  18'd8622,  -18'd8520,  18'd16197,  
18'd21526,  -18'd6722,  18'd2737,  18'd18348,  -18'd34539,  -18'd25710,  -18'd19407,  18'd16520,  -18'd18378,  -18'd32237,  -18'd23689,  -18'd20283,  18'd7190,  18'd17977,  -18'd29472,  18'd28256,  

-18'd36336,  -18'd9469,  18'd4224,  -18'd36099,  18'd7946,  -18'd4340,  18'd11432,  -18'd1922,  -18'd26162,  -18'd17093,  18'd22556,  -18'd45174,  18'd23930,  18'd25207,  -18'd26552,  -18'd6296,  
18'd11936,  -18'd21036,  18'd11998,  18'd18590,  18'd10425,  18'd10096,  18'd16682,  18'd36323,  -18'd13483,  -18'd12992,  18'd8041,  -18'd4961,  18'd2052,  -18'd15504,  18'd14386,  18'd19001,  

-18'd63509,  18'd14858,  -18'd890,  -18'd4087,  -18'd5087,  -18'd10760,  -18'd25695,  -18'd15419,  -18'd16096,  -18'd20927,  -18'd1767,  -18'd21361,  -18'd37824,  -18'd17589,  18'd7911,  18'd21496,  
-18'd7955,  18'd4105,  -18'd39448,  18'd639,  18'd7057,  18'd34311,  18'd25019,  -18'd12573,  18'd28984,  -18'd692,  -18'd5768,  -18'd6783,  18'd22995,  -18'd2212,  -18'd40732,  -18'd4458,  

18'd9,  -18'd16457,  -18'd15494,  18'd5679,  18'd12701,  -18'd13259,  -18'd23325,  -18'd31303,  -18'd28185,  18'd16021,  18'd2795,  -18'd27021,  -18'd5779,  -18'd11973,  18'd19234,  -18'd32418,  
-18'd10024,  -18'd2157,  -18'd41,  -18'd6606,  -18'd33415,  -18'd14760,  -18'd7294,  18'd9200,  18'd21162,  -18'd11553,  18'd14505,  18'd20348,  18'd7727,  18'd7707,  18'd24401,  18'd5528,  

-18'd9897,  -18'd60177,  18'd8489,  18'd4982,  18'd3404,  -18'd4889,  -18'd13673,  18'd15819,  18'd28035,  -18'd22891,  -18'd9738,  -18'd13522,  18'd18561,  -18'd6789,  18'd546,  18'd11564,  
18'd2258,  18'd3266,  -18'd15482,  -18'd38173,  18'd25908,  18'd26070,  -18'd34429,  18'd10850,  18'd2770,  18'd11962,  18'd12520,  -18'd3345,  -18'd3942,  18'd4054,  18'd422,  18'd15698,  

-18'd12905,  18'd8947,  -18'd47174,  -18'd26399,  -18'd43059,  18'd12722,  18'd22500,  18'd22238,  18'd2018,  -18'd21843,  18'd20399,  18'd6205,  18'd7838,  18'd14470,  18'd3919,  -18'd9934,  
18'd3619,  18'd8933,  -18'd22799,  -18'd10543,  18'd10038,  -18'd43282,  -18'd8996,  -18'd12097,  18'd21472,  -18'd5490,  18'd7985,  18'd19016,  18'd17513,  -18'd18910,  18'd34891,  -18'd8256,  

-18'd8663,  -18'd23250,  -18'd3251,  18'd3952,  -18'd38843,  -18'd8459,  18'd6980,  -18'd3087,  -18'd12957,  -18'd11,  -18'd15417,  18'd7953,  -18'd20509,  -18'd2167,  18'd15438,  18'd22900,  
-18'd42672,  -18'd22842,  18'd25572,  18'd275,  -18'd17069,  18'd8085,  18'd14755,  -18'd29216,  18'd664,  18'd8022,  18'd8378,  -18'd7113,  18'd5780,  18'd17869,  18'd6399,  18'd12490,  

18'd2465,  -18'd47976,  -18'd6061,  18'd31752,  -18'd36050,  -18'd8232,  -18'd17196,  18'd4025,  18'd30812,  18'd303,  -18'd54508,  -18'd807,  -18'd3145,  18'd15256,  -18'd1110,  18'd27248,  
-18'd33658,  18'd5864,  -18'd55587,  18'd21913,  -18'd4806,  -18'd43238,  -18'd15993,  18'd11697,  -18'd5781,  -18'd27263,  -18'd4943,  18'd18327,  -18'd3029,  -18'd3432,  18'd19311,  -18'd9645,  

-18'd22147,  -18'd12109,  18'd17425,  -18'd31114,  18'd22612,  -18'd26879,  -18'd23656,  -18'd21421,  18'd10620,  -18'd21050,  -18'd8831,  18'd14008,  18'd6937,  18'd13693,  18'd19061,  18'd3465,  
-18'd14247,  18'd11881,  -18'd9042,  -18'd15522,  -18'd19643,  -18'd15123,  -18'd16860,  -18'd7475,  -18'd19725,  -18'd22184,  18'd9359,  18'd17369,  18'd25616,  18'd15460,  -18'd5543,  18'd11178,  

-18'd32640,  18'd25433,  18'd8610,  18'd11648,  -18'd12612,  -18'd37690,  -18'd6947,  -18'd11088,  18'd885,  18'd16201,  -18'd15251,  18'd2259,  -18'd64699,  18'd8546,  -18'd5134,  -18'd24082,  
18'd8977,  18'd9347,  18'd23734,  18'd14223,  -18'd12625,  -18'd22777,  18'd4908,  18'd6168,  -18'd32626,  18'd23807,  18'd27635,  18'd19868,  18'd8837,  -18'd1211,  -18'd28114,  18'd1352
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
