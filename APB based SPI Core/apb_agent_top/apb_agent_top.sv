class apb_agent_top extends uvm_component;
	`uvm_component_utils(apb_agent_top)

	apb_agent a_agth[];
	int num;

	function new(string name="apb_agent_top", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(int)::get(this,"","abc",num))
			`uvm_fatal("APB_AGENT_TOP","Error to get num value")
		
		a_agth=new[num];

		foreach(a_agth[i])
			a_agth[i]=apb_agent::type_id::create($sformatf("a_agth[%0d]",i),this);
	endfunction
endclass
