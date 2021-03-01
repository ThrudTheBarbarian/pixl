`timescale 1ns/1ns

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
	
	localparam	PAGE_MEM_AP				= 8'hd6;	// Memory apertures here

    ///////////////////////////////////////////////////////////////////////////
    // Define a vector of bits, where a '1' means that page is to be sourced
    // via the FPGA rather than from the A8 itself. 
    ///////////////////////////////////////////////////////////////////////////
	reg		[255:0]		page_map		= 256'h40;
	
    ///////////////////////////////////////////////////////////////////////////
    // Convenience bit-selections 
    ///////////////////////////////////////////////////////////////////////////
	wire 	[7:0]		a8_addr_hi		= a8_addr[15:8];
	wire	[7:0]		a8_addr_lo		= a8_addr[7:0];
	
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
			a8_extsel_n <= page_map[a8_addr_hi] ? 1'b0 : 1'b1;

		else if (a8_clk_falling == 1'b1)
			a8_extsel_n <= 1'b1;
	

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
	// 
    ///////////////////////////////////////////////////////////////////////////
	wire writeValid		= (ticks == TICK_WRITE_VALID);


	wire apWrite = (a8_rw_n == 1'b0)
				 & (a8_addr_hi == PAGE_MEM_AP)
				 & (writeValid == 1'b1);
	
	// Instantiate module to update page-map. Pass in page_map as wire to
	// reg in module, as well as apWrite as a start signal and a8_addr_lo
	// and a8_data
	
	// Module should use 2-step selection/shift of all-ones / all-zeros in
	// case stmt and use [ -: ] selection syntax
	
	// Also need to persist these values in register-space in the FPGA so
	// we can manipulate them easily. Make each an 'aperture' module
	
	
endmodule
