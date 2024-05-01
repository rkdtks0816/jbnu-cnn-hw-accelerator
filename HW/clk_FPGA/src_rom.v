`include "global.sv"
`include "timescale.sv"
module src_rom(
/////----------------------------------------/////
	input                   clk,
	input                   rstn, 	

	input                   igo, 			// GPIO_2

	input                   rpi_en,  		// GPIO_6
	input                   rpi_wen, 		// GPIO_8
	input   	[`WD:0] 	      io,
	input							cena,
	input		[11:0]			aa,

	output	reg				ready,
	output	reg	[`WD:0]	qa,
	output                  rpi_start 		// GPIO_4
);



	reg             wren; 
	reg             wclk;
	reg             wcnt_en;

	reg             start_en; 
	reg             start; 

	reg     [12:0]   waddr; 
	reg     [`WD:0]   wdin;         
	/////----------------------------------------/////
	always @(posedge clk) begin
		if (rstn == 0) begin
			wren        <= 1'b0; 
			wclk        <= 1'b0;
			wcnt_en     <= 1'b0;
			start_en    <= 1'b0; 
			start       <= 1'b0; 
			wdin        <= 8'd0;         
		end
		else begin
			wren        <= rpi_wen; 
			wclk        <= rpi_en; 
			wcnt_en     <= rpi_en & ~wclk; 
			start_en    <= igo; 
			start       <= igo & ~start_en; 
			if (wren == 1) begin
				 wdin        <= io;
			end
			else begin
				 wdin        <= 8'd0;
			end
		end
	end

	reg	[1:0]			din;
	reg					go;

	reg	        		state;
   parameter         RDY = 0, WRO = 1; 
	reg               req; 
	assign      		rpi_start = req;
	wire		[7:0]		q_dpram;

	/////----------------------------------------/////
	always @(posedge clk) begin
		if (rstn == 0) begin
			state   <= RDY;
			req     <= 1'b0; 
			waddr   <= 12'd0; 
			go 	  <= 1'b0;  
		end
		else begin            
			case (state)
					 RDY: begin
						  if (start == 1) begin
								state   <= WRO;
								waddr   <= 3'd0;
								req     <= 1'b1; 
						  end
					 end
										  
					 WRO: begin
						  if (wcnt_en == 1) begin                        
								if (waddr == 12'd783) begin
									 state   <= RDY;
									 waddr   <= 3'd0;   
									 req     <= 1'b0;    
									 go     	<= 1'b1;        
								end
								else begin
									 waddr   <= waddr + 1'b1;
									 req     <= 1'b1;     
									 go     	<= 1'b0;
								end
						  end
					 end				 
			endcase
		end        
	end	
 

	always @(posedge clk, negedge rstn) begin
		if(rstn == 0) begin
			din	<=	2'd0;
			ready	<=	1'b0;
		end
		else begin
			din[0]	<=	go;
			din[1]	<=	din[0];
			if(din[0] == 1 && din[1] == 0) begin
				ready	<=	1'b1;
			end
			else begin
				ready	<=	1'b0;
			end
		end
	end
    
/////----------------------------------------/////
	dpram U0(
		 .data           ({8'd0, wdin}),
		 
		 .wraddress      (waddr),
		 .wrclock        (wcnt_en),
		 .wren           (wren),
		 
		 .rdaddress      (aa),
		 .rdclock        (clk),
		 .q              (q_dpram)
	);

	always @(posedge clk)
		if (rstn == 0)			qa <= 0;
		else if (!cena)		qa <= q_dpram;
		
endmodule
