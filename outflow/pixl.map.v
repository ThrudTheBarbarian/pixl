
//
// Verific Verilog Description of module pixl
//

module pixl (clk200, a8_clk, a8_rw_n, a8_halt_n, a8_irq_n, a8_addr, 
            a8_data, a8_rst_n, a8_rd5, a8_rd4, a8_ref_n, a8_mpd_n, 
            a8_extsel_n);
    input clk200 /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input a8_clk /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input a8_rw_n /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input a8_halt_n /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input a8_irq_n /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input [15:0]a8_addr /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input [7:0]a8_data /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input a8_rst_n /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input a8_rd5 /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input a8_rd4 /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input a8_ref_n /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    output a8_mpd_n /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;
    output a8_extsel_n /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;
    
    
    wire n36, n37, n38, n39, \monitor/ticks[4] , \monitor/ticks[0] , 
        \monitor/ticks[3] , \monitor/ticks[6] , \monitor/clkDetect[0] , 
        \monitor/ticks[5] , \monitor/ticks[2] , n48, \monitor/ticks[1] , 
        n50, n51, n52, n53, n54, n55, \monitor/clkDetect[1] , 
        \monitor/clkDetect[2] , n65, n69, \clk200~O , n85, n86, 
        n87;
    
    assign a8_mpd_n = 1'b0 /* verific EFX_ATTRIBUTE_CELL_NAME=GND */ ;
    EFX_LUT4 LUT__142 (.I0(\monitor/ticks[4] ), .I1(\monitor/ticks[3] ), 
            .I2(\monitor/ticks[0] ), .O(n85)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h1010 */ ;
    defparam LUT__142.LUTMASK = 16'h1010;
    EFX_FF \monitor/ticks[4]~FF  (.D(n54), .CE(1'b1), .CLK(\clk200~O ), 
           .SR(n65), .Q(\monitor/ticks[4] )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(95)
    defparam \monitor/ticks[4]~FF .CLK_POLARITY = 1'b1;
    defparam \monitor/ticks[4]~FF .CE_POLARITY = 1'b1;
    defparam \monitor/ticks[4]~FF .SR_POLARITY = 1'b1;
    defparam \monitor/ticks[4]~FF .D_POLARITY = 1'b1;
    defparam \monitor/ticks[4]~FF .SR_SYNC = 1'b1;
    defparam \monitor/ticks[4]~FF .SR_VALUE = 1'b0;
    defparam \monitor/ticks[4]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \monitor/ticks[0]~FF  (.D(\monitor/ticks[0] ), .CE(1'b1), .CLK(\clk200~O ), 
           .SR(n65), .Q(\monitor/ticks[0] )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b0, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(95)
    defparam \monitor/ticks[0]~FF .CLK_POLARITY = 1'b1;
    defparam \monitor/ticks[0]~FF .CE_POLARITY = 1'b1;
    defparam \monitor/ticks[0]~FF .SR_POLARITY = 1'b1;
    defparam \monitor/ticks[0]~FF .D_POLARITY = 1'b0;
    defparam \monitor/ticks[0]~FF .SR_SYNC = 1'b1;
    defparam \monitor/ticks[0]~FF .SR_VALUE = 1'b0;
    defparam \monitor/ticks[0]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \monitor/ticks[3]~FF  (.D(n52), .CE(1'b1), .CLK(\clk200~O ), 
           .SR(n65), .Q(\monitor/ticks[3] )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(95)
    defparam \monitor/ticks[3]~FF .CLK_POLARITY = 1'b1;
    defparam \monitor/ticks[3]~FF .CE_POLARITY = 1'b1;
    defparam \monitor/ticks[3]~FF .SR_POLARITY = 1'b1;
    defparam \monitor/ticks[3]~FF .D_POLARITY = 1'b1;
    defparam \monitor/ticks[3]~FF .SR_SYNC = 1'b1;
    defparam \monitor/ticks[3]~FF .SR_VALUE = 1'b0;
    defparam \monitor/ticks[3]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \monitor/ticks[6]~FF  (.D(n48), .CE(1'b1), .CLK(\clk200~O ), 
           .SR(n65), .Q(\monitor/ticks[6] )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(95)
    defparam \monitor/ticks[6]~FF .CLK_POLARITY = 1'b1;
    defparam \monitor/ticks[6]~FF .CE_POLARITY = 1'b1;
    defparam \monitor/ticks[6]~FF .SR_POLARITY = 1'b1;
    defparam \monitor/ticks[6]~FF .D_POLARITY = 1'b1;
    defparam \monitor/ticks[6]~FF .SR_SYNC = 1'b1;
    defparam \monitor/ticks[6]~FF .SR_VALUE = 1'b0;
    defparam \monitor/ticks[6]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \monitor/a8_extsel_n~FF  (.D(1'b1), .CE(n69), .CLK(\clk200~O ), 
           .SR(1'b0), .Q(a8_extsel_n)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(110)
    defparam \monitor/a8_extsel_n~FF .CLK_POLARITY = 1'b1;
    defparam \monitor/a8_extsel_n~FF .CE_POLARITY = 1'b1;
    defparam \monitor/a8_extsel_n~FF .SR_POLARITY = 1'b1;
    defparam \monitor/a8_extsel_n~FF .D_POLARITY = 1'b1;
    defparam \monitor/a8_extsel_n~FF .SR_SYNC = 1'b1;
    defparam \monitor/a8_extsel_n~FF .SR_VALUE = 1'b0;
    defparam \monitor/a8_extsel_n~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \monitor/clkDetect[0]~FF  (.D(a8_clk), .CE(1'b1), .CLK(\clk200~O ), 
           .SR(a8_rst_n), .Q(\monitor/clkDetect[0] )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b0 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(68)
    defparam \monitor/clkDetect[0]~FF .CLK_POLARITY = 1'b1;
    defparam \monitor/clkDetect[0]~FF .CE_POLARITY = 1'b1;
    defparam \monitor/clkDetect[0]~FF .SR_POLARITY = 1'b0;
    defparam \monitor/clkDetect[0]~FF .D_POLARITY = 1'b1;
    defparam \monitor/clkDetect[0]~FF .SR_SYNC = 1'b1;
    defparam \monitor/clkDetect[0]~FF .SR_VALUE = 1'b0;
    defparam \monitor/clkDetect[0]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \monitor/ticks[5]~FF  (.D(n38), .CE(1'b1), .CLK(\clk200~O ), 
           .SR(n65), .Q(\monitor/ticks[5] )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(95)
    defparam \monitor/ticks[5]~FF .CLK_POLARITY = 1'b1;
    defparam \monitor/ticks[5]~FF .CE_POLARITY = 1'b1;
    defparam \monitor/ticks[5]~FF .SR_POLARITY = 1'b1;
    defparam \monitor/ticks[5]~FF .D_POLARITY = 1'b1;
    defparam \monitor/ticks[5]~FF .SR_SYNC = 1'b1;
    defparam \monitor/ticks[5]~FF .SR_VALUE = 1'b0;
    defparam \monitor/ticks[5]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \monitor/ticks[2]~FF  (.D(n50), .CE(1'b1), .CLK(\clk200~O ), 
           .SR(n65), .Q(\monitor/ticks[2] )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(95)
    defparam \monitor/ticks[2]~FF .CLK_POLARITY = 1'b1;
    defparam \monitor/ticks[2]~FF .CE_POLARITY = 1'b1;
    defparam \monitor/ticks[2]~FF .SR_POLARITY = 1'b1;
    defparam \monitor/ticks[2]~FF .D_POLARITY = 1'b1;
    defparam \monitor/ticks[2]~FF .SR_SYNC = 1'b1;
    defparam \monitor/ticks[2]~FF .SR_VALUE = 1'b0;
    defparam \monitor/ticks[2]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \monitor/ticks[1]~FF  (.D(n36), .CE(1'b1), .CLK(\clk200~O ), 
           .SR(n65), .Q(\monitor/ticks[1] )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(95)
    defparam \monitor/ticks[1]~FF .CLK_POLARITY = 1'b1;
    defparam \monitor/ticks[1]~FF .CE_POLARITY = 1'b1;
    defparam \monitor/ticks[1]~FF .SR_POLARITY = 1'b1;
    defparam \monitor/ticks[1]~FF .D_POLARITY = 1'b1;
    defparam \monitor/ticks[1]~FF .SR_SYNC = 1'b1;
    defparam \monitor/ticks[1]~FF .SR_VALUE = 1'b0;
    defparam \monitor/ticks[1]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \monitor/clkDetect[1]~FF  (.D(\monitor/clkDetect[0] ), .CE(1'b1), 
           .CLK(\clk200~O ), .SR(a8_rst_n), .Q(\monitor/clkDetect[1] )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b0 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(68)
    defparam \monitor/clkDetect[1]~FF .CLK_POLARITY = 1'b1;
    defparam \monitor/clkDetect[1]~FF .CE_POLARITY = 1'b1;
    defparam \monitor/clkDetect[1]~FF .SR_POLARITY = 1'b0;
    defparam \monitor/clkDetect[1]~FF .D_POLARITY = 1'b1;
    defparam \monitor/clkDetect[1]~FF .SR_SYNC = 1'b1;
    defparam \monitor/clkDetect[1]~FF .SR_VALUE = 1'b0;
    defparam \monitor/clkDetect[1]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \monitor/clkDetect[2]~FF  (.D(\monitor/clkDetect[1] ), .CE(1'b1), 
           .CLK(\clk200~O ), .SR(a8_rst_n), .Q(\monitor/clkDetect[2] )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b0 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(68)
    defparam \monitor/clkDetect[2]~FF .CLK_POLARITY = 1'b1;
    defparam \monitor/clkDetect[2]~FF .CE_POLARITY = 1'b1;
    defparam \monitor/clkDetect[2]~FF .SR_POLARITY = 1'b0;
    defparam \monitor/clkDetect[2]~FF .D_POLARITY = 1'b1;
    defparam \monitor/clkDetect[2]~FF .SR_SYNC = 1'b1;
    defparam \monitor/clkDetect[2]~FF .SR_VALUE = 1'b0;
    defparam \monitor/clkDetect[2]~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_ADD \monitor/add_15/i2  (.I0(\monitor/ticks[1] ), .I1(\monitor/ticks[0] ), 
            .CI(1'b0), .O(n36), .CO(n37)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(94)
    defparam \monitor/add_15/i2 .I0_POLARITY = 1'b1;
    defparam \monitor/add_15/i2 .I1_POLARITY = 1'b1;
    EFX_ADD \monitor/add_15/i6  (.I0(\monitor/ticks[5] ), .I1(1'b0), .CI(n55), 
            .O(n38), .CO(n39)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(94)
    defparam \monitor/add_15/i6 .I0_POLARITY = 1'b1;
    defparam \monitor/add_15/i6 .I1_POLARITY = 1'b1;
    EFX_ADD \monitor/add_15/i7  (.I0(\monitor/ticks[6] ), .I1(1'b0), .CI(n39), 
            .O(n48)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(94)
    defparam \monitor/add_15/i7 .I0_POLARITY = 1'b1;
    defparam \monitor/add_15/i7 .I1_POLARITY = 1'b1;
    EFX_ADD \monitor/add_15/i3  (.I0(\monitor/ticks[2] ), .I1(1'b0), .CI(n37), 
            .O(n50), .CO(n51)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(94)
    defparam \monitor/add_15/i3 .I0_POLARITY = 1'b1;
    defparam \monitor/add_15/i3 .I1_POLARITY = 1'b1;
    EFX_ADD \monitor/add_15/i4  (.I0(\monitor/ticks[3] ), .I1(1'b0), .CI(n51), 
            .O(n52), .CO(n53)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(94)
    defparam \monitor/add_15/i4 .I0_POLARITY = 1'b1;
    defparam \monitor/add_15/i4 .I1_POLARITY = 1'b1;
    EFX_ADD \monitor/add_15/i5  (.I0(\monitor/ticks[4] ), .I1(1'b0), .CI(n53), 
            .O(n54), .CO(n55)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_ADD, I0_POLARITY=1'b1, I1_POLARITY=1'b1 */ ;   // /home/simon/src/verilog/pixl/bus_a8.v(94)
    defparam \monitor/add_15/i5 .I0_POLARITY = 1'b1;
    defparam \monitor/add_15/i5 .I1_POLARITY = 1'b1;
    EFX_LUT4 LUT__143 (.I0(\monitor/ticks[6] ), .I1(\monitor/ticks[2] ), 
            .I2(\monitor/ticks[5] ), .I3(\monitor/ticks[1] ), .O(n86)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h1000 */ ;
    defparam LUT__143.LUTMASK = 16'h1000;
    EFX_LUT4 LUT__144 (.I0(\monitor/clkDetect[1] ), .I1(\monitor/clkDetect[2] ), 
            .I2(a8_rst_n), .O(n87)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'hd0d0 */ ;
    defparam LUT__144.LUTMASK = 16'hd0d0;
    EFX_LUT4 LUT__145 (.I0(n85), .I1(n86), .I2(n87), .O(n69)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h8f8f */ ;
    defparam LUT__145.LUTMASK = 16'h8f8f;
    EFX_LUT4 LUT__141 (.I0(\monitor/clkDetect[1] ), .I1(\monitor/clkDetect[2] ), 
            .I2(a8_rst_n), .O(n65)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4f4f */ ;
    defparam LUT__141.LUTMASK = 16'h4f4f;
    EFX_GBUFCE CLKBUF__0 (.CE(1'b1), .I(clk200), .O(\clk200~O )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_GBUFCE, CE_POLARITY=1'b1 */ ;
    defparam CLKBUF__0.CE_POLARITY = 1'b1;
    
endmodule

//
// Verific Verilog Description of module EFX_LUT40
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF0
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF1
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF2
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF3
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF4
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF5
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF6
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF7
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF8
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF9
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF10
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_ADD0
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_ADD1
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_ADD2
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_ADD3
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_ADD4
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_ADD5
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT41
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT42
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT43
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT44
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_GBUFCE0
// module not written out since it is a black box. 
//

