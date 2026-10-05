class apb_monitor extends uvm_monitor;
	`uvm_component_utils(apb_monitor)
	uvm_analysis_port #(apb_transaction) monitor_port;
	apb_transaction tx;
	virtual apb_if.MON vif;
	apb_agent_config acfg;


	function new(string name="apb_monitor", uvm_component parent);
		super.new(name, parent);
		monitor_port=new("monitor_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(apb_agent_config)::get(this,"","apb",acfg))
			`uvm_fatal("FROM APB MONITOR","Error to get acfg")
	endfunction

	function void connect_phase(uvm_phase phase);	
		super.connect_phase(phase);
		vif=acfg.avif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever
			begin
				tx=apb_transaction::type_id::create("tx");
				collect_data();
				tx.display("From APB MONITOR");
				$display("---------------From APB MONITOR,pwdata_i=%0d, prdata_o=%0d--------------------",tx.pwdata_i,tx.prdata_o);
				$display("");
				monitor_port.write(tx);
			end
	endtask

	task collect_data();
		@(vif.mon);

		wait(vif.mon.penable_i && vif.mon.pready_o)
		tx.preset_n=vif.mon.preset_n;
		tx.paddr_i=vif.mon.paddr_i;
		tx.pwrite_i=vif.mon.pwrite_i;
		tx.psel_i=vif.mon.psel_i;
		tx.penable_i=vif.mon.penable_i;
		if(tx.pwrite_i)
			tx.pwdata_i=vif.mon.pwdata_i;
		else
			tx.prdata_o=vif.mon.prdata_o;
		tx.pready_o=vif.mon.pready_o;
		tx.pslverr_o=vif.mon.pslverr_o;

		@(vif.mon);

	endtask
endclass

