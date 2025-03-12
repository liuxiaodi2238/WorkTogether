module cmd_decode(
	//system signals
	input				clk				,
	input				rst_n			,
	//Uart input(from usrt_rx module)
	input				uart_flag		,
	input		[ 7:0]	uart_data		,
	//Communicate with wfifo
	output				wfifo_wr_en		,
	output		[7:0]		wfifo_data		,
	//Communicate with sdram_controler
	output 				wr_trig			,
	output				rd_trig			
	//
	
	
);
//============================================================================\
//***********************Define Parameter and Internal Signals****************
//============================================================================/
localparam		REC_NUM_END	=	3'd4	;

reg				[ 2:0]	rec_num			;
reg				[ 7:0]	cmd_reg			;

//============================================================================\
//*******************************Main Code************************************
//============================================================================/
always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)
		rec_num <= 3'b0;
	else if(uart_flag == 1'b1 && rec_num == REC_NUM_END)
		rec_num <= 3'b0;
	else if(uart_flag == 1'b1 && rec_num == 8'haa)
		rec_num <= 3'b0;
	else if(uart_flag == 1'b1)
		rec_num <= rec_num + 3'b001;
	else	
		rec_num <= rec_num;
	end

always@(posedge clk or negedge rst_n)begin
	if(rst_n == 1'b0)
		cmd_reg <= 8'b0;
	else if(rec_num == 'd0 && uart_flag == 1'b1)
		cmd_reg <= uart_data;
	else
		cmd_reg <= cmd_reg;
	end

assign wr_trig = (rec_num == REC_NUM_END)? uart_flag : 1'b0;
assign rd_trig = (rec_num == 'd0 && uart_data == 8'haa) ? uart_flag : 1'b0;

assign wfifo_wr_en = (rec_num >= 'd1) ? uart_flag : 1'b0;
assign wfifo_data =( wfifo_wr_en == 1'b1 ) ? uart_data : 8'b0;





endmodule