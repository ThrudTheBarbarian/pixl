MODS	= pixl_tb pixl bus_a8
SRCS	= $(addsuffix .v, $(MODS))
PROG	= /tmp/pixl.bin

all: testbench

testbench: $(SRCS)
	iverilog -o $(PROG) $(SRCS)
	$(PROG)

wave: testbench
	gtkwave /tmp/wave.vcd
