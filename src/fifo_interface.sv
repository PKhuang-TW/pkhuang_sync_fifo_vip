`ifndef FIFO_INTERFACE_SV
`define FIFO_INTERFACE_SV

`include "fifo_define.svh"

interface fifo_interface(
    input   wire    clk,
    input   wire    rst_n
);
    logic                       wr_en;
    logic                       rd_en;
    logic                       full;
    logic                       empty;
    logic [`D_DATA_WIDTH-1:0]   din;
    logic [`D_DATA_WIDTH-1:0]   dout;
endinterface

`endif