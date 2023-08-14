module synch_fifo #(parameter DWIDTH = 8, MWIDTH = 128)(clk, rst, data_in, wr_en, rd_en, data_out, full, empty);
    input clk, rst;
    input [DWIDTH-1:0] data_in;
    input wr_en, rd_en;

    output reg [DWIDTH-1:0] data_out;
    output reg full, empty;

    reg [DWIDTH-1:0] wr_ptr, rd_ptr;
    reg [DWIDTH-1:0] depth_control;
    reg [DWIDTH-1:0] mem [MWIDTH-1:0];

    always @(negedge clk) begin
        if(depth_control == MWIDTH) begin
            full  <= 1'b1;
            empty <= 1'b0;
        end
        else if (depth_control == 0) begin
            full  <= 1'b0;
            empty <= 1'b1;
        end
        else begin
            full  <= 1'b0;
            empty <= 1'b0;
        end
    end
    always @(posedge clk) begin
        if (rst) begin
            wr_ptr        <= {DWIDTH{1'b0}};
            rd_ptr        <= {DWIDTH{1'b0}};
            depth_control <= {DWIDTH{1'b0}};
        end
        else begin
            if (wr_en && !full) begin
                depth_control <= depth_control +1;
                mem [wr_ptr]  <= data_in;
                if (wr_ptr == 8'b1000_0000) begin
                    wr_ptr <= 8'b0;
                end
                else begin
                    wr_ptr <= wr_ptr +1;
                end   
            end
            else begin
                wr_ptr <= wr_ptr;
            end

            if (rd_en && !empty) begin
                depth_control <= depth_control-1;
                data_out <= mem [rd_ptr];
                if (rd_ptr == 8'b1000_0000)begin
                    rd_ptr <= 8'b0;
                end
                else begin
                    rd_ptr <= rd_ptr +1;
                end
                
            end
            else begin
                rd_ptr <= rd_ptr;
            end
 
        end
    end
endmodule