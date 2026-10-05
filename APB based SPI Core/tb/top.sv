module top;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import pkg::*;
	bit clk;

	always #5 clk=~clk;


	apb_if avif(clk);
	spi_if svif(clk);
	spi_top_block dut(avif.clk, avif.preset_n, avif.paddr_i, avif.pwrite_i, avif.psel_i, avif.penable_i, avif.pwdata_i, avif.prdata_o, avif.pready_o, avif.pslverr_o, svif.sclk_o, svif.mosi_o, svif.ss_o, svif.miso_i, svif.spi_int_req_o);


	
	initial
		begin
			uvm_config_db#(virtual apb_if)::set(null,"*","apb",avif);
			uvm_config_db#(virtual spi_if)::set(null,"*","spi",svif);

			`ifdef VCS
         		$fsdbDumpvars(0, top);
        		`endif

			clk=1'b0;
			run_test();
		end
endmodule
