module uart (
		//System Signals
		input			clk				,
		input			rst_n			,
		//UART Interface
		input			rs232_rx		,
		output	wire	rs232_tx		
);
														//输入输出只有四根线
//============================================================================\
//***********************Define Parameter and Internal Signals****************
//============================================================================/
wire		[7:0]		rx_data			;
wire					po_flag			;
wire					tx_trig			;
wire		[7:0]		tx_data			;


assign tx_trig	=	po_flag		;
assign tx_data	=	rx_data		;
														//视频中直接连线了，此处定义了这两条线并进行赋值
//============================================================================\
//*******************************Main Code************************************
//============================================================================/
	//例化接收模块和发送模块
uart_rx		uart_rx_init(
	//system signal
	.				clk(clk)			,           //如果写为sclk，其意为系统时钟而区别于模块内的时钟
	. 				rst_n(rst_n)		,			//_n means 低电平有效
	//uart interface
	. 				rs232_rx(rs232_rx)	,
	//others									//在写完系统和接口信号后，其他信号输出可以看时序图中还有什么信号
	.			 	rx_data	(rx_data)	,
	.				po_flag(po_flag)
);

uart_tx uart_tx_init(
	//System Signals
	.				clk(clk)				,
	.				rst_n(rst_n)			,
	//UART Interface
	.				rs232_tx(rs232_tx)			,
	//Others
	.				tx_trig(tx_trig)			,
	.				tx_data(tx_data)			
);
	

endmodule







