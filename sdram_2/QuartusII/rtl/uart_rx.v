module uart_rx(
		//system signal
		input 				clk			,           //如果写为sclk，其意为系统时钟而区别于模块内的时钟
		input 				rst_n		,			//_n means 低电平有效
		//uart interface
		input 				rs232_rx	,
		//others									//在写完系统和接口信号后，其他信号输出可以看时序图中还有什么信号
		output reg [7:0] 	rx_data		,
		output reg			po_flag
);													//注意代码的规范性

//=======================================================================================================\
// ******************************Define Parameter and Internal Signals***********************************
//=======================================================================================================/
	//对照时序图，看需要什么内部变量。先写了reg，在写了上面的参数.最后在下面写到wire的时候在这里补充定义
	//注意定义与格式，其中计数器需要定义它的位数
//实际使用
//localparam		BAUD_END		=	5207			;
//仿真使用
localparam		BAUD_END		=	56				;

localparam		BAUD_M			=	BAUD_END/2 - 1	;
localparam		BIT_END			=	8				;
	
reg							rx_r1					;
reg							rx_r2					;
reg							rx_r3					;
reg							rx_flag					;
reg					[12:0]	baud_cnt				;
reg							bit_flag				;
reg					[ 3:0]	bit_cnt					;

wire						rx_neg					;


//=======================================================================================================\
// ******************************Main Code***********************************
//=======================================================================================================/
	//最开始，对接收的信号打三拍处理
always@(posedge clk or negedge rst_n) begin
if (rst_n == 1'b0)begin
	rx_r1 <= 1'b0;
	rx_r2 <= 1'b0;
	rx_r3 <= 1'b0;end
else begin
	rx_r1 <= rs232_rx;
	rx_r2 <= rx_r1;
	rx_r3 <= rx_r2;end
end

assign rx_neg = (~rx_r2) & (rx_r3);

	//写rx flag的跳变
always@(posedge clk or negedge rst_n)begin
if (rst_n == 1'b0)begin
	rx_flag <= 1'b0;	end
else if(rx_neg == 1'b1)begin 		//这里需要特别注意，仅仅rx_neg == 1'b1能否说明flag拉高？可以。让flag跳高，而不是刷新高，即使数据中刷新高也没有关系
	rx_flag <= 1'b1;	end
else if((bit_cnt == 4'b0) && (baud_cnt == BAUD_END))begin		//寻找flag拉底的条件。（其实这里应该在波形设计时就设计好）     这里后期做了修改
	rx_flag <= 1'b0;	end	
else begin
	rx_flag <= rx_flag;	end
end

	//写bit flag
always@(posedge clk or negedge rst_n)begin
if(rst_n == 1'b0)begin
	bit_flag <= 1'b0;	end
else if(baud_cnt == BAUD_M)begin
	bit_flag <= 1'b1;	end
else begin
	bit_flag <=	1'b0;	end
end

	//写bit cnt
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		bit_cnt <=	4'b0;	end
	else if(bit_flag == 1'b1 && bit_cnt == BIT_END)begin	//注意这里第二句和第三句的先后顺序，ifelse存在优先级
		bit_cnt <= 4'b0;end		
	else if(bit_flag == 1'b1)begin
		bit_cnt <= bit_cnt + 1'b1;	end
	else begin
		bit_cnt <= bit_cnt;end		//这一行到底用不用写呢？
end

	//写rx data
	//key explain:flag信号还要加一个bitcnt条件。因为在起始位时就出现了bit_flag，对照指定的波形图来理解。尽管后面一直有移位操作，但是为了准确这里还是在数据时才接受而起始位不接收
	//保存数据这里需要在理解一下跨时钟域的问题。
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		rx_data <= 8'b0;	end
	else if(bit_flag == 1'b1 && bit_cnt >= 4'd1)begin			//这里是key。
		rx_data <= {rx_data[6:0],rx_r2};	end
	else begin
		rx_data <= rx_data;	end
end

	//写po flag
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		po_flag <= 1'b0;	end
	else if(bit_cnt == BIT_END && bit_flag == 1'b1)begin			//这里是key。
		po_flag <= 1'b1;	end
	else begin
		po_flag <= 1'b0;	end
end


	//写baud cnt
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)begin
		baud_cnt <= 13'b0;	end
	else if(baud_cnt == BAUD_END)begin
		baud_cnt <= 13'b0;	end
	else if(rx_flag == 1'b1)begin
		baud_cnt <= baud_cnt + 1'b1;	end
end

endmodule
	





//在写完代码后检查代码逻辑，代码中的寄存器是否配置好,每一个波形的跳转是否符合波形图
	


