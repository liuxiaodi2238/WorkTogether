onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/tb_uart_tx/Group1 -group {Region: sim:/tb_uart_tx} /tb_uart_tx/clk
add wave -noupdate -expand -label sim:/tb_uart_tx/Group1 -group {Region: sim:/tb_uart_tx} /tb_uart_tx/rs232_tx
add wave -noupdate -expand -label sim:/tb_uart_tx/Group1 -group {Region: sim:/tb_uart_tx} /tb_uart_tx/rst_n
add wave -noupdate -expand -label sim:/tb_uart_tx/Group1 -group {Region: sim:/tb_uart_tx} /tb_uart_tx/tx_data
add wave -noupdate -expand -label sim:/tb_uart_tx/Group1 -group {Region: sim:/tb_uart_tx} /tb_uart_tx/tx_trig
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/BAUD_END
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/BAUD_M
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/BIT_END
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/baud_cnt
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/bit_cnt
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/bit_flag
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/clk
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/rs232_tx
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/rst_n
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/tx_data
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/tx_data_reg
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/tx_flag
add wave -noupdate -expand -label sim:/tb_uart_tx/uart_tx_init/Group1 -group {Region: sim:/tb_uart_tx/uart_tx_init} /tb_uart_tx/uart_tx_init/tx_trig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1930 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {13568 ns}
