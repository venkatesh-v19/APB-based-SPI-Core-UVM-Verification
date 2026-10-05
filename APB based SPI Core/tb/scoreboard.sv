class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)

	uvm_tlm_analysis_fifo#(apb_transaction) a_fifo;
	uvm_tlm_analysis_fifo#(spi_transaction) s_fifo;
	apb_transaction a_cover_data;
	spi_transaction s_cover_data;
	apb_transaction a_tx;
	spi_transaction s_tx;
	int data_verified_count;

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction

	covergroup apb_covergroup;
		option.per_instance = 1;
		Reset : coverpoint a_cover_data.preset_n { bins rst = {0,1};}
		
		Addr : coverpoint a_cover_data.paddr_i { bins addr[] = {0,1,2,3,5};}
		
		Selx : coverpoint a_cover_data.psel_i { bins sel = {0,1};}

		Enable : coverpoint a_cover_data.penable_i { bins en = {0,1};}

		Write : coverpoint a_cover_data.pwrite_i { bins wr[] = {0,1};}

		Ready : coverpoint a_cover_data.pready_o { bins rdy = {0,1};}

		Error : coverpoint a_cover_data.pslverr_o { bins err = {0,1};}
	
		Wdata : coverpoint a_cover_data.pwdata_i {
						bins wdata_low = {[8'h00:8'd127]};
						bins wdata_high = {[8'd128:8'hff]};
						}
		Rdata : coverpoint a_cover_data.prdata_o {
						bins rdata_low = {[8'h00:8'd127]};
						bins rdata_high = {[8'd128:8'hff]};
						}

		//crosses
		Selx_Enable : cross Selx,Enable;
		Selx_Enable_Ready : cross Selx,Enable,Ready;
	endgroup

	covergroup spi_covergroup;
		option.per_instance = 1;
		Slave_select : coverpoint s_cover_data.ss_o { bins ss = {0,1};}
		
		miso_data : coverpoint s_cover_data.miso_i {
						bins miso_low = {[8'h00:8'd127]};
						bins miso_high = {[8'd128:8'hff]};
						}
		mosi_data : coverpoint s_cover_data.mosi_o {
						bins mosi_low = {[8'h00:8'd127]};
						bins mosi_high = {[8'd128:8'hff]};
						}	
	endgroup

	
	function new(string name="scoreboard", uvm_component parent);
		super.new(name, parent);
		a_fifo=new("a_fifo",this);
		s_fifo=new("s_fifo",this);
		apb_covergroup=new();
		spi_covergroup=new();
	endfunction


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		fork
			forever
				begin
					a_fifo.get(a_tx);
					a_cover_data=new a_tx;
					apb_covergroup.sample();
					if(a_tx.pwrite_i && (a_tx.paddr_i==3'b101))
						begin
							s_fifo.get(s_tx);
							s_cover_data = new s_tx;
							spi_covergroup.sample();
							compare_data1(a_tx);
						end
		
					if(!a_tx.pwrite_i && (a_tx.paddr_i==101))
						compare_data2(a_tx);
				end
		join
	endtask

	task compare_data1(apb_transaction a_tx);
		if(a_tx.pwdata_i==s_tx.mosi_o)
			$display("**************************** APB PASS ***********************");
		else
			$display("*************************** APB FAIL **************************");
	endtask


	task compare_data2(apb_transaction a_tx);
		if(a_tx.prdata_o==s_tx.miso_i)
			$display("**************************** SPI PASS ***********************");
		else
			$display("*************************** SPI FAIL **************************");
	endtask
endclass









