class fifo_scoreboard extends uvm_scoreboard ;
    `uvm_component_utils(fifo_scoreboard)

    uvm_analysis_imp #(fifo_sequence_item, fifo_scoreboard) scb_imp;

    fifo_sequence_item write_queue [$:127];
    fifo_sequence_item read_queue  [$:127];
    local int unsigned check_full_empty = 0;
    local bit empty, full;

    // constructor
    function new(string name = "fifo_scoreboard", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        scb_imp = new("scb_imp", this);

    endfunction :build_phase 
    
    function void write (fifo_sequence_item f_item);
        full = 1'b0; empty = 1'b0;
        if(f_item.wr_en && !f_item.full) begin
            write_queue.push_front(f_item);
            check_full_empty ++; 
        end
        else if(f_item.wr_en && f_item.full) begin
            check_full_empty = 128;
            full = 1'b1;
        end
        else 
        check_full_empty = check_full_empty;
    
        if (f_item.rd_en && !f_item.empty) begin
            read_queue.push_front(f_item);
            check_full_empty --;
        end
        else if (f_item.rd_en && f_item.empty) begin
            check_full_empty = 0;
            empty = 1'b1;
        end
        else 
        check_full_empty = check_full_empty;
    
        if (check_full_empty == 0 && f_item.empty ==1) begin
            `uvm_info("NUM", $sformatf("Number of ELements in the FIFO = %0d",check_full_empty), UVM_NONE)
            `uvm_info("EMPTY", "The FIFO is Empty", UVM_NONE)
        end
        else begin
            `uvm_info("NUM", $sformatf("Number of ELements in the FIFO = %0d",check_full_empty), UVM_NONE)
            `uvm_info("NOT_EMPTY", "The FIFO isn't Empty", UVM_NONE)
        end
        if (check_full_empty == 128 && f_item.full ==1)
            `uvm_info("FULL", "The FIFO is Full", UVM_NONE)
        else
            `uvm_info("NOT_FULL", "The FIFO isn't Full", UVM_NONE)

    endfunction :write
    
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)
    forever begin
        fifo_sequence_item in;
        fifo_sequence_item out;

        wait ((read_queue.size != 0) && (write_queue.size != 0));
            
            in = write_queue.pop_back();
            out = read_queue.pop_back();  

            if (in.data_in == out.data_out)
                `uvm_info("PASSED",$sformatf("data_in = %0x    data_out = %0x",in.data_in, out.data_out), UVM_NONE)
            else
                `uvm_error("FAILED",$sformatf("data_in = %0x    data_out = %0x",in.data_in, out.data_out))      
            end    
    
    endtask :run_phase
endclass :fifo_scoreboard