class env extends uvm_env;
	`uvm_component_utils(env)
	apb_agent_top a_top;
	spi_agent_top s_top;
	scoreboard sb_h;
	virtual_sequencer vseqrh;

	function new(string name="env", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sb_h=scoreboard::type_id::create("sb_h",this);
		a_top=apb_agent_top::type_id::create("a_top",this);
		s_top=spi_agent_top::type_id::create("s_top",this);	
		vseqrh=virtual_sequencer::type_id::create("vseqrh",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		a_top.a_agth[0].monh.monitor_port.connect(sb_h.a_fifo.analysis_export);
		s_top.s_agth[0].monh.monitor_port.connect(sb_h.s_fifo.analysis_export);
		vseqrh.a_seqrh=a_top.a_agth[0].seqrh;
		vseqrh.s_seqrh=s_top.s_agth[0].seqrh;
	endfunction
endclass 


