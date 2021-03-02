`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
//
// Testbench for pixl logic
//
///////////////////////////////////////////////////////////////////////////////

module page_map_tb;

	reg clk200;
	reg rst_n;
	

	///////////////////////////////////////////////////////////////////////////
	// Instantiate a page_map 
	///////////////////////////////////////////////////////////////////////////
	reg		[1:0]	op;
	reg		[7:0]	from;
	reg		[7:0]	size;
	
	wire			valid;
	wire	[255:0]	mask;
	
	
	page_map dut
		(
		.clk200(clk200),
		.a8_rst_n(rst_n),
		.op(op),
		.from(from),
		.size(size),
		.valid(valid),
		.map(mask)
		);
	
	///////////////////////////////////////////////////////////////////////////
	// Set everything going
	///////////////////////////////////////////////////////////////////////////
    initial
        begin
            $dumpfile("/tmp/page.vcd");
            $dumpvars(0, page_map_tb);
                
            		clk200 		= 1'b0;
            		rst_n   	= 1'b1;
            		op			= 2'b0;
            		from	 	= 8'h0;
            		size	 	= 8'h0;
            		
					
			#5 		rst_n		= 1'b0;
			
			#5 		rst_n		= 1'b1;
			
			#5 	
            		op			= 2'b1;
            		from		= 8'h6;
            		size		= 8'h4;
            
            #5		op			= 2'b0;
            

			#50 	
            		op			= 2'h2;
            		from		= 8'h6;
            		size		= 8'h2;
            
            #5		op			= 2'b0;
			
			#50 	$finish;
		end


	///////////////////////////////////////////////////////////////////////////
	// Toggle the clocks indefinitely
	///////////////////////////////////////////////////////////////////////////
    always 
        	#2.5 		clk200 = ~clk200;
endmodule

