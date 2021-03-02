MODS1	= pixl_tb pixl bus_a8 page_map mask_ram
SRCS1	= $(addsuffix .v, $(MODS1))
PROG1	= /tmp/pixl.bin

MODS2	= page_map_tb page_map mask_ram
SRCS2	= $(addsuffix .v, $(MODS2))
PROG2	= /tmp/pagemap.bin

all: testbench

testbench: $(SRCS1)
	iverilog -o $(PROG1) $(SRCS1)
	$(PROG1)

top: testbench
	gtkwave /tmp/wave.vcd waves.gtkw


testbench2: $(SRCS2)
	iverilog -o $(PROG2) $(SRCS2)
	$(PROG2)

pagemap: testbench2
	gtkwave /tmp/page.vcd  page_map.gtkw
	
