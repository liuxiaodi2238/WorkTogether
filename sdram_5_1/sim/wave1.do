onerror {resume}
virtual type { \
{0x1 IDLE}\
{0x2 ARBIT}\
{0x4 AREF}\
{0x8 WRITE}\
{0x10 READ}\
} fsm_type_top_state
virtual type { \
{0x1 S_IDLE}\
{0x2 S_REQ}\
{0x4 S_ACT}\
{0x8 S_WRITE}\
{0x10 S_PRE}\
} fsm_type_write_state
quietly virtual function -install /tb_sdram_top/sdram_top_inst -env /tb_sdram_top { (fsm_type_top_state)/tb_sdram_top/sdram_top_inst/state} top_state
quietly virtual function -install /tb_sdram_top/sdram_top_inst/sdram_write_inst -env /tb_sdram_top { (fsm_type_write_state)/tb_sdram_top/sdram_top_inst/sdram_write_inst/state} write_state
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_sdram_top/sdram_top_inst/top_state
add wave -noupdate /tb_sdram_top/sdram_top_inst/sdram_write_inst/write_state
add wave -noupdate -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/clk
add wave -noupdate -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/cmd_cnt
add wave -noupdate -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/cmd_reg
add wave -noupdate -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/cnt_200us
add wave -noupdate -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/flag_200us
add wave -noupdate -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/flag_init_end
add wave -noupdate -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/rst_n
add wave -noupdate -group init /tb_sdram_top/sdram_top_inst/sdram_init_inst/sdram_addr
add wave -noupdate -group aref /tb_sdram_top/sdram_top_inst/sdram_aref_inst/aref_cmd
add wave -noupdate -group aref /tb_sdram_top/sdram_top_inst/sdram_aref_inst/clk
add wave -noupdate -group aref /tb_sdram_top/sdram_top_inst/sdram_aref_inst/cmd_cnt
add wave -noupdate -group aref /tb_sdram_top/sdram_top_inst/sdram_aref_inst/flag_init_end
add wave -noupdate -group aref /tb_sdram_top/sdram_top_inst/sdram_aref_inst/flag_ref
add wave -noupdate -group aref /tb_sdram_top/sdram_top_inst/sdram_aref_inst/flag_ref_end
add wave -noupdate -group aref /tb_sdram_top/sdram_top_inst/sdram_aref_inst/ref_cnt
add wave -noupdate -group aref /tb_sdram_top/sdram_top_inst/sdram_aref_inst/ref_en
add wave -noupdate -group aref /tb_sdram_top/sdram_top_inst/sdram_aref_inst/ref_req
add wave -noupdate -group aref /tb_sdram_top/sdram_top_inst/sdram_aref_inst/rst_n
add wave -noupdate -group aref /tb_sdram_top/sdram_top_inst/sdram_aref_inst/sdram_addr
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/act_cnt
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/act_end_flag
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/arbit_reg
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/bank_addr
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/brust_cnt
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/brust_end_flag
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/clk
add wave -noupdate -expand -group write -radix unsigned /tb_sdram_top/sdram_top_inst/sdram_write_inst/col_addr
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/col_cnt
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/flag_wr_end
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/pre_cnt
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/pre_end_flag
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/ref_req
add wave -noupdate -expand -group write -radix decimal /tb_sdram_top/sdram_top_inst/sdram_write_inst/row_addr
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/row_cnt
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/row_end_flag
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/rst_n
add wave -noupdate -expand -group write -radix binary /tb_sdram_top/sdram_top_inst/sdram_write_inst/state
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_addr
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_cmd
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_data
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_data_end
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_en
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_flag
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_req
add wave -noupdate -expand -group write /tb_sdram_top/sdram_top_inst/sdram_write_inst/wr_trig
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/clk
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/flag_init_end
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/flag_ref_end
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/flag_wr_end
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/init_addr
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/init_cmd
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/ref_addr
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/ref_cmd
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/ref_en
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/ref_req
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/ref_req_reg
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/rst_n
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/sdram_addr
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/sdram_addr_reg
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/sdram_bank
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/sdram_bank_addr_reg
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/sdram_cke
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/sdram_clk
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/sdram_cmd_reg
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/sdram_dq
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/sdram_dqm
add wave -noupdate -group TOP -expand -group sdram_cmd /tb_sdram_top/sdram_top_inst/sdram_cs_n
add wave -noupdate -group TOP -expand -group sdram_cmd /tb_sdram_top/sdram_top_inst/sdram_ras_n
add wave -noupdate -group TOP -expand -group sdram_cmd /tb_sdram_top/sdram_top_inst/sdram_cas_n
add wave -noupdate -group TOP -expand -group sdram_cmd /tb_sdram_top/sdram_top_inst/sdram_we_n
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/state
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/wr_addr
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/wr_bank_addr
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/wr_cmd
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/wr_data
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/wr_en
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/wr_req
add wave -noupdate -group TOP /tb_sdram_top/sdram_top_inst/wr_trig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {231093700 ps} 0}
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
WaveRestoreZoom {230260800 ps} {231899200 ps}
