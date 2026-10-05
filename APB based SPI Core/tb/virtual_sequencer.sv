class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);
	`uvm_component_utils(virtual_sequencer)

	apb_sequencer a_seqrh;
	spi_sequencer s_seqrh;

	function new(string name="virtual_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction
endclass
