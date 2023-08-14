class fifo_test extends uvm_test;
    `uvm_component_utils (fifo_test)

    fifo_environment    fifo_env;
    fifo_base_sequence  seq1;
    fifo_write_sequence seq2;
    fifo_read_sequence  seq3;

    // constructor
    function new(string name = "fifo_test", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        fifo_env = fifo_environment::type_id::create("fifo_env", this);
    endfunction :build_phase 

    // run_phase
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)

        phase.raise_objection(this);
            #20ns;
            repeat(10) begin
                seq3 = fifo_read_sequence ::type_id::create("seq3");
                seq3.start(fifo_env.fifo_agnt.fifo_sqr);
                #5ns;
            end
            repeat(150) begin
                seq2 = fifo_write_sequence::type_id::create("seq2");
                seq2.start(fifo_env.fifo_agnt.fifo_sqr);
                #5ns;
            end
            repeat(130) begin
                seq3 = fifo_read_sequence ::type_id::create("seq3");
                seq3.start(fifo_env.fifo_agnt.fifo_sqr);
                #5ns;
            end 
            repeat(300) begin
                seq1 = fifo_base_sequence::type_id::create("seq1");
                seq1.start(fifo_env.fifo_agnt.fifo_sqr);
                #5ns;
            end
            repeat(10) begin
                seq3 = fifo_read_sequence ::type_id::create("seq3");
                seq3.start(fifo_env.fifo_agnt.fifo_sqr);
                #5ns;
            end
            repeat(12) begin
                seq2 = fifo_write_sequence::type_id::create("seq2");
                seq2.start(fifo_env.fifo_agnt.fifo_sqr);
                #5ns;
            end
        phase.drop_objection(this);

    endtask :run_phase
endclass :fifo_test