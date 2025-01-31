//

`timescale		1ns/1ns

module tb_uart_rx;

reg					clk;
reg					rst_n;
reg					rs232_tx;

wire				po_flag;
wire	[7:0]		rx_data;


initial begin
	clk			=		1;
	rst_n		<=		0;
	rs232_tx	<=		1;
	
	#100
	rst_n		<=		1;	//经过100ns释放复位信号
	#100
	tx_byte();
end

always #5 clk	=		~clk;

//使用task任务完成对串口发送的模拟.task的语法可以自己学习一下。
//for只能用于仿真

task tx_bit(
	input	[7:0]	data
	);
	integer i;											//定义了一个整型变量
	for(i=0;i<10;i=i+1)begin
		case(i)
			0:		rs232_tx		<=		1'b0;
			1:		rs232_tx		<=		data[0];
			2:		rs232_tx		<=		data[1];
			3:		rs232_tx		<=		data[2];
			4:		rs232_tx		<=		data[3];
			5:		rs232_tx		<=		data[4];
			6:		rs232_tx		<=		data[5];
			7:		rs232_tx		<=		data[6];
			8:		rs232_tx		<=		data[7];
			9:		rs232_tx		<=		1'b1;
		endcase
		#560;
	end
endtask
		
//另一种方法：存储器
reg			[7:0]	mem_a	[3:0]	;
initial		$readmemh("./tx_data.txt",mem_a);

task tx_byte();
	integer i;
	for(i=0;i<4;i=i+1)begin
		tx_bit(mem_a[i]);
	end
endtask


 uart_rx uart_rx_inst(
		//system signal
		.clk					(clk),           //如果写为sclk，其意为系统时钟而区别于模块内的时钟
		.rst_n					(rst_n),			//_n means 低电平有效
		//uart interface		
		.rs232_rx				(rs232_tx),
		//others											//在写完系统和接口信号后，其他信号输出可以看时序图中还有什么信号
		.rx_data				(rx_data),
		.po_flag				(po_flag)
);	

endmodule