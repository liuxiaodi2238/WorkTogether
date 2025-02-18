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
	//init module
wire				flag_init_end		;
wire	[3:0]		init_cmd			;
wire	[11:0]		init_addr			;



//=======================================================================================================\
// ******************************Main Code***********************************
//=======================================================================================================/
	//SDRAM物理接口
assign sdram_clk = ~clk;
assign sdram_cke = 1'b1;
assign sdram_addr = init_addr;
assign {sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n} = init_cmd;
assign sdram_dqm = 2'b00;



	//例化sdram初始化信号
sdram_init sdram_init_inst(
	//System Signal
	.clk				(clk)				,//input				
	.rst_n				(rst_n)				,//input				
	//others
	.cmd_reg			(init_cmd)			,//output	reg	[ 3:0]	
	.sdram_addr			(init_addr)			,//output	reg	[11:0]	
	.flag_init_end		(flag_init_end)		//output	reg			
	);









endmodule