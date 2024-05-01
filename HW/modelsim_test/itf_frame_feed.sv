`include "global.sv"
`include "timescale.sv"
`define	MAX_PATH			256

interface itf_frame_feed(input clk);
	logic			go;
	logic			ready;
	
	clocking cb@(posedge clk);
		output	go;
		input 	ready;
	endclocking	

	task drive_frame(int nframe);
		integer						fd;
		integer						errno;
		reg			[640-1:0]		errinfo;
		static logic [`MAX_PATH*8-1:0]	sequence_name = "./test_1000f.yuv";
		go		 <= 0;
		@cb;
		@cb;
		
		fd = $fopen(sequence_name, "rb");
		if (fd == 0) begin
			errno = $ferror(fd, errinfo);
			$display("sensor Failed to open file %0s for read.", sequence_name);
			$display("errno: %0d", errno);
			$display("reason: %0s", errinfo);
			$finish();
		end
		
		for(int f = 0; f<nframe; f++ ) begin
			@cb;
			@cb;
			for(int i = 0; i< 28*28; i++ ) begin
				$root.lenet_tb.src_rom.mem[i] <= $fgetc(fd);
			end
			@cb;
			@cb;
			go		 <= 1;
			@cb;
			go		 <= 0;
			@cb.ready;
			@cb;
			@cb;
		end
	endtask

endinterface