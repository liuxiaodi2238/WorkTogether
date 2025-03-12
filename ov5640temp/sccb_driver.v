module sccb_driver(
	//System Signals
	input					clk				,		//50M
	input					rst_n			,
	//Communicate with sccb_cfg
	input					trig			,
	input		[15:0]		driver_addr		,
	input		[ 7:0]		driver_data		,
	output					driver_end		,
	//SCCB interface
	output					scl				,
	output	reg				sda
);

//============================================================================\
//***********************Define Parameter and Internal Signals****************
//============================================================================/
parameter		IDLE		=	1'b0		;
parameter		SEND		=	1'b1		;
parameter		SEND_NUMBER	=	6'd37		;

reg							state			;
reg				[ 5:0]		driver_cnt		;

reg				[15:0]		driver_addr_reg	;
reg				[ 7:0]		driver_data_reg	;

//============================================================================\
//*******************************Main Code************************************
//============================================================================/
	//设置state
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)
		state	<=	IDLE	;
	else if(trig == 1'b1)
		state	<=	SEND	;
	else if((driver_cnt == SEND_NUMBER) && (trig == 1'b0))				//注意这里必须结束标志之后，如果连着写的情况
		state	<=	IDLE	;
	else
		state	<=	state	;
	end

	//设置发送计数器	driver_cnt
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)
		driver_cnt	<=	6'b0	;
else if(driver_end == 1'b1 )				//注意这里的条件
		driver_cnt	<=	6'b0	;
	else if(state == SEND)
		driver_cnt	<=	driver_cnt + 1'b1	;
	else 
		driver_cnt	<=	6'b0	;
	end
	
	//在触发时保存写地址	driver_addr_reg    
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)
		driver_addr_reg	<=	16'b0	;
	else if(state == IDLE && trig == 1'b1)
		driver_addr_reg	<=	driver_addr	;
	else if(driver_end == 1'b1 && trig == 1'b1)
		driver_addr_reg <=	driver_addr	;
	else if(state == IDLE)
		driver_addr_reg <=	16'b0	;
	else 
		driver_addr_reg	<=	driver_addr_reg	;
	end

	//在触发时保存写数据	driver_data_reg
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)
		driver_data_reg	<=	16'b0	;
	else if(state == IDLE && trig == 1'b1)
		driver_data_reg	<=	driver_data	;
	else if(driver_end == 1'b1 && trig == 1'b1)
		driver_data_reg <=	driver_data	;
	else if(state == IDLE)
		driver_data_reg <=	16'b0	;
	else 
		driver_data_reg	<=	driver_data_reg	;
	end

	//设置SCCB物理接口scl	
assign scl =	clk		;

	//设置SCCB物理接口sda_reg
always@(*)begin
	if(rst_n == 1'b0)
		sda	<=	1'b0	;
	else if(state == SEND)begin
		case(driver_cnt)
			0:	sda	<=	1'b1;		//开始标志
			1:	sda	<=	1'b0;
			2:	sda	<=	1'b1;
			3:	sda	<=	1'b1;
			4:	sda	<=	1'b1;
			5:	sda	<=	1'b1;
			6:	sda	<=	1'b0;
			7:	sda	<=	1'b0;
			8:	sda	<=	1'b0;
			9:	sda	<=	1'b0;
			10:	sda	<=	driver_addr_reg[15];
			11:	sda	<=	driver_addr_reg[14];
			12:	sda	<=	driver_addr_reg[13];
			13:	sda	<=	driver_addr_reg[12];
			14:	sda	<=	driver_addr_reg[11];
			15:	sda	<=	driver_addr_reg[10];
			16:	sda	<=	driver_addr_reg[9 ];
			17:	sda	<=	driver_addr_reg[8 ];
			18:	sda	<=	1'b0;
			19:	sda	<=	driver_data_reg[7];
			20:	sda	<=	driver_data_reg[6];
			21:	sda	<=	driver_data_reg[5];		
			22:	sda	<=	driver_data_reg[4];
			23:	sda	<=	driver_data_reg[3];
			24:	sda	<=	driver_data_reg[2];
			25:	sda	<=	driver_data_reg[1];
			26:	sda	<=	driver_data_reg[0];
			27:	sda	<=	1'b1;
			28:	sda	<=	driver_data_reg[7];
			29:	sda	<=	driver_data_reg[6];
			30:	sda	<=	driver_data_reg[5];
			31:	sda	<=	driver_data_reg[4];
			32:	sda	<=	driver_data_reg[3];
			33:	sda	<=	driver_data_reg[2];
			34:	sda	<=	driver_data_reg[1];	
			35:	sda	<=	driver_data_reg[0];
			36:	sda	<=	1'b1;
			37:	sda	<=	1'b1;			//结束标志
		default:sda <=  1'b0;
		endcase
		end
	else sda <=1'b0;
	end
	
	//设置driver_end
assign driver_end = (driver_cnt == 6'd37)? 1'b1 : 1'b0;


endmodule