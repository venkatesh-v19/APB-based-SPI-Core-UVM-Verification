class spi_monitor extends uvm_monitor;
	`uvm_component_utils(spi_monitor)
	uvm_analysis_port #(spi_transaction) monitor_port;
	spi_transaction tx;
	virtual spi_if.MON vif;
	spi_agent_config scfg;
	bit[7:0] ctrl;
	bit cpha;
	bit cpol;
	bit lsb;

	function new(string name="spi_monitor", uvm_component parent);
		super.new(name, parent);
		monitor_port=new("monitor_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(spi_agent_config)::get(this,"","spi",scfg))
			`uvm_fatal("FROM SPI MONITOR","Error to get scfg")
	endfunction	

	function void connect_phase(uvm_phase phase);	
		super.connect_phase(phase);
		vif=scfg.svif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever
			begin
				tx=spi_transaction::type_id::create("tx");
				collect_data();
				tx.display("SPI MONITOR");
			end
	endtask

	task collect_data();
		if(!uvm_config_db#(bit[7:0])::get(this,"","ctrl_reg",ctrl))
			`uvm_fatal("FROM SPI MONITOR","Error to get ctrl")
		lsb=ctrl[0];
		cpol=ctrl[3];
		cpha=ctrl[2];

		//@(vif.mon);
		wait(!vif.mon.ss_o)
			begin
				if(lsb)
					begin
						for(int i=0; i<=7; i++)
							begin
								if((!cpol && !cpha) || (cpol && cpha))
									begin
										@(posedge vif.mon.sclk_o)
										tx.miso_i[i]=vif.mon.miso_i;
										tx.mosi_o[i]=vif.mon.mosi_o;
										tx.ss_o=vif.mon.ss_o;
										
									end
								else
									begin
										@(negedge vif.mon.sclk_o)
										tx.miso_i[i]=vif.mon.miso_i;
										tx.mosi_o[i]=vif.mon.mosi_o;
										tx.ss_o=vif.mon.ss_o;
									end
							end
					end
				else
					begin
						for(int i=7; i>=0; i--)
							begin
								if((!cpol && !cpha) || (cpol && cpha))
									begin
										@(posedge vif.mon.sclk_o)
										tx.miso_i[i]=vif.mon.miso_i;
										tx.mosi_o[i]=vif.mon.mosi_o;
										tx.ss_o=vif.mon.ss_o;
									end
								else
									begin
										@(negedge vif.mon.sclk_o)
										tx.miso_i[i]=vif.mon.miso_i;
										tx.mosi_o[i]=vif.mon.mosi_o;
										tx.ss_o=vif.mon.ss_o;
									end
							end
					end
					
			end
			monitor_port.write(tx);
	endtask
endclass



