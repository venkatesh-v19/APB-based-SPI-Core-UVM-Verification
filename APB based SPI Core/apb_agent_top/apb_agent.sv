class apb_agent extends uvm_agent;
	`uvm_component_utils(apb_agent)
	apb_agent_config acfg;
	apb_driver drvh;
	apb_monitor monh;
	apb_sequencer seqrh;

	function new(string name="apb_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(apb_agent_config)::get(this, "", "apb", acfg))
			`uvm_fatal("FROM APB AGENT","Error to get apb config")

		monh=apb_monitor::type_id::create("monh", this);
		if(acfg.is_active==UVM_ACTIVE)
			begin
				seqrh=apb_sequencer::type_id::create("seqrh", this);
				drvh=apb_driver::type_id::create("drvh", this);
			end
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(acfg.is_active==UVM_ACTIVE)
			drvh.seq_item_port.connect(seqrh.seq_item_export);
	endfunction
endclass
