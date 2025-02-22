onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/clk
add wave -noupdate -expand -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/cmd_cnt
add wave -noupdate -expand -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/cmd_reg
add wave -noupdate -expand -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/cnt_200us
add wave -noupdate -expand -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/flag_200us
add wave -noupdate -expand -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/flag_init_end
add wave -noupdate -expand -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/rst_n
add wave -noupdate -expand -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/sdram_addr
add wave -noupdate -expand -group autorefresh /tb_sdram_top/sdram_top_inst/sdram_aref_inst/aref_cmd
add wave -noupdate -expand -group autorefresh /tb_sdram_top/sdram_top_inst/sdram_aref_inst/clk
add wave -noupdate -expand -group autorefresh /tb_sdram_top/sdram_top_inst/sdram_aref_inst/cmd_cnt
add wave -noupdate -expand -group autorefresh /tb_sdram_top/sdram_top_inst/sdram_aref_inst/flag_init_end
add wave -noupdate -expand -group autorefresh /tb_sdram_top/sdram_top_inst/sdram_aref_inst/flag_ref
add wave -noupdate -expand -group autorefresh /tb_sdram_top/sdram_top_inst/sdram_aref_inst/flag_ref_end
add wave -noupdate -expand -group autorefresh /tb_sdram_top/sdram_top_inst/sdram_aref_inst/ref_cnt
add wave -noupdate -expand -group autorefresh /tb_sdram_top/sdram_top_inst/sdram_aref_inst/ref_en
add wave -noupdate -expand -group autorefresh /tb_sdram_top/sdram_top_inst/sdram_aref_inst/ref_req
add wave -noupdate -expand -group autorefresh /tb_sdram_top/sdram_top_inst/sdram_aref_inst/rst_n
add wave -noupdate -expand -group autorefresh /tb_sdram_top/sdram_top_inst/sdram_aref_inst/sdram_addr
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/act_cnt
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/bank_addr
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/break_cnt
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/brust_cnt
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/brust_cnt_t
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/clk
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/col_addr
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/col_cnt
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/flag_act_end
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/flag_pre_end
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/flag_row_end
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/flag_wr
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/flag_wr_end
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/ref_req
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/row_addr
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/rst_n
add wave -noupdate -expand -group write -radix binary /tb_sdram_top/sdram_top_inst/sdram_write_inst/state
add wave -noupdate -expand -group write -radix decimal /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_addr
add wave -noupdate -expand -group write -radix binary /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_cmd
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_data
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_data_end
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_en
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_req
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_trig
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/clk
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/flag_init_end
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/flag_ref_end
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/flag_wr_end
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/init_addr
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/init_cmd
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/ref_addr
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/ref_cmd
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/ref_en
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/ref_req
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/rst_n
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_addr
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_addr_reg
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_bank
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_cke
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_clk
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_cmd_reg
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_dq
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_dqm
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_cs_n
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_ras_n
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_cas_n
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/sdram_we_n
add wave -noupdate -expand -group Top -radix binary /tb_sdram_top/sdram_top_inst/state
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/wr_addr
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/wr_bank_addr
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/wr_cmd
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/wr_data
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/wr_en
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/wr_req
add wave -noupdate -expand -group Top /tb_sdram_top/sdram_top_inst/wr_trig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {215382600 ps} 0}
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
WaveRestoreZoom {212004800 ps} {218558400 ps}




# 结构体设置
virtual type {
    {5'b00001 IDLE}
    {5'b00010 ARBIT}
    {5'b00100 AREF}
    {5'b01000 WRITE}
    {5'b10000 READ}
} fsm_type_top_state;

# 结构体和信号名关联，命名为top_state
virtual function {(fsm_type_top_state)/tb_sdram_top/sdram_top_inst/state} top_state

# 把这个信号添加到波形中
add wave -noupdate /tb_sdram_top/sdram_top_inst/top_state

