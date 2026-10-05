interface apb_if(input bit clk);
	bit pclk;
	logic [2:0]paddr_i;
	logic pwrite_i;
	logic psel_i;
	logic penable_i;
	logic [7:0]pwdata_i;
	logic [7:0]prdata_o;
	logic pready_o;
	logic pslverr_o;
	logic preset_n;

	assign pclk=clk;

	clocking drv@(posedge pclk);
		default input #1 output #1;
		output preset_n;
		output paddr_i; 
		output pwrite_i;
		output psel_i;
		output penable_i;
		output pwdata_i;
		input prdata_o;
		input pready_o;
		input pslverr_o;
	endclocking

	clocking mon@(posedge pclk);
		default input #1 output #1;
		input preset_n;
		input paddr_i;
		input pwrite_i;
		input psel_i;
		input penable_i;
		input pwdata_i;
		input prdata_o;
		input pready_o;
		input pslverr_o;
	endclocking

	modport DRV(clocking drv);
	modport MON(clocking mon);
endinterface
