class fifo_coverage_collector extends uvm_subscriber#(fifo_sequence_item);
    `uvm_component_utils(fifo_coverage_collector)

    uvm_analysis_imp #(fifo_sequence_item, fifo_coverage_collector) cov_imp;

    fifo_sequence_item fifo_item;
    fifo_sequence_item fifo_queue[$];


    covergroup cov1;
	option.per_instance = 1; 
        cov_wr_en_p : coverpoint fifo_item.wr_en {
            bins wr_en_1   = {1'b1}; 
            bins wr_en_0   = {1'b0};
            bins wr_en_1_0 = (1'b1 => 1'b0);
            bins wr_en_0_1 = (1'b0 => 1'b1);
        }
        cov_rd_en_p : coverpoint fifo_item.rd_en {
            bins rd_en_1 = {1'b1}; 
            bins rd_en_0 = {1'b0};
            bins rd_en_1_0 = (1'b1 => 1'b0);
            bins rd_en_0_1 = (1'b0 => 1'b1);
        }
        cov_full_p  : coverpoint fifo_item.full {
            bins full_1 = {1'b1}; 
            bins full_0 = {1'b0};
        } 
        cov_empty_p  : coverpoint fifo_item.empty {
            bins empty_1 = {1'b1}; 
            bins empty_0 = {1'b0};
        } 

        cross cov_wr_en_p, cov_rd_en_p {
            bins wr_rd_en_00 = binsof(cov_wr_en_p) intersect {1'b0} && binsof(cov_rd_en_p) intersect {1'b0};
            bins wr_rd_en_10 = binsof(cov_wr_en_p) intersect {1'b1} && binsof(cov_rd_en_p) intersect {1'b0};
            bins wr_rd_en_01 = binsof(cov_wr_en_p) intersect {1'b0} && binsof(cov_rd_en_p) intersect {1'b1};
            ignore_bins wr_rd_en_11 = binsof(cov_wr_en_p) intersect {1'b1} && binsof(cov_rd_en_p) intersect {1'b1};
        }
    endgroup

    // constructor
    function new(string name = "fifo_coverage_collector", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)

        cov1 = new();
    endfunction :new

    // build_phase
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Inside Build Phase!", UVM_HIGH)

        cov_imp = new("cov_imp", this);
    endfunction :build_phase

    function void write (fifo_sequence_item t);
        fifo_queue.push_front(t);
    endfunction :write

    //run phase
	task run_phase (uvm_phase phase);
        super.run_phase(phase);    
       `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)
        forever begin
	      fifo_item = fifo_sequence_item::type_id::create("fifo_item",this);
          wait(fifo_queue.size!=0);
	     	fifo_item  = fifo_queue.pop_back();
	    cov1.sample();  
        end 
    endtask :run_phase
endclass :fifo_coverage_collector