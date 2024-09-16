## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Reset button
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports reset]

## Switches (for sw[3:0]) - Reduced to 4 switches
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {sw[0]}]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports {sw[1]}]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports {sw[2]}]
set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports {sw[3]}]

## Buttons (for btn[2:0])
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports {btn[0]}]
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports {btn[1]}]
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports {btn[2]}]

## LEDs (for led[3:0]) - Reduced to 4 LEDs
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports {led[0]}]
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports {led[1]}]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports {led[2]}]
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports {led[3]}]

## 7-segment display (for sseg and an)
set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports {sseg[0]}]
set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports {sseg[1]}]
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports {sseg[2]}]
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports {sseg[3]}]
set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports {sseg[4]}]
set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports {sseg[5]}]
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports {sseg[6]}]

set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports dp]

set_property -dict { PACKAGE_PIN U2    IOSTANDARD LVCMOS33 } [get_ports {an[0]}]
set_property -dict { PACKAGE_PIN U4    IOSTANDARD LVCMOS33 } [get_ports {an[1]}]
set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33 } [get_ports {an[2]}]
set_property -dict { PACKAGE_PIN W4    IOSTANDARD LVCMOS33 } [get_ports {an[3]}]

## SRAM Interface (Pmod Header - JA)
set_property -dict { PACKAGE_PIN J1   IOSTANDARD LVCMOS33 } [get_ports {ad[0]}]
set_property -dict { PACKAGE_PIN L2   IOSTANDARD LVCMOS33 } [get_ports {ad[1]}]
set_property -dict { PACKAGE_PIN J2   IOSTANDARD LVCMOS33 } [get_ports {ad[2]}]
set_property -dict { PACKAGE_PIN G2   IOSTANDARD LVCMOS33 } [get_ports {ad[3]}]
set_property -dict { PACKAGE_PIN H1   IOSTANDARD LVCMOS33 } [get_ports {ad[4]}]
set_property -dict { PACKAGE_PIN K2   IOSTANDARD LVCMOS33 } [get_ports {ad[5]}]
set_property -dict { PACKAGE_PIN H2   IOSTANDARD LVCMOS33 } [get_ports {ad[6]}]
set_property -dict { PACKAGE_PIN G3   IOSTANDARD LVCMOS33 } [get_ports {ad[7]}]
set_property -dict { PACKAGE_PIN J3   IOSTANDARD LVCMOS33 } [get_ports {ad[8]}]
set_property -dict { PACKAGE_PIN L3   IOSTANDARD LVCMOS33 } [get_ports {ad[9]}]
set_property -dict { PACKAGE_PIN M2   IOSTANDARD LVCMOS33 } [get_ports {ad[10]}]
set_property -dict { PACKAGE_PIN N2   IOSTANDARD LVCMOS33 } [get_ports {ad[11]}]
set_property -dict { PACKAGE_PIN K3   IOSTANDARD LVCMOS33 } [get_ports {ad[12]}]
set_property -dict { PACKAGE_PIN M3   IOSTANDARD LVCMOS33 } [get_ports {ad[13]}]
set_property -dict { PACKAGE_PIN M1   IOSTANDARD LVCMOS33 } [get_ports {ad[14]}]
set_property -dict { PACKAGE_PIN N1   IOSTANDARD LVCMOS33 } [get_ports {ad[15]}]

## SRAM Control Signals
set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports we_n]
set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports oe_n]
set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33 } [get_ports ce_a_n]
set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports ub_a_n]
set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports lb_a_n]

## SRAM Data (for dio_a[15:0])
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports {dio_a[0]}]
set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports {dio_a[1]}]
set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports {dio_a[2]}]
set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports {dio_a[3]}]
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports {dio_a[4]}]
set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS33 } [get_ports {dio_a[5]}]
set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports {dio_a[6]}]
set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports {dio_a[7]}]
set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS33 } [get_ports {dio_a[8]}]
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports {dio_a[9]}]
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports {dio_a[10]}]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports {dio_a[11]}]
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports {dio_a[12]}]
set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports {dio_a[13]}]
set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports {dio_a[14]}]
set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports {dio_a[15]}]
