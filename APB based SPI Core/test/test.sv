class test extends uvm_test;
	`uvm_component_utils(test)
	
	apb_agent_config acfg;
	spi_agent_config scfg;
	env envh;
	virtual_sequence vseqh;
	virtual apb_if avif;
	virtual spi_if svif;
	int num=1;

	function new(string name="test", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		envh=env::type_id::create("envh",this);
		vseqh=virtual_sequence::type_id::create("vseqh");
		acfg=apb_agent_config::type_id::create("acfg");
		scfg=spi_agent_config::type_id::create("scfg");

		acfg.is_active=UVM_ACTIVE;
		scfg.is_active=UVM_ACTIVE;

		if(!uvm_config_db#(virtual apb_if)::get(this,"","apb", avif))
			`uvm_fatal("IN ENV","Error to get avif")
		acfg.avif=avif;

		if(!uvm_config_db#(virtual spi_if)::get(this,"","spi", svif))
			`uvm_fatal("IN ENV","Error to get svif")
		scfg.svif=svif;

		uvm_config_db#(apb_agent_config)::set(this,"*","apb", acfg);
		uvm_config_db#(spi_agent_config)::set(this,"*","spi", scfg);

		uvm_config_db#(int)::set(this,"*","abc",num);
		
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass

class seq_lsb_00_test extends test;
	`uvm_component_utils(seq_lsb_00_test)
	bit[7:0]ctrl=8'b1111_0011;

	function new(string name="seq_lsb_00_test",uvm_component parent);
    		super.new(name,parent);
  	endfunction

	seq_lsb_00 seq;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq=seq_lsb_00::type_id::create("seq"); //apb
		vseqh.a_seqh=seq;
		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg",ctrl);
  	endfunction
  
  	task run_phase(uvm_phase phase);
    		phase.raise_objection(this);
		vseqh.start(envh.vseqrh);
		#100;
    		phase.drop_objection(this);
  	endtask
endclass

class seq_lsb_01_test extends test;
	`uvm_component_utils(seq_lsb_01_test)
	bit[7:0]ctrl=8'b1111_0111;

	function new(string name="seq_lsb_01_test",uvm_component parent);
    		super.new(name,parent);
  	endfunction

	seq_lsb_01 seq;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq=seq_lsb_01::type_id::create("seq"); //apb
		vseqh.a_seqh=seq;
		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg",ctrl);
  	endfunction
  
  	task run_phase(uvm_phase phase);
    		phase.raise_objection(this);
		vseqh.start(envh.vseqrh);
		#200;
    		phase.drop_objection(this);
  	endtask
endclass

class seq_lsb_10_test extends test;
	`uvm_component_utils(seq_lsb_10_test)
	bit[7:0]ctrl=8'b1111_1011;

	function new(string name="seq_lsb_10_test",uvm_component parent);
    		super.new(name,parent);
  	endfunction

	seq_lsb_10 seq;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq=seq_lsb_10::type_id::create("seq"); //apb
		vseqh.a_seqh=seq;
		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg",ctrl);
  	endfunction
  
  	task run_phase(uvm_phase phase);
    		phase.raise_objection(this);
		vseqh.start(envh.vseqrh);
		#200;
    		phase.drop_objection(this);
  	endtask
endclass

class seq_lsb_11_test extends test;
	`uvm_component_utils(seq_lsb_11_test)
	bit[7:0]ctrl=8'b1111_1111;

	function new(string name="seq_lsb_11_test",uvm_component parent);
    		super.new(name,parent);
  	endfunction

	seq_lsb_11 seq;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq=seq_lsb_11::type_id::create("seq"); //apb
		vseqh.a_seqh=seq;
		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg",ctrl);
  	endfunction
  
  	task run_phase(uvm_phase phase);
    		phase.raise_objection(this);
		vseqh.start(envh.vseqrh);
		#200;
    		phase.drop_objection(this);
  	endtask
endclass

class seq_msb_00_test extends test;
	`uvm_component_utils(seq_msb_00_test)
	bit[7:0]ctrl=8'b1111_0010;

	function new(string name="seq_msb_00_test",uvm_component parent);
    		super.new(name,parent);
  	endfunction

	seq_msb_00 seq;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq=seq_msb_00::type_id::create("seq"); //apb
		vseqh.a_seqh=seq;
		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg",ctrl);
  	endfunction
  
  	task run_phase(uvm_phase phase);
    		phase.raise_objection(this);
		vseqh.start(envh.vseqrh);
		#200;
    		phase.drop_objection(this);
  	endtask
endclass

class seq_msb_01_test extends test;
	`uvm_component_utils(seq_msb_01_test)
	bit[7:0]ctrl=8'b1111_0110;

	function new(string name="seq_msb_01_test",uvm_component parent);
    		super.new(name,parent);
  	endfunction

	seq_msb_01 seq;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq=seq_msb_01::type_id::create("seq"); //apb
		vseqh.a_seqh=seq;
		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg",ctrl);
  	endfunction
  
  	task run_phase(uvm_phase phase);
    		phase.raise_objection(this);
		vseqh.start(envh.vseqrh);
		#200;
    		phase.drop_objection(this);
  	endtask
endclass

class seq_msb_10_test extends test;
	`uvm_component_utils(seq_msb_10_test)
	bit[7:0]ctrl=8'b1111_1010;

	function new(string name="seq_msb_10_test",uvm_component parent);
    		super.new(name,parent);
  	endfunction

	seq_msb_10 seq;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq=seq_msb_10::type_id::create("seq"); //apb
		vseqh.a_seqh=seq;
		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg",ctrl);
  	endfunction
  
  	task run_phase(uvm_phase phase);
    		phase.raise_objection(this);
		vseqh.start(envh.vseqrh);
		#200;
    		phase.drop_objection(this);
  	endtask
endclass

class seq_msb_11_test extends test;
	`uvm_component_utils(seq_msb_11_test)
	bit[7:0]ctrl=8'b1111_1110;

	function new(string name="seq_msb_11_test",uvm_component parent);
    		super.new(name,parent);
  	endfunction

	seq_msb_11 seq;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq=seq_msb_11::type_id::create("seq"); //apb
		vseqh.a_seqh=seq;
		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg",ctrl);
  	endfunction
  
  	task run_phase(uvm_phase phase);
    		phase.raise_objection(this);
		vseqh.start(envh.vseqrh);
		#200;
    		phase.drop_objection(this);
  	endtask
endclass


class low_power_mode_test extends test;
	`uvm_component_utils(low_power_mode_test)
	bit[7:0]ctrl=8'b1011_0011;

	function new(string name="low_power_mode_test",uvm_component parent);
    		super.new(name,parent);
  	endfunction

	low_power_mode seq;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq=low_power_mode::type_id::create("seq"); //apb
		vseqh.a_seqh=seq;
		uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg",ctrl);
  	endfunction
  
  	task run_phase(uvm_phase phase);
    		phase.raise_objection(this);
		vseqh.start(envh.vseqrh);
		#200;
    		phase.drop_objection(this);
  	endtask
endclass








		

