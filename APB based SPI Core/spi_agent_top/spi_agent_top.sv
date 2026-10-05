class spi_agent_top extends uvm_component;
	`uvm_component_utils(spi_agent_top)

	spi_agent s_agth[];
	int num;

	function new(string name="spi_agent_top", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(int)::get(this,"","abc",num))
			`uvm_fatal("SPI_AGENT_TOP","Error to get num value")
		
		s_agth=new[num];

		foreach(s_agth[i])
			s_agth[i]=spi_agent::type_id::create($sformatf("s_agent[%0d]",i),this);
	endfunction
endclass	

