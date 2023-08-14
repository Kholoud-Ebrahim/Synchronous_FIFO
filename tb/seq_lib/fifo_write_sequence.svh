class fifo_write_sequence extends fifo_base_sequence;
    `uvm_object_utils(fifo_write_sequence)

    fifo_sequence_item  fifo_item;
    // constructor
    function new(string name = "fifo_write_sequence");
        super.new(name);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // body
    task body ();
        `uvm_info(get_type_name(), "Inside body task!", UVM_HIGH)
        fifo_item = fifo_sequence_item ::type_id::create("fifo_item");
        start_item(fifo_item);
        assert(fifo_item.randomize() with {wr_en == 1; rd_en == 0;});
        finish_item(fifo_item);
    endtask :body
endclass :fifo_write_sequence