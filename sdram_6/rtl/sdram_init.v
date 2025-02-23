module sdram_init(
	//System Signal
	input				clk				,
	input				rst_n			,
	//others
	output	reg	[ 3:0]	cmd_reg			,
	output		[11:0]	sdram_addr		,
	output	reg			flag_init_end	
);

//=======================================================================================================\
// ******************************Define Parameter and Internal Signals***********************************
//=======================================================================================================/
localparam	DELAY_200US		=	10000;
//SDRAM CMD
localparam	NOP				=	4'b0111	;	
localparam	Precharge		=	4'b0010	;
localparam	AutoRefresh		=	4'b0001	;
localparam	ModeSet			=	4'b0000	;

reg			[13:0]		cnt_200us		;
wire					flag_200us		;
reg			[3:0]		cmd_cnt			;




//=======================================================================================================\
// ******************************Main Code***********************************
//=======================================================================================================/
	//200us计数和flag信号产生
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		cnt_200us <= 14'b0;	end
	else if(flag_200us == 1'b0)begin
		cnt_200us <= cnt_200us + 1'b1;end
	else begin
		cnt_200us <= cnt_200us;end
	end
assign flag_200us = (cnt_200us >= DELAY_200US) ? 1'b1 : 1'b0 ;
	
	//程序计数器cmd_cnt
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		cmd_cnt <= 4'b0;	end
	else if(flag_200us ==1'b1 && flag_init_end == 1'b0)begin
		cmd_cnt <= cmd_cnt + 1'b1;end
	else begin
		cmd_cnt <= cmd_cnt;end
	end

	//根据程序计数器输出4位的命令（命令真值）   写寄存器cmd_reg
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		cmd_reg <= NOP	;end      //这里是指200ms内不能有操作，所以是NOP，如果归零会变成配置模式寄存器命令
	else if(flag_200us == 1'b1)begin
		case(cmd_cnt)	0:		cmd_reg <=	Precharge	;
						1:		cmd_reg <=	AutoRefresh	;
						5:		cmd_reg <=	AutoRefresh	;
						9:		cmd_reg <=	ModeSet		;
						default:cmd_reg	<=	NOP			;	//看波形图，在不是关键时刻的时候，reg实际上是灰色的，即不关心。在这里我们设置为nop
		endcase
		end
	end
	//SDRAM ADDR    设置sdram_addr
	//方法一：根据程序计数器在对应时刻设置；方法二：根据cmd_reg使用case语句，组合逻辑得到
/*
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		sdram_addr <= 12'd0;end
	else if(flag_200us == 1'b1)begin
		case(cmd_cnt)	0: 		sdram_addr <= 12'b0100_0000_0000; //第一位是A11                                //在precharge时，需要把A10拉高
						9:		sdram_addr <= 12'b0000_0011_0010;
					default:	sdram_addr <= 12'b0000_0000_0000;
		endcase
		end
	else sdram_addr <= sdram_addr;
	end
*/

assign sdram_addr = (cmd_reg == ModeSet) ? 12'b0000_0011_0010 : 12'b0100_0000_0000;

	//设置flag_init_end
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		flag_init_end <= 1'b0 ;end
	else if(cmd_cnt == 4'd10)begin        //这里使得cmd_cnt=9的时候，初始化完成标志尚未拉高，计数器能够计数到10
		flag_init_end <= 1'b1 ;end
	else begin
		flag_init_end <= flag_init_end;end
	end
	
//另一种方法
//assign flag_init_end = (cmd_cnt >= 'd 10) ? 1'b1 : 1'b0 ;
	
endmodule