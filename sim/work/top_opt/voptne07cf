library verilog;
use verilog.vl_types.all;
entity synch_fifo is
    generic(
        DWIDTH          : integer := 8;
        MWIDTH          : integer := 128
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        data_in         : in     vl_logic_vector;
        wr_en           : in     vl_logic;
        rd_en           : in     vl_logic;
        data_out        : out    vl_logic_vector;
        full            : out    vl_logic;
        empty           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DWIDTH : constant is 1;
    attribute mti_svvh_generic_type of MWIDTH : constant is 1;
end synch_fifo;
