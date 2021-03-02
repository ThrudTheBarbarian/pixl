`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
//
// Testbench for pixl logic
//
///////////////////////////////////////////////////////////////////////////////

module pixl_tb;

	reg clk200, a8_clk;
	
	///////////////////////////////////////////////////////////////////////////
	// Instantiate an MPD decoder
	///////////////////////////////////////////////////////////////////////////
	reg		[15:0]	a8_addr;
	reg		[7:0]	a8_data;
	reg				a8_rw_n;
	reg				a8_halt_n;
	reg				a8_irq_n;
	reg				a8_rst_n;
	reg				a8_rd5;
	reg				a8_rd4;
	reg				a8_ref_n;
	
	wire			a8_mpd_n;
	wire			a8_extsel_n;
	
	wire			mpd;
	
	pixl dut
		(
		.clk200(clk200),
		.a8_clk(a8_clk),
		.a8_rw_n(a8_rw_n),
		.a8_halt_n(a8_halt_n),
		.a8_irq_n(a8_irq_n),
		.a8_addr(a8_addr),
		.a8_data(a8_data),
		.a8_rst_n(a8_rst_n),
		.a8_rd5(a8_rd5),
		.a8_rd4(a8_rd4),
		.a8_ref_n(a8_ref_n),
		.a8_mpd_n(a8_mpd_n),
		.a8_extsel_n(a8_extsel_n)
		);
	
	///////////////////////////////////////////////////////////////////////////
	// Set everything going
	///////////////////////////////////////////////////////////////////////////
    initial
        begin
            $dumpfile("/tmp/wave.vcd");
            $dumpvars(0, pixl_tb);
                
            		clk200 		= 1'b0;
            		a8_clk 		= 1'b0;
					a8_rw_n		= 1'b1;
            		a8_rst_n   	= 1'b1;
            		a8_halt_n	= 1'b1;
            		a8_addr	 	= 16'h0;
            		a8_data	 	= 16'h0;
            		a8_rd5		= 1'b0;
            		a8_rd4		= 1'b0;
            		a8_ref_n	= 1'b1;
            		
					
			#576 	a8_rst_n	= 1'b0;
			
			#576 	a8_rst_n	= 1'b1;
			
			#576 	
            		a8_addr		= 16'h600;
            		a8_data		= 8'h70;

			#576 	
            		a8_addr		= 16'hd600;
            		a8_data		= 8'h90;
            		a8_rw_n		= 1'b0;
			
			#576 	
					a8_rw_n		= 1'b1;

            #576 	$finish;
		end


	///////////////////////////////////////////////////////////////////////////
	// Toggle the clocks indefinitely
	///////////////////////////////////////////////////////////////////////////
    always 
        	#2.5 		clk200 = ~clk200;
    always 
			#288	a8_clk = ~a8_clk;
endmodule

