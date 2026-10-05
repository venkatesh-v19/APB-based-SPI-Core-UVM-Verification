class apb_sequence extends uvm_sequence#(apb_transaction);
	`uvm_object_utils(apb_sequence)
	bit[7:0]ctrl;

	function new(string name="apb_sequence");
		super.new(name);
	endfunction

	task body();
		if(!uvm_config_db#(bit[7:0])::get(null,get_full_name,"ctrl_reg",ctrl))
			`uvm_fatal("APB_SEQUENCE","Error to get ctrl value")
	endtask
endclass

class seq_lsb_00 extends apb_sequence;
	`uvm_object_utils(seq_lsb_00)

	function new(string name="seq_lsb_00");	
		super.new(name);
	endfunction
		
	task body();
		super.body();
		req=apb_transaction::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b000; req.pwdata_i==ctrl;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b001; req.pwdata_i==8'b0001_1000;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b010; req.pwdata_i==8'b0001_0001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b101;});
		finish_item(req);

	endtask
endclass

class seq_lsb_01 extends apb_sequence;
	`uvm_object_utils(seq_lsb_01)

	function new(string name="seq_lsb_01");	
		super.new(name);
	endfunction

	task body();
		super.body();
		req=apb_transaction::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b000; req.pwdata_i==ctrl;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b001; req.pwdata_i==8'b0001_1001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b010; req.pwdata_i==8'b0001_0001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b101;});
		finish_item(req);
	endtask
endclass

class seq_lsb_10 extends apb_sequence;
	`uvm_object_utils(seq_lsb_10)

	function new(string name="seq_lsb_10");	
		super.new(name);
	endfunction

	task body();
		super.body();
		req=apb_transaction::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b000; req.pwdata_i==ctrl;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b001; req.pwdata_i==8'b0001_1001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b010; req.pwdata_i==8'b0001_0001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b101;});
		finish_item(req);
	endtask
endclass

class seq_lsb_11 extends apb_sequence;
	`uvm_object_utils(seq_lsb_11)

	function new(string name="seq_lsb_11");	
		super.new(name);
	endfunction

	task body();
		super.body();
		req=apb_transaction::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b000; req.pwdata_i==ctrl;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b001; req.pwdata_i==8'b0001_1001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b010; req.pwdata_i==8'b0001_0001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b101;});
		finish_item(req);
	endtask
endclass

class seq_msb_00 extends apb_sequence;
	`uvm_object_utils(seq_msb_00)

	function new(string name="seq_msb_00");	
		super.new(name);
	endfunction

	task body();
		super.body();
		req=apb_transaction::type_id::create("req");
	   	
		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b000; req.pwdata_i==ctrl;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b001; req.pwdata_i==8'b0001_1001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b010; req.pwdata_i==8'b0001_0001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b101;});
		finish_item(req);
	endtask
endclass

class seq_msb_01 extends apb_sequence;
	`uvm_object_utils(seq_msb_01)

	function new(string name="seq_msb_01");	
		super.new(name);
	endfunction

	task body();
		super.body();
		req=apb_transaction::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b000; req.pwdata_i==ctrl;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b001; req.pwdata_i==8'b0001_1001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b010; req.pwdata_i==8'b0001_0001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b101;});
		finish_item(req);
	endtask
endclass

class seq_msb_10 extends apb_sequence;
	`uvm_object_utils(seq_msb_10)

	function new(string name="seq_msb_10");	
		super.new(name);
	endfunction

	task body();
		super.body();
		req=apb_transaction::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b000; req.pwdata_i==ctrl;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b001; req.pwdata_i==8'b0001_1001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b010; req.pwdata_i==8'b0001_0001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b101;});
		finish_item(req);
	endtask
endclass

class seq_msb_11 extends apb_sequence;
	`uvm_object_utils(seq_msb_11)

	function new(string name="seq_msb_11");	
		super.new(name);
	endfunction

	task body();
		super.body();
		req=apb_transaction::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b000; req.pwdata_i==ctrl;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b001; req.pwdata_i==8'b0001_1001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b010; req.pwdata_i==8'b0001_0001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b101;});
		finish_item(req);
	endtask
endclass

class seq_reading extends apb_sequence;
	`uvm_object_utils(seq_reading)

	function new(string name="seq_reading");	
		super.new(name);
	endfunction

	task body();
		req=apb_transaction::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b0; req.paddr_i==3'b101;});
		finish_item(req);
	endtask
endclass

class low_power_mode extends apb_sequence;
	`uvm_object_utils(low_power_mode)

	function new(string name="low_power_mode");	
		super.new(name);
	endfunction

	task body();
		super.body();
		req=apb_transaction::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b000; req.pwdata_i==ctrl;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b001; req.pwdata_i==8'b0000_0000;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b010; req.pwdata_i==8'b0001_0001;});
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {req.preset_n==1'b1; req.pwrite_i==1'b1; req.paddr_i==3'b101;});
		finish_item(req);
	endtask
endclass





