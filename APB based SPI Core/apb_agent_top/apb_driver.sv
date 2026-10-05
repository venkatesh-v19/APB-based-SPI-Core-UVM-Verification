class apb_driver extends uvm_driver#(apb_transaction);
	`uvm_component_utils(apb_driver)
	virtual apb_if.DRV vif;
	apb_agent_config acfg;

	function new(string name="apb_driver", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(apb_agent_config)::get(this,"","apb",acfg))
			`uvm_fatal("FROM APB DRIVER","Error to get acfg")
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=acfg.avif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		reset();
		forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				req.display("From APB DRIVER");
				seq_item_port.item_done();
			end
	endtask

	task send_to_dut(apb_transaction tx);
		@(vif.drv);
		vif.drv.paddr_i<=tx.paddr_i;
		vif.drv.pwrite_i<=tx.pwrite_i;
		vif.drv.psel_i<=1'b1;
		vif.drv.penable_i<=1'b0;

		if(tx.pwrite_i)
			vif.drv.pwdata_i<=tx.pwdata_i;

		@(vif.drv);
		vif.drv.penable_i<=1'b1;
		wait(vif.drv.pready_o)
		if(tx.pwrite_i==0)
			tx.prdata_o=vif.drv.prdata_o;
		@(vif.drv);
		vif.drv.psel_i<=1'b0;
		vif.drv.penable_i<=1'b0;		
	endtask

	task reset();
		@(vif.drv);
		vif.drv.preset_n<=1'b0;
		repeat(3)
		@(vif.drv);
		vif.drv.preset_n<=1'b1;
	
	endtask

endclass






