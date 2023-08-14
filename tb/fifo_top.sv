`timescale 1ns/1ns

import uvm_pkg::*;
import fifo_pkg::*;

module fifo_top;
    parameter HALF_CYCLE = 5;
    parameter RST_TIME = 20; //HALF_CYCLE*4

    bit clk, rst;

    synch_fifo_intf synch_fifo_vif (clk, rst);
    synch_fifo      dut(clk,
                        rst, 
                        synch_fifo_vif.data_in, 
                        synch_fifo_vif.wr_en, 
                        synch_fifo_vif.rd_en, 
                        synch_fifo_vif.data_out, 
                        synch_fifo_vif.full, 
                        synch_fifo_vif.empty);
    initial begin
        forever begin
            #HALF_CYCLE; clk = ~clk;
        end
    end

    initial begin
        rst =1; #RST_TIME; rst =0;
    end

    initial begin
        run_test("fifo_test");
    end

    initial begin    
        uvm_config_db #(virtual synch_fifo_intf)::set(null, "*", "synch_fifo_vif_t", synch_fifo_vif);
    end


    //Generate Waveforms
    initial begin
        $dumpfile("test.vcd");
        $dumpvars();
    end
endmodule :fifo_top