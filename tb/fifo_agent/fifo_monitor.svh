class fifo_monitor  extends uvm_monitor;
    `uvm_component_utils (fifo_monitor)

    // Declare the virtual interface
    virtual synch_fifo_intf synch_fifo_vif;
    
    fifo_sequence_item  fifo_item;

    uvm_analysis_port #(fifo_sequence_item) mon_port;

    // constructor
    function new(string name = "fifo_monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        mon_port = new("mon_port", this);

        if(!(uvm_config_db #(virtual synch_fifo_intf)::get(this, "*", "synch_fifo_vif_t", synch_fifo_vif)))
            `uvm_fatal(get_type_name(),"Couldn't get handle to vif")
      
    endfunction :build_phase

    // run_phase
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)

        forever begin
            @(posedge synch_fifo_vif.clk);
            #1ns;
                fifo_item = fifo_sequence_item::type_id::create("fifo_item");
                fifo_item.data_in  = synch_fifo_vif.data_in;
                fifo_item.wr_en    = synch_fifo_vif.wr_en;
                fifo_item.rd_en    = synch_fifo_vif.rd_en;
                fifo_item.data_out = synch_fifo_vif.data_out;
                fifo_item.full     = synch_fifo_vif.full;
                fifo_item.empty    = synch_fifo_vif.empty;

            mon_port.write(fifo_item);
        end
    endtask :run_phase

endclass :fifo_monitor