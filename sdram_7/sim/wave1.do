onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_cmd_decode/cmd_decode_inst/clk
add wave -noupdate /tb_cmd_decode/cmd_decode_inst/rst_n
add wave -noupdate /tb_cmd_decode/cmd_decode_inst/uart_flag
add wave -noupdate /tb_cmd_decode/cmd_decode_inst/uart_data
add wave -noupdate /tb_cmd_decode/cmd_decode_inst/rec_num
add wave -noupdate /tb_cmd_decode/cmd_decode_inst/cmd_reg
add wave -noupdate /tb_cmd_decode/cmd_decode_inst/wr_trig
add wave -noupdate /tb_cmd_decode/cmd_decode_inst/rd_trig
add wave -noupdate /tb_cmd_decode/cmd_decode_inst/wfifo_wr_en
add wave -noupdate /tb_cmd_decode/cmd_decode_inst/wfifo_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {498 ns} 0}
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
WaveRestoreZoom {0 ns} {4096 ns}
