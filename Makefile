MODS	= pixl_tb pixl bus_a8 page_map mask_ram
SRCS	= $(addsuffix .v, $(MODS))
PROG	= /tmp/pixl.bin

all: testbench

testbench: $(SRCS)
	iverilog -o $(PROG) $(SRCS)
	$(PROG)

wave: testbench
	gtkwave /tmp/wave.vcd waves.gtkw
