class fifo_environment  extends uvm_env;
    `uvm_component_utils (fifo_environment)
    
    fifo_agent               fifo_agnt;
    fifo_scoreboard          fifo_scb;
    fifo_coverage_collector  fifo_cov;

    // constructor
    function new(string name = "fifo_environment", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        fifo_agnt = fifo_agent::type_id::create("fifo_agnt", this);
        fifo_scb  = fifo_scoreboard::type_id::create("fifo_scb", this);
        fifo_cov  = fifo_coverage_collector::type_id::create("fifo_cov", this);
    endfunction :build_phase

    // connect_phase
    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), "Inside Connect Phase!", UVM_HIGH)

        fifo_agnt.fifo_mon.mon_port.connect(fifo_scb.scb_imp);
        fifo_agnt.fifo_mon.mon_port.connect(fifo_cov.cov_imp);
    endfunction :connect_phase

endclass :fifo_environment