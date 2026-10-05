class apb_transaction extends uvm_sequence_item;
	logic pclk;
	rand logic preset_n;
	rand logic [2:0]paddr_i;
	rand logic pwrite_i;
	logic psel_i;
	logic penable_i;
	rand logic [7:0]pwdata_i;
	logic [7:0]prdata_o;
	logic pready_o;
	logic pslverr_o;
	
	constraint addr{paddr_i inside{[0:3],5};}
	`uvm_object_utils_begin(apb_transaction)
		`uvm_field_int(pclk,UVM_ALL_ON)
		`uvm_field_int(preset_n,UVM_ALL_ON)
		`uvm_field_int(paddr_i,UVM_ALL_ON)
		`uvm_field_int(pwrite_i,UVM_ALL_ON)
		`uvm_field_int(psel_i,UVM_ALL_ON)
		`uvm_field_int(penable_i,UVM_ALL_ON)
		`uvm_field_int(pwdata_i,UVM_ALL_ON)
		`uvm_field_int(prdata_o,UVM_ALL_ON)
		`uvm_field_int(pready_o,UVM_ALL_ON)
		`uvm_field_int(pslverr_o,UVM_ALL_ON)
	`uvm_object_utils_end
	function new(string name="apb_transaction");
		super.new(name);
	endfunction

	function display(string msg);
		$display("Class=%s, preset_n=%0d, paddr_i=%0d, psel_i=%0d, penable_i=%0d, pwrite_i=%0d, pwdata_i=%0d",msg,preset_n,paddr_i,psel_i,penable_i,pwrite_i,pwdata_i);
  	endfunction

endclass
