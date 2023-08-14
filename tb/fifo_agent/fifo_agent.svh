class fifo_agent extends uvm_agent;
    `uvm_component_utils (fifo_agent)

    fifo_sequencer  fifo_sqr;
    fifo_driver     fifo_drv;
    fifo_monitor    fifo_mon;

    // constructor
    function new (string name = "fifo_agent", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

    
        fifo_sqr = fifo_sequencer ::type_id::create ("fifo_sqr", this);
        fifo_drv = fifo_driver    ::type_id::create ("fifo_drv", this);
        fifo_mon = fifo_monitor   ::type_id::create ("fifo_mon", this);

    endfunction :build_phase

    // connect_phase
    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), "Inside Connect Phase!", UVM_HIGH)
   
        fifo_drv.seq_item_port.connect(fifo_sqr.seq_item_export);
    endfunction :connect_phase
endclass :fifo_agent