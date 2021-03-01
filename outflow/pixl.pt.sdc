
# Efinity Interface Designer SDC
# Version: 2020.2.299.4.5
# Date: 2021-02-28 20:14

# Copyright (C) 2017 - 2020 Efinix Inc. All rights reserved.

# Device: T20F256
# Project: pixl
# Timing Model: C4 (final)

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[0]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[0]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[1]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[1]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[5]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[5]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[7]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[7]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[8]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[8]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[9]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[9]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[10]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[10]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[11]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[11]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[12]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[12]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[13]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[13]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[14]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[14]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[15]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[15]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_clk}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_clk}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_data[0]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_data[0]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_data[1]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_data[1]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_data[2]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_data[2]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_data[3]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_data[3]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_data[4]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_data[4]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_data[5]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_data[5]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_data[6]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_data[6]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_data[7]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_data[7]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_extsel_n}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_extsel_n}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_halt_n}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_halt_n}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_irq_n}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_irq_n}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_rd5}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_rd5}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_ref_n}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_ref_n}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_rst_n}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_rst_n}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_rw_n}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_rw_n}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_mpd_n}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_mpd_n}]

# LVDS RX GPIO Constraints
############################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[2]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[2]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[3]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[3]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[4]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[4]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_addr[6]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_addr[6]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {a8_rd4}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {a8_rd4}]

# LVDS Rx Constraints
####################
