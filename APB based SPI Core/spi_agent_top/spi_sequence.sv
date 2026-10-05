class spi_sequence extends uvm_sequence#(spi_transaction);
	`uvm_object_utils(spi_sequence)

	function new(string name="spi_sequence");
		super.new(name);
	endfunction

	task body();
		repeat(1)
		begin
			req=spi_transaction::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	endtask
endclass
