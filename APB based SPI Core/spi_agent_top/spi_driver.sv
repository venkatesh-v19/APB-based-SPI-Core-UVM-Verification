class spi_driver extends uvm_driver#(spi_transaction);
	`uvm_component_utils(spi_driver)
	virtual spi_if.DRV vif;
	spi_agent_config scfg;
	bit[7:0] ctrl;
	bit cpha;
	bit cpol;
	bit lsb;
	

	function new(string name="spi_driver", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(spi_agent_config)::get(this,"","spi",scfg))
			`uvm_fatal("FROM SPI DRIVER","Error to get scfg")
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=scfg.svif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				req.display("SPI DRIVER");
				seq_item_port.item_done();
			end
	endtask

	task send_to_dut(spi_transaction tx);
		if(!uvm_config_db#(bit[7:0])::get(this,"","ctrl_reg",ctrl))
			`uvm_fatal("FROM SPI DRIVER","Error to get ctrl")
		lsb=ctrl[0];
		cpol=ctrl[3];
		cpha=ctrl[2];
		$display("ctrl=%b",ctrl);
		wait(!vif.drv.ss_o)
		begin
		if(lsb)
			begin
				if(!cpol && !cpha)
					begin

						vif.drv.miso_i<=tx.miso_i[0];
						//$display("miso[0]=%0b",tx.miso_i[0]);
						for(int i=1; i<=7; i++)
							begin
								@(negedge vif.drv.sclk_o)
								vif.drv.miso_i<=tx.miso_i[i];
								//$display("miso[%0d]=%0b",i,tx.miso_i[i]);
							end
					end	

				if(cpol && !cpha)
					begin
						vif.drv.miso_i<=tx.miso_i[0];
						//$display("miso=%0b",tx.miso_i[0]);
						for(int i=1; i<=7; i++)
							begin
								@(posedge vif.drv.sclk_o)
								vif.drv.miso_i<=tx.miso_i[i];
						end
					end

				if(!cpol && cpha)
					begin
						for(int i=0; i<=7; i++)
							begin
								@(posedge vif.drv.sclk_o)
								vif.drv.miso_i<=tx.miso_i[i];
						end
					end

				if(cpol && cpha)
					begin
						for(int i=0; i<=7; i++)
							begin
								@(negedge vif.drv.sclk_o)
								vif.drv.miso_i<=tx.miso_i[i];
						end
					end
			end

		else
			begin
				if(!cpol && !cpha)
					begin
						vif.drv.miso_i<=tx.miso_i[7];
						//$display("miso=%0b",tx.miso_i[7]);
						for(int i=6; i>=0; i--)
							begin
								@(negedge vif.drv.sclk_o)
								vif.drv.miso_i<=tx.miso_i[i];
						end
					end

				if(cpol && !cpha)
					begin
						vif.drv.miso_i<=tx.miso_i[7];
						//$display("miso=%0b",tx.miso_i[7]);
						for(int i=6; i>=0; i--)
							begin
								@(posedge vif.drv.sclk_o)
								vif.drv.miso_i<=tx.miso_i[i];
						end
					end

				if(!cpol && cpha)
					begin
						for(int i=7; i>=0; i--)
							begin
								@(posedge vif.drv.sclk_o)
								vif.drv.miso_i<=tx.miso_i[i];
						end
					end

				if(cpol && cpha)
					begin
						for(int i=7; i>=1; i--)
							begin
								@(negedge vif.drv.sclk_o)
								vif.drv.miso_i<=tx.miso_i[i];
						end
					end
			end
		end
		//@(posedge vif.drv.sclk_o);				
	endtask
endclass
