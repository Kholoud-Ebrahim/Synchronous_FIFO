class fifo_sequencer extends uvm_sequencer #(fifo_sequence_item);
    `uvm_component_utils (fifo_sequencer)

    function new (string name = "fifo_sequencer", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction
endclass :fifo_sequencer