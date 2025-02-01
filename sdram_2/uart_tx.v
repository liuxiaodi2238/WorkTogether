module uart_tx(
	//System Signals
	input				clk				,
	input				rst_n			,
	//UART Interface
	output	reg			rs232_tx			,
	//Others
	input				tx_trig			,
	input		[7:0]	tx_data			
);

//============================================================================\
//***********************Define Parameter and Internal Signals****************
//============================================================================/
//实际使用
//localparam		BAUD_END		=	5207			;
//仿真使用
localparam		BAUD_END		=	56				;

localparam		BAUD_M			=	BAUD_END/2 - 1	;
localparam		BIT_END			=	8				;


reg		[7:0]			tx_data_reg		;
reg						tx_flag			;
reg		[12:0]			baud_cnt		;
reg						bit_flag		;
reg		[3:0]			bit_cnt			;

//============================================================================\
//*******************************Main Code************************************
//============================================================================/

	//tx_data_reg
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		tx_data_reg <= 8'b0;	end
	else if((tx_trig == 1'b1)&&(tx_flag == 1'b0))begin
		tx_data_reg <= tx_data;	end
	else begin
		tx_data_reg <= tx_data_reg;	end
end
			//思考意外情况，在发送时出现tx_trig则会扰乱正常的发送过程。因此需要增加限制条件。
	
	//tx_flag
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		tx_flag <= 1'b0;	end
	else if((tx_trig == 1'b1)&&(tx_flag == 1'b0))begin
		tx_flag <= 1'b1;	end
	else if((bit_cnt == BIT_END) && (baud_cnt == BAUD_END))begin
		tx_flag <= 1'b0;	end
	else begin
		tx_flag <= tx_flag;	end
end
			//flag拉高条件，跳高 避免“刷新高”。拉低条件：发送结束（视频写的是bit_flag=1&&bit_cnt=BIT_END）

	//baud_cnt
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		baud_cnt <= 13'b0;	end
	else if(baud_cnt == BAUD_END)begin
		baud_cnt <= 13'b0;	end
	else if(tx_flag == 1'b1)begin
		baud_cnt <= baud_cnt + 1'b1;	end
	else begin
		baud_cnt <= baud_cnt;	end
end
			//这里视频里面写的是最后一个其他条件baud=0。我和视频写的不一样
			
	//bit_flag
always@(posedge clk or negedge rst_n)begin
	if (rst_n == 1'b0)begin
		bit_flag <= 1'b0;	end
	else if(baud_cnt == BAUD_END)begin
		bit_flag <= 1'b1;	end
	else begin
		bit_flag <= 1'b0;	end
end


	//bit_cnt
always@(posedge clk or negedge rst_n)begin
	if (rst_n == 1'b0)begin
		bit_cnt <= 4'b0;	end
	else if((bit_cnt == BIT_END)&&(bit_flag == 1'b1))begin    //这一行的转换条件差点写错。记满8以后还要再记到BIT_END(非最小时钟)
		bit_cnt <= 4'b0;	end
	else if(bit_flag == 1'b1)begin
		bit_cnt <= bit_cnt +1'b1;	end
	else begin
		bit_cnt <=	bit_cnt;	end
end

	//rs232_tx
always@(posedge clk or negedge rst_n)begin
	if (rst_n == 1'b0)begin
		rs232_tx <= 1'b1;	end                                  //这里的默认是高电平。空闲状态为1
	else if(tx_flag == 1'b1 )begin
		case(bit_cnt)
			0:			rs232_tx <= 1'b0;
			1:			rs232_tx <= tx_data_reg[7];
			2:			rs232_tx <= tx_data_reg[6];
			3:			rs232_tx <= tx_data_reg[5];
			4:			rs232_tx <= tx_data_reg[4];
			5:			rs232_tx <= tx_data_reg[3];
			6:			rs232_tx <= tx_data_reg[2];
			7:			rs232_tx <= tx_data_reg[1];
			8:			rs232_tx <= tx_data_reg[0];					//注意数组顺序问题；终止位问题？？
			default:	rs232_tx <= 1'b1;
		endcase
		end
	else begin
		rs232_tx <= 1'b1;	end
end

			//在本工程中不需要设置停止位。这块没理解。

endmodule
