virtual type { \
{0x1 IDLE}\
{0x2 ARBIT}\
{0x4 AREF}\
{0x8 WRITE}\
{0x10 READ}\
} fsm_type_top_state
virtual function -install /tb_sdram_top/sdram_top_inst -env /tb_sdram_top { (fsm_type_top_state)/tb_sdram_top/sdram_top_inst/state} top_state
virtual type { \
{0x1 IDLE}\
{0x2 ARBIT}\
{0x4 AREF}\
{0x8 WRITE}\
{0x10 READ}\
} fsm_type_top_state
virtual function -install /tb_sdram_top/sdram_top_inst -env /tb_sdram_top { (fsm_type_top_state)/tb_sdram_top/sdram_top_inst/state} top_state
virtual type { 	5'b00001	S_IDLE			5'b00010	S_REQ			5'b00100	S_ACT			5'b01000	S_WRITE			5'b10000	S_PRE		} fsm_type_write_state
virtual type { \
{0x1 IDLE}\
{0x2 ARBIT}\
{0x4 AREF}\
{0x8 WRITE}\
{0x10 READ}\
} fsm_type_top_state
virtual function -install /tb_sdram_top/sdram_top_inst -env /tb_sdram_top { (fsm_type_top_state)/tb_sdram_top/sdram_top_inst/state} top_state
virtual function -install /tb_sdram_top/sdram_top_inst/sdram_write_inst -env /tb_sdram_top { (fsm_type_write_state)/tb_sdram_top/sdram_top_inst/sdram_write_inst/state} write_state
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
virtual function -install /tb_sdram_top/sdram_top_inst -env /tb_sdram_top { (fsm_type_top_state)/tb_sdram_top/sdram_top_inst/state} top_state
virtual function -install /tb_sdram_top/sdram_top_inst/sdram_write_inst -env /tb_sdram_top { (fsm_type_write_state)/tb_sdram_top/sdram_top_inst/sdram_write_inst/state} write_state
