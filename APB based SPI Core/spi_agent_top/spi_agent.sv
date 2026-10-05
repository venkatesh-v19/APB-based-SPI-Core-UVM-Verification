class spi_agent extends uvm_agent;
	`uvm_component_utils(spi_agent)
	spi_agent_config scfg;
	spi_driver drvh;
	spi_monitor monh;
	spi_sequencer seqrh;

	function new(string name="spi_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(spi_agent_config)::get(this, " ", "spi",scfg))
			$display("Error to get spi config");

		monh=spi_monitor::type_id::create("monh", this);
		if(scfg.is_active==UVM_ACTIVE)
			begin
				seqrh=spi_sequencer::type_id::create("seqrh", this);
				drvh=spi_driver::type_id::create("drvh", this);
			end
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(scfg.is_active)
			drvh.seq_item_port.connect(seqrh.seq_item_export);
	endfunction
endclass
