`timescale 1ns/1ns

module tb_uart_tx();
reg			clk		;
reg			rst_n	;
reg			tx_trig	;
reg	[7:0]	tx_data	;		

wire		rs232_tx;

//================Define System Signals======================
	//产生初始化信号	自上向下延时累计
	initial begin
			clk			=	1		;
			rst_n		<=	0		;
			#100
			rst_n		<=	1		;
	end
	//产生时钟信号
	always	#5		clk	=	~clk	;
	

//================产生串口数据发送信号========================
initial begin
	tx_data		<=		8'd0	;
	tx_trig		<=		1'b0	;
	#200
	tx_trig		<=		1'b1	;
	tx_data		<=		8'h55	;
	#10
	tx_trig		<=		1'b0	;
end



//=================仿真模块例化=================================

uart_tx uart_tx_init(
	//System Signals
	.clk(clk)				,
	.rst_n(rst_n)			,
	//UART Interface
	.rs232_tx(rs232_tx)			,
	//Others
	.tx_trig(tx_trig)			,
	.tx_data(tx_data)
);	

endmodule
