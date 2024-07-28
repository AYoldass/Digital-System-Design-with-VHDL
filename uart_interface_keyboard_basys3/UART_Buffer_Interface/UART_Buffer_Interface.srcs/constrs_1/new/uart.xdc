## Clock signal
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

## Button signals
## btnL
set_property PACKAGE_PIN W19 [get_ports {btn[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[0]}]
set_property PACKAGE_PIN T17 [get_ports {btn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[1]}]
## btnR
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## UART signals
set_property PACKAGE_PIN B18 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports rx]
set_property PACKAGE_PIN A18 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]

## LED signals
# LEDs
set_property PACKAGE_PIN U16 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property PACKAGE_PIN V19 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property PACKAGE_PIN W18 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property PACKAGE_PIN U15 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property PACKAGE_PIN U14 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property PACKAGE_PIN V14 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]


## 7-Segment Display signals
set_property PACKAGE_PIN W7 [get_ports {sseg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[0]}]
set_property PACKAGE_PIN W6 [get_ports {sseg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[1]}]
set_property PACKAGE_PIN U8 [get_ports {sseg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[2]}]
set_property PACKAGE_PIN V8 [get_ports {sseg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[3]}]
set_property PACKAGE_PIN U5 [get_ports {sseg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[4]}]
set_property PACKAGE_PIN V5 [get_ports {sseg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[5]}]
set_property PACKAGE_PIN U7 [get_ports {sseg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[6]}]
set_property PACKAGE_PIN V7 [get_ports {sseg[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg[7]}]


## 7-Segment Display anode signals
set_property PACKAGE_PIN U2 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]


create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {uart_unit/rx_data_out[0]} {uart_unit/rx_data_out[1]} {uart_unit/rx_data_out[2]} {uart_unit/rx_data_out[3]} {uart_unit/rx_data_out[4]} {uart_unit/rx_data_out[5]} {uart_unit/rx_data_out[6]} {uart_unit/rx_data_out[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {uart_unit/count_50Mhz[0]} {uart_unit/count_50Mhz[1]} {uart_unit/count_50Mhz[2]} {uart_unit/count_50Mhz[3]} {uart_unit/count_50Mhz[4]} {uart_unit/count_50Mhz[5]} {uart_unit/count_50Mhz[6]} {uart_unit/count_50Mhz[7]} {uart_unit/count_50Mhz[8]} {uart_unit/count_50Mhz[9]} {uart_unit/count_50Mhz[10]} {uart_unit/count_50Mhz[11]} {uart_unit/count_50Mhz[12]} {uart_unit/count_50Mhz[13]} {uart_unit/count_50Mhz[14]} {uart_unit/count_50Mhz[15]} {uart_unit/count_50Mhz[16]} {uart_unit/count_50Mhz[17]} {uart_unit/count_50Mhz[18]} {uart_unit/count_50Mhz[19]} {uart_unit/count_50Mhz[20]} {uart_unit/count_50Mhz[21]} {uart_unit/count_50Mhz[22]} {uart_unit/count_50Mhz[23]} {uart_unit/count_50Mhz[24]} {uart_unit/count_50Mhz[25]} {uart_unit/count_50Mhz[26]} {uart_unit/count_50Mhz[27]} {uart_unit/count_50Mhz[28]} {uart_unit/count_50Mhz[29]} {uart_unit/count_50Mhz[30]} {uart_unit/count_50Mhz[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {uart_unit/tx_fifo_out[0]} {uart_unit/tx_fifo_out[1]} {uart_unit/tx_fifo_out[2]} {uart_unit/tx_fifo_out[3]} {uart_unit/tx_fifo_out[4]} {uart_unit/tx_fifo_out[5]} {uart_unit/tx_fifo_out[6]} {uart_unit/tx_fifo_out[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list uart_unit/rd_uart_dbg]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list uart_unit/rx_dbg]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list uart_unit/rx_done_tick]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list uart_unit/tx_dbg]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list uart_unit/tx_done_tick]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list uart_unit/tx_empty]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list uart_unit/tx_fifo_not_empty]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list uart_unit/wr_uart_dbg]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]
