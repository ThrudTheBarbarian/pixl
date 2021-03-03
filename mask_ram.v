`timescale 1ns/1ns
`include "defines.v"

///////////////////////////////////////////////////////////////////////////////
// RAM block that holds the mask values for bit-shifting. This can be 
// considered a ROM since there's no write-access
//
///////////////////////////////////////////////////////////////////////////////
module mask_ram
	(
	input				clk200,
	input		[7:0]	addr, 
	output reg	[255:0]	data
	); 
	
	reg [255:0] mem [255:0];

	initial
		begin
			$readmemh("mask_ram.hex", mem);
		end 
	
	always @ (posedge clk200)	
		begin
			data = mem[addr]; 
		end
		
endmodule