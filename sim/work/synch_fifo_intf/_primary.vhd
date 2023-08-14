library verilog;
use verilog.vl_types.all;
entity synch_fifo_intf is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
end synch_fifo_intf;
