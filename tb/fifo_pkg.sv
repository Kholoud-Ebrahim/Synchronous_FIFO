package fifo_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "fifo_sequence_item.svh"
    `include "fifo_base_sequence.svh"    
    `include "fifo_write_sequence.svh"
    `include "fifo_read_sequence.svh"    
    `include "fifo_sequencer.svh"
    `include "fifo_driver.svh"    
    `include "fifo_monitor.svh"   
    `include "fifo_agent.svh"   
    `include "fifo_scoreboard.svh"   
    `include "fifo_coverage_collector.svh"     
    `include "fifo_environment.svh"   
    `include "fifo_test.svh" 
endpackage :fifo_pkg