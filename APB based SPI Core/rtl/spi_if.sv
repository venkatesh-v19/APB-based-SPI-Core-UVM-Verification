interface spi_if(input bit clk);
	logic sclk_o;
	logic ss_o;
	logic mosi_o;
	logic miso_i;
	logic spi_int_req_o;

	clocking drv@(posedge sclk_o);
		default input #1 output #1;
		output miso_i;
		input ss_o;
		input mosi_o;
		input spi_int_req_o;
	endclocking

	clocking mon@(posedge sclk_o);
		default input #1 output #1;
		input miso_i;
		input ss_o;
		input mosi_o;
		input spi_int_req_o;
	endclocking
	
	modport DRV(clocking drv);
	modport MON(clocking mon);
endinterface
