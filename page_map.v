`timescale 1ns/1ns
`include "defines.v"

///////////////////////////////////////////////////////////////////////////////
// Page map module. 
//
// Keeps a 256-bit register-map updated so we know when to map SDRAM in for the
// A8 and allows manipulation of the map.
//
// NOTE: 'op' is a signal that is designed to be sent once and reset
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
	localparam STATE_MASK_WAIT		= 0;
	localparam STATE_MASK_READ		= 1;
	localparam STATE_MASK_SHIFT		= 2;
	localparam STATE_MASK_COMBINE	= 3;
	
	
	///////////////////////////////////////////////////////////////////////////
	// Instantiate a block-ram to read the mask value from. There's a few ways
	// we could do this - either a 256-long case statement, or a binary-powers
	// assign done over 8 clocks, or the block-ram. At this point, we have a
	// surfeit of block-rams and I'd like to limit LUT use, so we'll try the
	// blockram approach for now. It uses 13 out of the 208 available.
	///////////////////////////////////////////////////////////////////////////
	wire 	[255:0]			mask_bits;		// Working values
	reg		[255:0]			shifted_bits;	// .. after shift
	reg		[7:0]			mask_addr;		// The address pointer
	
	mask_ram mask1
		(
		.clk200(clk200),
		.addr(mask_addr),
		.data(mask_bits)
		);

	///////////////////////////////////////////////////////////////////////////
	// Handle the second-stage selection - move the mask_bits up by N
	///////////////////////////////////////////////////////////////////////////
	reg		[7:0]			shift;
	wire	[511:0]			extended	= {mask_bits, 256'b0};
	wire	[8:0]			at			= 511 - shift; 
		
	///////////////////////////////////////////////////////////////////////////
	// Local work registers
	///////////////////////////////////////////////////////////////////////////
	reg [1:0] 	state;
	reg	[1:0]	action;
	
	always @ (posedge clk200)
		if (a8_rst_n == 1'b0)
			begin
				map 			<= 256'h00;
				state			<= STATE_MASK_WAIT;
				shift			<= 8'h0;
				action			<= `OP_NONE;
				valid			<= 1'b1;
			end
		else 
			case (state)
				STATE_MASK_WAIT:
					begin
					if (op != `OP_NONE) 
						begin
							mask_addr 	<= size;
							state		<= STATE_MASK_READ;
							action		<= op;
							shift		<= from;
							valid		<= 1'b0;
						end
					end
				
				STATE_MASK_READ:
					state				<= STATE_MASK_SHIFT;

				STATE_MASK_SHIFT:
					begin
						shifted_bits	<= extended[at -:256];
						state 			<= STATE_MASK_COMBINE;
					end
					
				STATE_MASK_COMBINE:
					begin
						if (action == `OP_ADD)
							map <= map | shifted_bits;
						else
							map <= map & (~shifted_bits);
							
						state  <= STATE_MASK_WAIT;
						valid  <= 1'b1;
					end
			endcase				
endmodule