class virtual_sequence extends uvm_sequence#(uvm_sequence_item);
	`uvm_object_utils(virtual_sequence)
	`uvm_declare_p_sequencer(virtual_sequencer)

	apb_sequence a_seqh;	//apb configuration/write sequence (selected by the test)
	spi_sequence s_seqh;	//spi sequence
	seq_reading r_seqh;	//apb read sequence
	int rd_delay=800;	//gap between spi sequence and apb read (same as the old #800 in the tests)

	function new(string name="virtual_sequence");
		super.new(name);
	endfunction

	task body();
		if(p_sequencer.a_seqrh==null || p_sequencer.s_seqrh==null)
			`uvm_fatal("VIRTUAL_SEQUENCE","Sequencer handle in virtual sequencer is null")

		//if the test did not supply a sequence, create it through the factory
		if(a_seqh==null)
			a_seqh=apb_sequence::type_id::create("a_seqh");
		if(s_seqh==null)
			s_seqh=spi_sequence::type_id::create("s_seqh");
		if(r_seqh==null)
			r_seqh=seq_reading::type_id::create("r_seqh");

		a_seqh.start(p_sequencer.a_seqrh, this);	//apb
		s_seqh.start(p_sequencer.s_seqrh, this);	//spi
		#(rd_delay);
		r_seqh.start(p_sequencer.a_seqrh, this);	//apb
	endtask
endclass
