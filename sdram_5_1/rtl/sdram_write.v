module sdram_write(
	//System Signals
	input				clk				,									//为了替换原来的模块，直接复制了原模块的接口定义
	input				rst_n			,
	//Communicate with OBRIT
	input				wr_en			,
	output				wr_req			,
	output	reg			flag_wr_end		,
	//others
	input				ref_req			,		//刷新请求信号
	input				wr_trig			,		//写触发信号
	
	//write interface
	output	reg	[ 3:0]	wr_cmd			,		//写命令
	output	reg	[11:0]	wr_addr			,		//写地址
	output		[ 1:0]	bank_addr		,		//bank地址
	output	reg	[15:0]	wr_data
);


//=======================================================================================================\
// ******************************Define Parameter and Internal Signals***********************************
//=======================================================================================================/
localparam		S_IDLE	=	5'b00001	;
localparam		S_REQ	=	5'b00010	;
localparam		S_ACT	=	5'b00100	;
localparam		S_WRITE	=	5'b01000	;
localparam		S_PRE	=	5'b10000	;

localparam		CMD_NOP	=	4'b0111		;
localparam		CMD_PRE	=	4'b0010		;
localparam		CMD_AREF=	4'b0001		;
localparam		CMD_ACT	=	4'b0011		;
localparam		CMD_WE	=	4'b0100		;			//A10设置为低


reg						wr_flag			;
reg				[4:0]	state			;
reg				[3:0]	act_cnt			;
reg				[1:0]	brust_cnt		;
reg				[3:0]	pre_cnt			;

reg				[6:0]	col_cnt			;
reg				[11:0]	row_cnt			;
wire						wr_data_end		;
reg						arbit_reg		;



wire					act_end_flag	;	
wire					brust_end_flag	;
wire					row_end_flag	;
wire					pre_end_flag	;

wire			[8:0]	col_addr		;
wire			[11:0]	row_addr		;

