`timescale 1ns/1ns

///////////////////////////////////////////////////////////////////////////////
// Top module. 
//
// 
///////////////////////////////////////////////////////////////////////////////
module pixl
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
	output 				a8_mpd_n,		// A8 Math-Pak Disable (/MPD) signal
	output 				a8_extsel_n		// A8 external selection signal
    );


    ///////////////////////////////////////////////////////////////////////////
    // Instantiate a bus-monitor
    ///////////////////////////////////////////////////////////////////////////
	bus_a8 bus
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

endmodule
