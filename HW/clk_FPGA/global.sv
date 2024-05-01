
`define GOLBAL_INC

`define  WD_BIAS  	33
`define  WDP_BIAS  	34
`define  WDP_BIAS_CONV1	26
`define  WDP_WEIGHT  	18
`define  WD  	7
`define  WDP 	8

`define INPUT_NUM 1
`define OUTPUT_NUM 6


`define W_PLANEW   4
`define W_PLANEH   4
`define W_OUTPUT_BATCH   	11
`define W_KERNEL   			3

//CONV1
`define OUTPUT_BATCH_CONV1  1
`define OUTPUT_NUM_CONV1   	6
`define KERNEL_SIZEX_CONV1  5
`define KERNEL_SIZEY_CONV1 	5
`define KERNEL_SIZE_CONV1  	5
`define INPUT_WIDTH   		28
`define INPUT_HEIGHT  		28
`define WIGHT_SHIFT_CONV1 	8
`define WDP_CONV1		26
`define WDP_Q_CONV1      	18

//CONV2
`define OUTPUT_BATCH_CONV2  1
`define OUTPUT_NUM_CONV2   	16
`define KERNEL_SIZEX_CONV2  5
`define KERNEL_SIZEY_CONV2 	5
`define KERNEL_SIZE_CONV2  	5
`define INPUT_WIDTH_CONV2   12
`define INPUT_HEIGHT_CONV2  12
`define WIGHT_SHIFT_CONV2 	16
`define WDP_CONV2		36
`define WDP_Q_CONV2      	20

//FC1
`define OUTPUT_BATCH_FC1  64//120
`define OUTPUT_NUM_FC1    1
`define KERNEL_SIZEX_FC1  4//5
`define KERNEL_SIZEY_FC1  4//5
`define KERNEL_SIZE_FC1   4//5
`define INPUT_WIDTH_FC1   4//5
`define INPUT_HEIGHT_FC1  4//
`define WIGHT_SHIFT_FC1 	16
`define WDP_FC1			38
`define WDP_Q_FC1      		22

//FC2
`define OUTPUT_BATCH_FC2  32//84
`define OUTPUT_NUM_FC2    1
`define KERNEL_SIZEX_FC2  8//10
`define KERNEL_SIZEY_FC2  8//12
`define INPUT_WIDTH_FC2   8//10
`define INPUT_HEIGHT_FC2  8//12
`define WIGHT_SHIFT_FC2 	16
`define WDP_FC2			40
`define WDP_Q_FC2      		24


//FC3
`define OUTPUT_BATCH_FC3  25
`define OUTPUT_NUM_FC3    1
`define KERNEL_SIZEX_FC3  4//7
`define KERNEL_SIZEY_FC3  8//12
`define INPUT_WIDTH_FC3   4//7
`define INPUT_HEIGHT_FC3  8//12
`define WIGHT_SHIFT_FC3 	16
`define WDP_FC3			42
`define WDP_Q_FC3      		26
