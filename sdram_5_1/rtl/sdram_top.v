module sdram_top(
	//System Signal
	input				clk				,
	input				rst_n			,
	//SDRAM interface
	output				sdram_clk		,
	output				sdram_cke		,
	output				sdram_cs_n		,
	output				sdram_cas_n		,
	output				sdram_ras_n		,
	output				sdram_we_n		,
	output		[1:0]	sdram_bank		,
	output		[11:0]	sdram_addr		,
	output		[1:0]	sdram_dqm		,
	inout		[15:0]	sdram_dq		,
	
	//other
	input				wr_trig
);

//=======================================================================================================\
// ******************************Define Parameter and Internal Signals***********************************
//=======================================================================================================/
localparam IDLE		=	5'b00001;
localparam ARBIT	=	5'b00010;
localparam AREF		=	5'b00100;
localparam WRITE	=	5'b01000;
localparam READ		=	5'b10000;

reg		[11:0]		sdram_addr_reg		;
reg		[3:0]		sdram_cmd_reg		;
reg		[1:0]		sdram_bank_addr_reg	;


	//init module
wire				flag_init_end		;
wire	[3:0]		init_cmd			;
wire	[11:0]		init_addr			;
	
	//arbit仲裁模块
reg		[4:0]		state				;
reg					ref_en				;
reg 				wr_en				;

	//刷新模块ref
wire 				ref_req				;
wire 				flag_ref_end		;
wire	[3:0]		ref_cmd				;
wire	[11:0]		ref_addr			;
reg					ref_req_reg			;

	//写模块wr
wire 				wr_req				;
wire 				flag_wr_end			;
wire	[3:0]		wr_cmd				;
wire	[11:0]		wr_addr				;
wire	[1:0]		wr_bank_addr		;
wire	[15:0]		wr_data				;

//=======================================================================================================\
// ******************************Main Code***********************************
//=======================================================================================================/
	//SDRAM物理接口
assign sdram_clk = ~clk;
assign sdram_cke = 1'b1;
//assign sdram_addr = (state == IDLE)? init_addr : ref_addr;
//assign {sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n} = (state == IDLE)? init_cmd : ref_cmd;
assign sdram_dqm = 2'b00;
always@(*)begin
	case(state)
		IDLE:	begin	sdram_addr_reg <= init_addr;
						sdram_cmd_reg <= init_cmd;end
		AREF:	begin	sdram_addr_reg <= ref_addr;
						sdram_cmd_reg <= ref_cmd;end
		WRITE:	begin	sdram_addr_reg <= wr_addr;
						sdram_cmd_reg <= wr_cmd;
						sdram_bank_addr_reg <=	wr_bank_addr;end
		
		default:begin	sdram_addr_reg <= 12'b0;
						sdram_cmd_reg <= 4'b0111;end  //NOP命令
		endcase
	end
assign sdram_addr = sdram_addr_reg;
assign {sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n} = sdram_cmd_reg;
assign	sdram_bank = sdram_bank_addr_reg;

assign sdram_dq = (state == WRITE) ? wr_data : {16{1'b1}};

	//例化sdram初始化模块
sdram_init sdram_init_inst(
	//System Signal
	.clk				(clk)				,//input				
	.rst_n				(rst_n)				,//input				
	//others
	.cmd_reg			(init_cmd)			,//output	reg	[ 3:0]	
	.sdram_addr			(init_addr)			,//output	reg	[11:0]	
	.flag_init_end		(flag_init_end)		 //output	reg			
	);


	//例化sdram刷新模块
sdram_aref sdram_aref_inst(
	//System Signal
	.clk				(clk),					//input				
	.rst_n				(rst_n),				//input				
	//communicate with ARBIT     
	.ref_en				(ref_en),				//input				
	.ref_req			(ref_req),				//output	wire		
	.flag_ref_end		(flag_ref_end),			//output	reg			
	//others                                 
	.aref_cmd			(ref_cmd),  			//output	reg	[3:0]	
	.sdram_addr			(ref_addr),   		 	//output	wire[11:0]	
	.flag_init_end  	(flag_init_end)     				//input				
);

	//例化sdram写模块
sdram_write sdram_write_inst(
	//System Signals	
	.clk								(clk		)	,							 //     input				
	.rst_n								(rst_n		)	,                            //         input				
	//Communicate with OBRIT           
	.wr_en								(wr_en		)	,                            //         input				
	.wr_req								(wr_req		)	,                            //         output	reg			
	.flag_wr_end						(flag_wr_end)	,                            //     output	reg			
	//others                           
	.ref_req							(ref_req	)	,		//刷新请求信号       //     input				
	.wr_trig							(wr_trig	)	,		//写触发信号         //     input				
	//write interface                   
	.wr_cmd								(wr_cmd		)	,		//写命令             //         output	reg	[ 3:0]	
	.wr_addr							(wr_addr	)	,		//写地址             //     output	reg	[11:0]	
	.bank_addr							(wr_bank_addr)	,		//bank地址           //  	output	reg	[ 1:0]	
	.wr_data							(wr_data	)
);






	//仲裁模块(这里不应该使用三段状态机吗？) 
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0 )begin
		state <= IDLE;	end
	else case(state) 
				IDLE:	if(flag_init_end == 1'b1) state <= ARBIT;
						else state <= IDLE;
				ARBIT:	if(ref_en == 1'b1)  state <= AREF;
						else if(wr_en == 1'b1) state <= WRITE;
						else state <= ARBIT;
				AREF:	if(flag_ref_end == 1'b1) state <= ARBIT;
						else state <= AREF;
				WRITE:	if(flag_wr_end ==1'b1) state <= ARBIT;
						else state <= WRITE;
						
				
				default:state <= IDLE;
			endcase
	end
	
	//产生ref_req_reg			//由于req信号只有一个周期
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0 )begin
		ref_req_reg <= 1'b0;	end
	else if(state == AREF)begin
		ref_req_reg <= 1'b0;end
	else if( ref_req == 1'b1 )begin
		ref_req_reg <= 1'b1;end
	else begin
		ref_req_reg <= ref_req_reg;end
	end
	

	//产生ref_en
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0 )begin
		ref_en <= 1'b0;	end
	else if(state == ARBIT &&( ref_req_reg == 1'b1 ))begin
		ref_en <= 1'b1;end
	else begin
		ref_en <= 1'b0;end
	end

	//产生wr_en
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0 )begin
		wr_en <= 1'b0;	end
	else if(state == ARBIT && wr_req == 1'b1 && ref_req == 1'b0 && ref_req_reg==1'b0 && wr_en == 1'b0)begin    //存在优先级的问题
		wr_en <= 1'b1;end
	else begin
		wr_en <= 1'b0;end
	end





endmodule