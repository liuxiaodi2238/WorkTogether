onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/AutoRefresh
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/DELAY_200US
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/ModeSet
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/NOP
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/Precharge
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/clk
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/cmd_cnt
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/cmd_reg
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/cnt_200us
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/flag_200us
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/flag_init_end
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/rst_n
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/sdram_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {127100 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {4096 ns}
