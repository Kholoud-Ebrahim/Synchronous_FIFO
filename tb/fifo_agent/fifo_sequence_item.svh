class fifo_sequence_item extends uvm_sequence_item;
    rand bit [7:0] data_in;
    rand bit wr_en;
    rand bit rd_en;

    bit [7:0] data_out;
    bit full;
    bit empty;

    `uvm_object_utils_begin(fifo_sequence_item)
        `uvm_field_int(wr_en, UVM_ALL_ON)
        `uvm_field_int(rd_en, UVM_ALL_ON)
        `uvm_field_int(data_in, UVM_ALL_ON)

        `uvm_field_int(data_out, UVM_ALL_ON)
        `uvm_field_int(full, UVM_ALL_ON)
        `uvm_field_int(empty, UVM_ALL_ON)
    `uvm_object_utils_end

    constraint wr_en_c { wr_en dist {1 := 80, 0 := 20}; }
    constraint rd_en_c { rd_en dist {1 := 70, 0 := 30}; }

    function new (string name = "fifo_sequence_item");
        super.new(name);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new
endclass :fifo_sequence_item