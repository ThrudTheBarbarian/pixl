`timescale 1ns/1ns
`include "defines.v"

///////////////////////////////////////////////////////////////////////////////
// Bus monitor module. 
//
// Timings are:
//
//	|<------------------------- Cycle time 558ns ---------------------->|
//
//	|__________________________________|--------------------------------|
//
//	|<---- 177ns ---->|XXXXXXXXX Valid Address XXXXXXXXXXXXXXXXXXXXXXXXXXXX|
//
// 	|<------------------------------- 422ns ----------->|XXXXXXX Write XXXXXXX|
//
// 	|<------------------------------- 486ns --------------->|XXXX Read XXXX|
//
//
//	|<------- 195ns ------->| ExtenB
//  |_______________________|-------------------------------------------|
//
//	|<---------- 225 ns ----------| MPD
//  |-----------------------------|_____________________________________|
//
///////////////////////////////////////////////////////////////////////////////
module bus_a8
    (
    input 				clk200,			// Main FPGA clock from PLL @ 200 MHz
	input				a8_clk,			// A8 clock @ ~1.8MHz
	input				a8_rw_n,		// A8 read/write signal
	input				a8_halt_n,		// A8 /HALT signal
	input				a8_irq_n,		// A8 /IRQ signal
	input	[15:0]		a8_addr,		// A8 address bus
	input	[7:0]		a8_data,		// A8 data bus
	input				a8_rst_n,		// A8 /RST signal
	input				a8_rd5,			// A8 rd5 cartridge signal
	input				a8_rd4,			// A8 rd4 cartridge signal
	input				a8_ref_n,		// A8 Dram refresh (/REF) signal
	
	output reg			a8_mpd_n,		// A8 Math-Pak Disable (/MPD) signal
	output reg			a8_extsel_n		// A8 external selection signal
    );
	
	
    ///////////////////////////////////////////////////////////////////////////
    // Note that the TICK_xxx compensate for the synchroniser delay in finding
    // the clock edge 
    ///////////////////////////////////////////////////////////////////////////
	localparam 	TICK_BITS				= 7;		// Bits in the counter
	localparam 	TICK_ADDRESS_VALID		= 33;		// Address now valid
	localparam 	TICK_WRITE_VALID		= 82;		// Write data valid
	localparam 	TICK_READ_VALID			= 95;		// Read data valid
	
	localparam	PAGE_MEM_AP				= 8'hd6;	// Memory apertures here
	localparam	PAGE_MEM_CFG			= 8'hd7;	// Config page
	
    ///////////////////////////////////////////////////////////////////////////
    // Convenience bit-selections 
    ///////////////////////////////////////////////////////////////////////////
	wire 	[7:0]		a8_addr_hi		= a8_addr[15:8];
	wire	[7:0]		a8_addr_lo		= a8_addr[7:0];

    ///////////////////////////////////////////////////////////////////////////
    // Results of operations  
    ///////////////////////////////////////////////////////////////////////////
	reg		[7:0]		result;				// The final result
	reg		[7:0]		cfg_result;			// The result of reading cfg RAM
	reg					result_valid;		// Whether to drive result
	
    ///////////////////////////////////////////////////////////////////////////
    // Define a vector of bits, where a '1' means that page is to be sourced
    // via the FPGA rather than from the A8 itself. This is linked through
    // to the page_map module
    ///////////////////////////////////////////////////////////////////////////
	wire	[255:0]		pagemap;
	
    ///////////////////////////////////////////////////////////////////////////
    // Instantiate module to update pagemap. Here, op ought to toggle as either
    // `OP_ADD or `OP_DEL for a single clock, and the map will be updated when
    // map_valid is true
    ///////////////////////////////////////////////////////////////////////////
	reg		[7:0]		map_from;			// Holds the lowest page number
	reg		[7:0]		map_size;			// Holds the number of pages
	reg		[1:0]		map_op = `OP_NONE;	// Operation to perform
	wire				map_valid;			// Whether the map is now useable

	page_map map
		(
		.clk200(clk200),
		.a8_rst_n(a8_rst_n),
		.op(map_op),
		.from(map_from),
		.size(map_size),
		.valid(map_valid),
		.map(pagemap)
		);
	
    ///////////////////////////////////////////////////////////////////////////
    // Sync a8_clk to the FPGA clock using a 3-bit shift register to avoid
    // metastability due to the different clock rates
    ///////////////////////////////////////////////////////////////////////////
	reg [2:0] clkDetect;  
	always @(posedge clk200) 
		if (a8_rst_n == 1'b0)
			clkDetect <= 3'b0;
		else
			clkDetect <= {clkDetect[1:0], a8_clk};

    ///////////////////////////////////////////////////////////////////////////
    // We want to know about rising/falling edges to handle bus traffic timing
    ///////////////////////////////////////////////////////////////////////////
	wire a8_clk_rising		= (clkDetect[2:1]==2'b01);   
	wire a8_clk_falling		= (clkDetect[2:1]==2'b10);  

    ///////////////////////////////////////////////////////////////////////////
    // Monitor the bus by doing various things at various times
    ///////////////////////////////////////////////////////////////////////////
	reg	[TICK_BITS-1:0]			ticks;					// How far in the cycle
		
	always @ (posedge clk200)
		if (a8_rst_n == 1'b0)
			begin
				ticks	<= {TICK_BITS{1'b0}};
			end
		else
			begin
				if (a8_clk_falling == 1'b1)
					begin
						ticks 	<= {TICK_BITS{1'b0}};
					end
				else
					ticks	<= ticks + 1;
			end
	
    ///////////////////////////////////////////////////////////////////////////
    // Monitor: check to see if EXTSEL needs assertion 
    ///////////////////////////////////////////////////////////////////////////
	wire addressValid		= (ticks == TICK_ADDRESS_VALID);
	
	always @ (posedge clk200)
		if (a8_rst_n == 1'b0)
			a8_extsel_n <= 1'b1;
			
		else if (addressValid == 1'b1)
			a8_extsel_n <= pagemap[a8_addr_hi] ? 1'b0 : 1'b1;

		else if (a8_clk_falling == 1'b1)
			a8_extsel_n <= 1'b1;

    ///////////////////////////////////////////////////////////////////////////
    // Add some backing ram for the $D600 -> $D7FF area in the A8 
    ///////////////////////////////////////////////////////////////////////////
	reg		[8:0]		cfg_addr;		// address to use for config RAM
	reg					cfg_we;			// Write-enable for config RAM access
	reg		[7:0]		cfg_wdata;		// Data to write to config RAM
	wire	[7:0]		cfg_rdata;		// Data read from config RAM 
	
	cfg_ram cfg
		(
		.clk200(clk200),
		.addr(cfg_addr),
		.we(cfg_we),
		.wdata(cfg_wdata),
		.rdata(cfg_rdata)
		);
	
    ///////////////////////////////////////////////////////////////////////////
    // Monitor: If we have a write to D6xx then we're altering some aspect of
    // the page structure. Memory apertures are 16-bytes long and start at
    // $D600. Layout looks like:
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
    ///////////////////////////////////////////////////////////////////////////
	wire write_valid	= (ticks == TICK_WRITE_VALID) & (a8_rw_n == 1'b0);
	wire ap_write 		= write_valid & (a8_addr_hi == PAGE_MEM_AP);
	wire cfg_write		= write_valid & (a8_addr_hi == PAGE_MEM_CFG);

	wire read_ok		= (ticks == TICK_ADDRESS_VALID) & (a8_rw_n == 1'b1);
	wire ap_read 		= read_ok & (a8_addr_hi == PAGE_MEM_AP);
	wire cfg_read		= read_ok & (a8_addr_hi == PAGE_MEM_CFG);
	reg	 cfg_read_op	= 1'b0;
	
	always @ (posedge clk200)
		begin
			if (a8_rst_n == 1'b0)
				begin
					cfg_we 					<= 1'b0;
					cfg_read_op				<= 1'b0;
				end
			else
				begin
					// Do we have a config write ?
					if (ap_write | cfg_write)
						begin
							cfg_addr 		<= {cfg_write, a8_addr_lo};
							cfg_we			<= 1'b1;
							cfg_wdata		<= a8_data;
							cfg_read_op		<= 1'b0;
						end
						
					// Do we have a config read ?
					else if (ap_read | cfg_read)
						begin
							cfg_addr 		<= {cfg_read, a8_addr_lo};
							cfg_we			<= 1'b0;
							cfg_read_op		<= 1'b1;
						end
					
					// Reset at the end of the cycle
					else if (a8_clk_falling)
						cfg_read_op			<= 1'b0;
						
					// Delayed read result by 1 clock cycle
					else if (cfg_read_op)
						begin
							cfg_result		<= cfg_rdata;
						end
					
					// Default is to not write to RAM
					else
						cfg_we				<= 1'b0;
				end
		end	



    ///////////////////////////////////////////////////////////////////////////
    // Handle the mux of all the possible sources of data 
    ///////////////////////////////////////////////////////////////////////////
    wire drive_read		= (ticks == TICK_READ_VALID) & (a8_rw_n == 1'b1);
    
	always @ (posedge clk200)
		begin
			if (a8_rst_n == 1'b0)
				begin
					result_valid 	<= 1'b0;
					result			<= 8'b0;
				end
			else if (drive_read)
				result 				<= (cfg_read_op) ? cfg_result
									:  8'bz;
			
			else if (a8_clk_falling)
				result				<= 8'bz;
				
		end
		
endmodule
