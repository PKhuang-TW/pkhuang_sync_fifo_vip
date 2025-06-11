module sync_fifo #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 16
)(
    input   wire                    clk,
    input   wire                    rst_n,
    input   wire                    rd_en,
    input   wire                    wr_en,
    input   wire[DATA_WIDTH-1:0]    din,
    output  reg[DATA_WIDTH-1:0]     dout,
    output  wire                    full,
    output  wire                    empty
);
    localparam ADDR_WIDTH = $clog2(FIFO_DEPTH);

    reg [ADDR_WIDTH:0]      counter;
    reg [ADDR_WIDTH-1:0]    w_ptr, r_ptr;
    reg [DATA_WIDTH-1:0]    fifo[FIFO_DEPTH-1:0];

    assign full     = (counter == FIFO_DEPTH);
    assign empty    = (counter == 0);

    always @ (posedge clk or negedge rst_n) begin
        if ( !rst_n ) begin
            w_ptr   <= 0;
        end else if ( wr_en && !full ) begin
            fifo[w_ptr] <= din;
            w_ptr       <= (w_ptr + 1) & (FIFO_DEPTH - 1);
        end
    end

    always @ (posedge clk or negedge rst_n) begin
        if ( !rst_n ) begin
            r_ptr   <= 0;
            dout    <= 0;
        end else if ( rd_en && !empty ) begin
            dout    <= fifo[r_ptr];
            r_ptr   <= (r_ptr + 1) & (FIFO_DEPTH - 1);
        end
    end

    always @ (posedge clk or negedge rst_n) begin
        if ( !rst_n ) begin
            counter <= 0;
        end else begin
            case ({ (wr_en && !full), (rd_en && !empty) })
                2'b10:   counter <= counter + 1;
                2'b01:   counter <= counter - 1;
            endcase
        end
    end

endmodule