`timescale 1ns/1ns

module tb_cmd_decode();

reg			clk			;
reg			rst_n		;

reg			uart_flag	;
reg	 [7:0]	uart_data	;

wire wfifo_wr_en	;
wire [7:0] wfifo_data		;
wire wr_trig		;
wire rd_trig		;

initial begin
	clk			<=	1	;
	rst_n		<=	0	;
	#100
	rst_n		<=	1	;
	end
	
always #10	clk	=	~clk	;


initial begin
	uart_flag   =    0;
	uart_data   =    0;
	#200
	uart_flag	=	1;
	uart_data	=	8'h55;
	#10
	uart_flag	=	0;
	#200
	uart_flag	=	1;
	uart_data	=	8'h12;
	#10
	uart_flag	=	0;
	#200
	uart_flag	=	1;
	uart_data	=	8'h34;
	#10
	uart_flag	=	0;
	#200
	uart_flag	=	1;
	uart_data	=	8'h56;
	#10
	uart_flag	=	0;
	#200
	uart_flag	=	1;
	uart_data	=	8'h78;
	#10
	uart_flag	=	0;
	#200
	uart_flag	=	1;
	uart_data	=	8'haa;
	#10
	uart_flag	=	0;
end







cmd_decode cmd_decode_inst(
	.clk				(clk		)		,	    // input				
	.rst_n				(rst_n		)		,       // input				
	.uart_flag			(uart_flag		)		,       // input				
	.uart_data			(uart_data		)		,       // input		[ 7:0]	
	.wfifo_wr_en		(wfifo_wr_en)		,       // output				
	.wfifo_data			(wfifo_data	)		,       // output				
	.wr_trig			(wr_trig	)		,       // output 				
	.rd_trig			(rd_trig	)		       // output				
	
);


endmodule