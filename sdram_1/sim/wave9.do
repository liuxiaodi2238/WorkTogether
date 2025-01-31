onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_uart_rx/clk
add wave -noupdate /tb_uart_rx/mem_a
add wave -noupdate /tb_uart_rx/po_flag
add wave -noupdate /tb_uart_rx/rs232_tx
add wave -noupdate /tb_uart_rx/rst_n
add wave -noupdate /tb_uart_rx/rx_data
add wave -noupdate /tb_uart_rx/uart_rx_inst/BAUD_END
add wave -noupdate /tb_uart_rx/uart_rx_inst/BAUD_M
add wave -noupdate /tb_uart_rx/uart_rx_inst/BIT_END
add wave -noupdate /tb_uart_rx/uart_rx_inst/clk
add wave -noupdate /tb_uart_rx/uart_rx_inst/rst_n
add wave -noupdate /tb_uart_rx/uart_rx_inst/rs232_rx
add wave -noupdate /tb_uart_rx/uart_rx_inst/rx_r1
add wave -noupdate /tb_uart_rx/uart_rx_inst/rx_r2
add wave -noupdate /tb_uart_rx/uart_rx_inst/rx_r3
add wave -noupdate /tb_uart_rx/uart_rx_inst/rx_neg
add wave -noupdate /tb_uart_rx/uart_rx_inst/rx_flag
add wave -noupdate -radix decimal /tb_uart_rx/uart_rx_inst/baud_cnt
add wave -noupdate /tb_uart_rx/uart_rx_inst/bit_flag
add wave -noupdate /tb_uart_rx/uart_rx_inst/bit_cnt
add wave -noupdate -radix binary /tb_uart_rx/uart_rx_inst/rx_data
add wave -noupdate /tb_uart_rx/uart_rx_inst/po_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4683 ns} 0}
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
WaveRestoreZoom {4060 ns} {6972 ns}
