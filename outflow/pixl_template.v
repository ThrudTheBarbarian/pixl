
// Efinity Top-level template
// Version: 2020.2.299.4.5
// Date: 2021-02-28 20:14

// Copyright (C) 2017 - 2020 Efinix Inc. All rights reserved.

// This file may be used as a starting point for Efinity synthesis top-level target.
// The port list here matches what is expected by Efinity constraint files generated
// by the Efinity Interface Designer.

// To use this:
//     #1)  Save this file with a different name to a different directory, where source files are kept.
//              Example: you may wish to save as /home/simon/src/verilog/pixl/pixl.v
//     #2)  Add the newly saved file into Efinity project as design file
//     #3)  Edit the top level entity in Efinity project to:  pixl
//     #4)  Insert design content.


module pixl
(
  input [15:0] a8_addr,
  input a8_clk,
  input [7:0] a8_data,
  input a8_extsel_n,
  input a8_halt_n,
  input a8_irq_n,
  input a8_rd5,
  input a8_ref_n,
  input a8_rst_n,
  input a8_rw_n,
  input a8_rd4,
  output a8_mpd_n
);


endmodule

