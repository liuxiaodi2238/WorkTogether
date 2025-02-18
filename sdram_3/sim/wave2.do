onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/clk
add wave -noupdate /tb_sdram_top/sdram_top_inst/rst_n
add wave -noupdate -radix binary /tb_sdram_top/sdram_top_inst/sdram_init_inst/cmd_cnt
add wave -noupdate -radix binary /tb_sdram_top/sdram_top_inst/sdram_init_inst/cmd_reg
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/cnt_200us
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/flag_200us
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/flag_init_end
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/rst_n
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_init_inst/sdram_addr
add wave -noupdate /tb_sdram_top/sdram_top_inst/flag_init_end
add wave -noupdate /tb_sdram_top/sdram_top_inst/init_addr
add wave -noupdate /tb_sdram_top/sdram_top_inst/init_cmd
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_addr
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_cke
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_clk
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_cs_n
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_ras_n
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_cas_n
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_we_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {200403100 ps} 0}
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
WaveRestoreZoom {200045900 ps} {200557900 ps}
