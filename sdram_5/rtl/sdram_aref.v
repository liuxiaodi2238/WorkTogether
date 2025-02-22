module sdram_aref(
	//System Signal
	input				clk				,
	input				rst_n			,
	//communicate with ARBIT
	input				ref_en			,
	output	wire		ref_req			,
	output	wire			flag_ref_end	,
	//others
	output	reg	[3:0]	aref_cmd		,
	output	wire[11:0]	sdram_addr		,
	input				flag_init_end
);

//=======================================================================================================\
// ******************************Define Parameter and Internal Signals***********************************
//=======================================================================================================/
localparam DELAY_15us		=	750		;
localparam CMD_AREF			=	4'b0001	;
localparam CMD_NOP			=	4'b0111	;
localparam CMD_PRE			=	4'b0010	;





reg		[3:0]			cmd_cnt			;		//命令计数器
reg		[9:0]			ref_cnt			;		//刷新的15us计数器	15us=750*20ns

reg						flag_ref		;		//刷新操作的标志











//=======================================================================================================\
// ******************************Main Code***********************************
//=======================================================================================================/
	//15us计数器  ref_cnt
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0 )begin
		ref_cnt <= 10'b0 ;	end
	else if(ref_cnt >= DELAY_15us) begin
		ref_cnt <= 10'b0 ;  end
	else if(flag_init_end) begin
		ref_cnt <= ref_cnt +1'b1; end
	else begin
		ref_cnt <= ref_cnt ;end
	end
	
	//刷新请求   ref_req
assign ref_req = (ref_cnt >= DELAY_15us) ? 1'b1 : 1'b0 ;

	//工作状态：刷新 空闲   flag_ref   
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0 )begin
		flag_ref <= 1'b0 ;	end
	else if(flag_ref_end) begin
		flag_ref <= 1'b0; end
	else if(ref_en)begin
		flag_ref <= 1'b1;	end
	else begin
		flag_ref <= flag_ref; end
	end
	
	//刷新状态下的命令计数器     cmd_cnt     在flag_ref=1时计数
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0 )begin
		cmd_cnt <= 4'b0 ;	end
	else if(flag_ref == 1'b0)begin
		cmd_cnt <= 4'b0 ;	end
	else if(flag_ref == 1'b1)begin
		cmd_cnt <= cmd_cnt + 1'b1 ;	end
	else begin
		cmd_cnt <= cmd_cnt; end
	end

	//根据命令计数器设定命令 aref_cmd
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0 )begin
		aref_cmd <= CMD_NOP ;	end
	else if(flag_ref == 1'b0)begin
		aref_cmd <= CMD_NOP ;	end
	else case(cmd_cnt)
			1:		aref_cmd	<=		CMD_PRE		;
			2:		aref_cmd	<=		CMD_AREF	;
			
			
			default:aref_cmd	<=		CMD_NOP		;
	endcase
end
	//设置指定命令下需要设置的其他引脚
assign sdram_addr = 12'b0100_0000_0000	;				//刷新模块仅在pre这里使用到了addr，只需要一个数即可。故设为固定值。

	//设置flag_ref_end
assign flag_ref_end = (cmd_cnt == 4'd5)	;				//这里可以写的更加完善





endmodule