//=======================================================================================================\
// ******************************Main Code***********************************
//=======================================================================================================/
	//设置wr_flag
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0)begin
		wr_flag <= 1'b0;end
	else if(wr_trig == 1'b1)begin
		wr_flag <= 1'b1;end
	else if(wr_data_end)begin
		wr_flag <= 1'b0;end
	else begin
		wr_flag <= wr_flag;end
	end
	
	//设置state跳转
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0)begin
		state <= S_IDLE;end
	else case(state)
		S_IDLE:		if(wr_trig == 1'b1) state <= S_REQ;
					else state <= S_IDLE;
		S_REQ:		if(wr_en == 1'b1) state <= S_ACT;
					else state <= S_REQ;
		S_ACT:		if(act_end_flag) state<= S_WRITE;
					else state <= S_REQ;
		S_WRITE:	if(wr_data_end == 1'b1 || row_end_flag == 1'b1 ||arbit_reg == 1'b1)state <= S_PRE;
					else state <= S_WRITE;
		S_PRE:		if(arbit_reg == 1'b1 && wr_flag == 1'b1) state <= S_REQ;
					else if (arbit_reg == 1'b1 && wr_flag == 1'b0) state <= S_IDLE;
					else if(wr_flag == 1'b0) state <= S_IDLE;
					//else if(row_end_flag == 1'b1) state <= S_ACT;												//已经过了一个周期了！！
					else state <= S_ACT;																		
		default:	state <= S_IDLE;
		endcase
	end
		
	//设置wr_req
assign wr_req = (state == S_REQ)? 1'b1 : 1'b0;

	//设置act_cnt   [3:0]
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0)begin
		act_cnt <= 4'b0;end
	else if(state == S_ACT)begin
		act_cnt <= act_cnt +1'b1 ;end
	else begin
		act_cnt <= 4'b0;end
	end

	//设置act_end_flag
assign act_end_flag = (state == S_ACT && act_cnt == 4'b0000) ? 1'b1 : 1'b0;											//换芯片需要改act_cnt数值

	//设置brust_cnt		[1:0]
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0)begin
		brust_cnt <= 2'b0;end
	else if(state == S_WRITE)begin
		brust_cnt <= brust_cnt + 1'b1 ;end
	else begin
		brust_cnt <= 2'b0;end
	end
	
	//设置brust_end_flag
assign brust_end_flag = (state == S_WRITE && brust_cnt == 2'b11) ? 1'b1 : 1'b0;	

	//设置row_end_flag
//assign row_end_flag = (col_cnt == 7'b1111111 && brust_end_flag ==1'b1) ? 1'b1 :1'b0;
assign row_end_flag = (col_addr == 9'b111111111 ) ? 1'b1 :1'b0;

	//设置pre_cnt		[3:0]
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0)begin
		pre_cnt <= 4'b0;end
	else if(state == S_PRE)begin
		pre_cnt <= pre_cnt +1'b1 ;end
	else begin
		pre_cnt <= 4'b0;end
	end
		
	//设置pre_end_flag	
assign pre_end_flag =  (state == S_PRE && pre_cnt == 4'b0) ? 1'b1 : 1'b0;

	//设置wr_cmd												(命令与状态同时，应该使用组合逻辑)
always@(*) begin
	if(rst_n == 1'b0)begin
		wr_cmd <= CMD_NOP;end
	else case(state)
		S_ACT:		if(act_cnt == 4'b0)	wr_cmd <= CMD_ACT;
					else wr_cmd <= CMD_NOP;
		S_WRITE:	if(brust_cnt == 2'b0)	wr_cmd <= CMD_WE;
					else wr_cmd <= CMD_NOP;
		S_PRE:		if(pre_cnt == 4'b0)	wr_cmd <= CMD_PRE;
					else wr_cmd <= CMD_NOP;
		default:	wr_cmd <= CMD_NOP;
		endcase
	end

	//设置flag_wr_end
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0)begin
		flag_wr_end <= 1'b0;end
//	else if(state == S_PRE && (ref_req == 1'b1||arbit_reg == 1'b1 || wr_data_end == 1'b1))begin
	else if(brust_end_flag == 1'b1 && (ref_req == 1'b1||arbit_reg == 1'b1 || wr_data_end == 1'b1))begin
		flag_wr_end <= 1'b1;end
	else begin
		flag_wr_end <= 1'b0;end
	end

	//设置wr_data_end
//always@(posedge clk or negedge rst_n) begin
//	if(rst_n == 1'b0)begin
//		wr_data_end <= 1'b0;end
//	else if(row_addr == 'd1 && col_addr == 'd511 )begin     //☆
//		wr_data_end <= 1'b1;end
//	else begin
//		wr_data_end <= 1'b0;end
//	end
assign wr_data_end = (row_addr == 'd1 && col_addr == 'd511) ? 1'b1 :1'b0 ;

	//设置col_cnt	[6:0]
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0)begin
		col_cnt <= 7'b0;end
	else if(row_end_flag )begin     
		col_cnt <= 7'b0;end
	else if(brust_end_flag == 1'b1)begin
		col_cnt <= col_cnt +1'b1;end
	else begin
		col_cnt <= col_cnt ;end
	end

	//设置col_addr  
assign col_addr = {col_cnt,brust_cnt};

	//设置	//设置row_cnt	[11:0]
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0)begin
		row_cnt <= 12'b0;end
	else if(row_end_flag == 1'b1)begin
		row_cnt <= row_cnt +1'b1;end
	else begin
		row_cnt <= row_cnt ;end
	end

	//设置row_addr  ★似乎不对
assign row_addr = row_cnt;

	//设置abrit_reg
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0)begin
		arbit_reg <= 1'b0;end
	else if( pre_end_flag )begin 
		arbit_reg <= 1'b0;end
	else if((state == S_ACT || state== S_PRE ||state== S_WRITE ) &&ref_req == 1'b1)begin
		arbit_reg <= 1'b1;end
	else begin
		arbit_reg <= arbit_reg;end
	end
	
	//设置对应命令时的其他引脚
always@(*)begin
	if(rst_n == 1'b0)begin
		wr_addr <= 12'b0;end
	else case(wr_cmd)
		CMD_NOP:	wr_addr <= 12'b0;
        CMD_PRE:	wr_addr <= 12'b0100_0000_0000;
        CMD_ACT:	wr_addr <= row_addr;
        CMD_WE :	wr_addr <= {3'b0,col_addr};
		default:	wr_addr <= 12'b0;
		endcase
	end

	//设置bank_addr
assign bank_addr = 2'b00;

	//设置wr_data
always@(*)begin
	if(rst_n == 1'b0) begin
		wr_data <= 16'b0;end
	else case(brust_cnt)
			0:	wr_data <= 16'd3;
			1:	wr_data <= 16'd5;
			2:	wr_data <= 16'd7;
			3:	wr_data <= 16'd9;
			default:wr_data <= 16'd0;
		endcase
	end
	
endmodule