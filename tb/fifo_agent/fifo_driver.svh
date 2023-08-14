class fifo_driver extends uvm_driver #(fifo_sequence_item);
    `uvm_component_utils (fifo_driver)

    // Declare the virtual interface
    virtual synch_fifo_intf  synch_fifo_vif;
    
    fifo_sequence_item  fifo_item;

    // constructor
    function new(string name = "fifo_driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        // Get the interface handle
        if (!(uvm_config_db #(virtual synch_fifo_intf)::get(this, "*", "synch_fifo_vif_t", synch_fifo_vif)))
            `uvm_fatal(get_type_name(),"Couldn't get handle to vif")

    endfunction :build_phase

    // run_phase
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)
        forever begin
            seq_item_port.get_next_item(fifo_item);
            drive_item(fifo_item);
            seq_item_port.item_done();
        end
    endtask :run_phase

    task drive_item (fifo_sequence_item fifo_item);
        @(negedge synch_fifo_vif.clk);
            synch_fifo_vif.data_in <= fifo_item.data_in;
            synch_fifo_vif.wr_en   <= fifo_item.wr_en;
            synch_fifo_vif.rd_en   <= fifo_item.rd_en;
            fifo_item.print();
    endtask :drive_item
endclass :fifo_driver