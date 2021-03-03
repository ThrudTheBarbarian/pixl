`timescale 1ns/1ns
`include "defines.v"

///////////////////////////////////////////////////////////////////////////////
// RAM block that backs the 2 pages between 0xD600 and 0xD7FF. The first page
// is taken up with memory-aperture descriptors.Layout looks like:
//    
// $+0000 [4]	: Base address in SDRAM for start of memory aperture
// $+0004 [1]	: Page index in host-memory for start of memory aperture
// $+0005 [1]	: Number of 256-byte pages to map
// $+0006 [1]	: 'stride', or 256-byte pages per horizontal line
// $+0007 [2]	: X position in bytes within the defined descriptor range
// $+0009 [2]	: Y position in lines within the defined descriptor range
// $+000B [2]	: Width in bytes within the defined descriptor range
// $+000D [2]	: Height in lines within the defined descriptor range
// $+000F [1]   : Flags for this memory aperture
// 
//
///////////////////////////////////////////////////////////////////////////////
module cfg_ram
	(
	input				clk200, 		// Clock signal
	input		[8:0]	addr,			// Address to read/write
	input 				we,				// Write-enable
	input		[7:0]	wdata,			// Data to write
	output	reg	[7:0]	rdata			// Data read from RAM
	); 	

	reg [7:0] mem [511:0];
	
	// Blocking Statement and order indicates write before read 
	always @ (posedge clk200) 
		begin
			if (we) 
				begin
					mem[addr] = wdata;
				end
			rdata = mem[addr]; 
		end
endmodule