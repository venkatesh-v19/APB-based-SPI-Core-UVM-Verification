class spi_transaction extends uvm_sequence_item;
	`uvm_object_utils(spi_transaction)

	logic sclk_o;
	logic ss_o;
	logic [7:0]mosi_o;
	rand logic[7:0] miso_i;
	

	function new(string name="spi_transaction");
		super.new(name);
	endfunction
	
	function display(string msg);
		$display("Class=%s, miso_i=%0d, mosi_o=%0d",msg,miso_i,mosi_o);
  	endfunction

endclass
