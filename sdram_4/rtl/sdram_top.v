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
	output		[15:0]	sdram_dq		
	
	//other

);

//=======================================================================================================\
// ******************************Define Parameter and Internal Signals***********************************
//=======================================================================================================/
localparam IDLE		=	5'b00001;
localparam ARBIT	=	5'b00010;
localparam AREF		=	5'b00100;

	//init module
wire				flag_init_end		;
wire	[3:0]		init_cmd			;
wire	[11:0]		init_addr			;
	
	//arbit仲裁模块
reg		[4:0]		state				;
reg					ref_en				;

	//刷新模块ref
wire 				ref_req				;
wire 				flag_ref_end		;
wire	[3:0]		ref_cmd				;
wire	[11:0]		ref_addr			;


//=======================================================================================================\
// ******************************Main Code***********************************
//=======================================================================================================/
	//SDRAM物理接口
assign sdram_clk = ~clk;
assign sdram_cke = 1'b1;
assign sdram_addr = (state == IDLE)? init_addr : ref_addr;
assign {sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n} = (state == IDLE)? init_cmd : ref_cmd;
assign sdram_dqm = 2'b00;


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







	//仲裁模块(这里不应该使用三段状态机吗？) 
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0 )begin
		state <= IDLE;	end
	else case(state) 
				IDLE:	if(flag_init_end == 1'b1) state <= ARBIT;
						else state <= IDLE;
				ARBIT:	if(ref_en == 1'b1)  state <= AREF;
						//else if(ref_req == )
						else state <= ARBIT;
				AREF:	if(flag_ref_end == 1'b1) state <= ARBIT;
						else state <= AREF;
				
				
				default:state <= IDLE;
			endcase
	end
	

	//产生ref_en
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0 )begin
		ref_en <= 1'b0;	end
	else if(state == ARBIT && ref_req == 1'b1)begin
		ref_en <= 1'b1;end
	else begin
		ref_en <= 1'b0;end
	end







endmodule