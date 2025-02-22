virtual type { \
{0x1 IDLE}\
{0x2 ARBIT}\
{0x4 AREF}\
{0x8 WRITE}\
{0x10 READ}\
} fsm_type_top_state
virtual function -install /tb_sdram_top/sdram_top_inst -env /tb_sdram_top { (fsm_type_top_state)/tb_sdram_top/sdram_top_inst/state} top_state
