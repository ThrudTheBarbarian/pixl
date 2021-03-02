`timescale 1ns/1ns
`include "defines.v"

///////////////////////////////////////////////////////////////////////////////
// Page map module. 
//
// Keeps a 256-bit register-map updated so we know when to map SDRAM in for the
// A8. 
///////////////////////////////////////////////////////////////////////////////
module page_map
    (
    input 					clk200,		// Main FPGA clock from PLL @ 200 MHz
	input					a8_rst_n,	// A8 /RST signal
	input		[1:0]		op,			// What to do
	input		[7:0]		from,		// Low page id
	input		[7:0]		size,		// Number of pages
	
	output reg				valid,		// The current state is valid
	output reg	[255:0]		map			// The actual map
	);
	
	///////////////////////////////////////////////////////////////////////////
	// Define some states we'll use to process the incoming data
	///////////////////////////////////////////////////////////////////////////
	localparam STATE_MASK_WAIT	= 0;
	localparam STATE_MASK_GEN	= 1;
	localparam STATE_MASK_SHIFT	= 2;
	
	///////////////////////////////////////////////////////////////////////////
	// Local work registers
	///////////////////////////////////////////////////////////////////////////
	reg [2:0] 	state 	= STATE_MASK_WAIT;
	reg	[7:0]	lo		= 0;
	reg	[7:0]	hi		= 0; 
	
	always @ (posedge clk)
		if (a8_rst_n == 1'b0)
			begin
				map 	<= 256'h0;
				state	<= STATE_MASK_WAIT;
			end
		else 
			case (state)
				STATE_MASK_GEN:
					begin
					end
			
				STATE_MASK_SHIFT:
					begin
					end
			
				STATE_MASK_WAIT:
					begin
						case (op)
							`OP:ADD: 
								begin
								end
						
							`OP_DEL:
								begin
								end
						
							default:
								;
						endcase
							
					end
				default:
					;
			endcase				

endmodule