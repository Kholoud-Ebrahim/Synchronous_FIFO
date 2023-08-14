class fifo_base_sequence extends uvm_sequence;
    `uvm_object_utils(fifo_base_sequence)

    fifo_sequence_item  fifo_item;
    // constructor
    function new(string name = "fifo_base_sequence");
        super.new(name);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // body
    task body ();
        `uvm_info(get_type_name(), "Inside body task!", UVM_HIGH)
        fifo_item = fifo_sequence_item ::type_id::create("fifo_item");
        start_item(fifo_item);
        assert(fifo_item.randomize() with { {wr_en, rd_en} dist {11 := 10, 00 := 5, 01 := 60, 10 := 60}; });
        finish_item(fifo_item);
    endtask :body
endclass :fifo_base_sequence
