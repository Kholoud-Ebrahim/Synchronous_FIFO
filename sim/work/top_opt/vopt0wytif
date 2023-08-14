library verilog;
use verilog.vl_types.all;
entity fifo_top is
    generic(
        HALF_CYCLE      : integer := 5;
        RST_TIME        : integer := 20
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of HALF_CYCLE : constant is 1;
    attribute mti_svvh_generic_type of RST_TIME : constant is 1;
end fifo_top;
