module sdram_write(
	//System Signals
	input				clk				,
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

//============================================================================\
//***********************Define Parameter and Internal Signals****************
//============================================================================/
localparam		S_IDLE	=	5'b00001	;
localparam		S_REQ	=	5'b00010	;
localparam		S_ACT	=	5'b00100	;
localparam		S_WRITE	=	5'b01000	;
localparam		S_BREAK	=	5'b10000	;

localparam		CMD_NOP	=	4'b0111		;
localparam		CMD_PRE	=	4'b0010		;
localparam		CMD_AREF=	4'b0001		;
localparam		CMD_ACT	=	4'b0011		;
localparam		CMD_WE	=	4'b0100		;			//A10设置为低


reg					flag_wr				;
reg		[4:0]		state				;
reg					flag_act_end		;
reg					flag_pre_end		;
reg					flag_row_end		;
reg		[1:0]		brust_cnt			;
reg		[1:0]		brust_cnt_t			;
reg					wr_data_end			;

reg		[3:0]		act_cnt				;
reg		[3:0]		break_cnt			;
reg		[6:0]		col_cnt				;

reg		[11:0]		row_addr			;
wire	[8:0]		col_addr			;





//============================================================================\
//*******************************Main Code************************************
//============================================================================/
	//设置flag_wr
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		flag_wr <= 1'b0	;end
	else if(wr_data_end==1'b1)begin
		flag_wr <= 1'b0	;end
	else if(wr_trig== 1'b1)begin
		flag_wr <= 1'b1	;end
	else begin
		flag_wr <= flag_wr;end
	end

	//设置state    (和视频写的不一样)
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		state <= S_IDLE	;end
	else case(state)
			S_IDLE:		if(wr_trig == 1'b1) state <= S_REQ;
						else state <= S_IDLE ;
			S_REQ:		if(wr_en == 1'b1) state <= S_ACT;
						else state <= S_REQ ;
			S_ACT:		if(flag_act_end == 1'b1) state <= S_WRITE ;
						else state <= S_ACT;
			S_WRITE:	if((ref_req == 1'b1)||(wr_data_end == 1'b1)||(flag_row_end == 1'b1) ) state <= S_BREAK ;
						else state <= S_WRITE;
	
			S_BREAK:	if((ref_req == 1'b1)&&(brust_cnt == 4'd3)) state <= S_REQ ;
						else if(flag_pre_end == 1'b1  &&  flag_wr == 1'b1) state <= S_ACT ;			//1这里要体现先后顺序；2这里没有体现同一行连续写的情况
						else if(wr_data_end == 1'b1) state <= S_IDLE ;
						else state <= S_BREAK;
			default:	state <= S_IDLE;
		endcase
	end
	
	//设置wr_req
assign wr_req = (state == S_REQ)? 1'b1 : 1'b0;

	//End信号---1.flag_act_end
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		flag_act_end <= 1'b0	;end
	else if(act_cnt == 4'd0 && state == S_ACT)begin					//理论上这里只需要cnt计数值，但是这里只要1个时钟周期，计数值还是0.不加其他条件会导致该信号常高.(除了state还可以用命令cmd来检测)
		flag_act_end <= 1'b1	;end
	else begin
		flag_act_end <= 1'b0	;end
	end
	
	//End信号---2.flag_pre_end
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		flag_pre_end <= 1'b0	;end
	else if(break_cnt == 4'd0 && state == S_BREAK )begin					//理论上这里只需要cnt计数值，但是这里只要1个时钟周期，计数值还是0.不加其他条件会导致该信号常高
		flag_pre_end <= 1'b1	;end
	else begin
		flag_pre_end <= 1'b0	;end
	end


	//act计数器		[3:0]		act_cnt
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		act_cnt <= 4'b0	;end
	else if(state == S_ACT)begin
		act_cnt <= act_cnt + 1'b1	;end
	else begin
		act_cnt <= 4'b0	;end										//这里不在sct状态对其cnt计数器清零是为了防止溢出
	end
	
	//pre计数器		[3:0]		break_cnt
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		break_cnt <= 4'b0	;end
	else if(state == S_BREAK)begin
		break_cnt <= break_cnt + 1'b1	;end
	else begin
		break_cnt <= 4'b0	;end
	end

	//brust计数器与延拍	[1:0]		brust_cnt
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		brust_cnt <= 2'b0	;end
	else if(state == S_WRITE)begin
		brust_cnt <= brust_cnt + 1'b1	;end
	else begin
		brust_cnt <= 2'b0	;end
	end

always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		brust_cnt_t <= 2'b0	;end
	else begin
		brust_cnt_t <= brust_cnt	;end
	end

	//数据写完标志		wr_data_end							
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		wr_data_end <= 1'b0	;end
	else if(row_addr == 'd1 && col_addr == 'd511)begin					//这个条件是由于要写两行数据
		wr_data_end <= 1'b1	;end
	else begin
		wr_data_end <= 1'b0 ;end
	end

	//col_cnt
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		col_cnt <= 7'b0	;end
	else if(col_addr=='d511 && brust_cnt_t == 'd3)begin
		col_cnt <= 7'b0 ;end
	else if(brust_cnt_t == 'd3 )begin					//这个条件是由于要写两行数据
		col_cnt <= col_cnt +1'b1	;end
	else begin
		col_cnt <= col_cnt ;end
	end

	//col_地址
assign col_addr = {col_cnt,brust_cnt_t};

	
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		row_addr <= 12'b0;end
	else if(flag_row_end == 1'b1)begin
		row_addr <= row_addr+1'b1;end
	else begin
		row_addr <= row_addr;end
	end
	
	
	
	
	//CMD		[ 3:0]	wr_cmd
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		wr_cmd <= CMD_NOP;end
	else case(state)
		S_ACT:		if(act_cnt == 'd0) wr_cmd <= CMD_ACT;
					else wr_cmd <= CMD_NOP;
		S_WRITE:	if(brust_cnt == 'd0) wr_cmd <=CMD_WE;
					else wr_cmd <= CMD_NOP;
		S_BREAK:	if(break_cnt== 'd0) wr_cmd <= CMD_PRE;
					else wr_cmd <= CMD_NOP;
		default:	wr_cmd <= CMD_NOP;
		endcase
	end
	
	//wr_addr    [11:0]
always@(*)begin
	if(rst_n == 1'b0)begin
		wr_addr <= 12'b0;end
	else case(state)						//act命令，写命令需要地址；recharge需要设置A10。由于仅需保留一个周期，判断条件与命令是一致的。本质在于state+计数器。用命令的话会慢一拍
		S_ACT:		if(act_cnt == 'd0) wr_addr <= row_addr;
					else wr_addr <= row_addr;
		S_WRITE:	if(brust_cnt == 'd0) wr_addr <= {3'b010,col_addr};
					else wr_addr <= row_addr;
		S_BREAK:	if(break_cnt== 'd0) wr_cmd <= 12'd010000000000;
					else wr_addr <= 12'd010000000000;
		default:	wr_addr <= 12'd010000000000;
	endcase
	end

	//bank地址
	assign bank_addr = 2'b00;
	
	
	//生成写数据
always@(*)begin
	case(brust_cnt)
		0:		wr_data <= 'd3;
		1:		wr_data <= 'd5;
		2:		wr_data <= 'd7;
		3:		wr_data <= 'd9;
	default: 		wr_data <= 'd1;
	endcase
end

	//产生flag_wr_end 										★这块条件比较不好判断
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		flag_wr_end <= 1'b0;end
	else if(state == S_BREAK && ref_req == 1'b1) begin
		flag_wr_end <= 1'b1;end
	else begin
		flag_wr_end <= 1'b0;end
	end
	
	//flag_row_end
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		flag_row_end <= 1'b0;end
	else if(col_addr == 'd510) begin
		flag_wr_end <= 1'b1;end
	else begin
		flag_row_end<=	1'b0;end
	end

endmodule

