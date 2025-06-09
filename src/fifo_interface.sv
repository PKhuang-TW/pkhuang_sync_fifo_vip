`ifndef FIFO_INTERFACE_SV
`define FIFO_INTERFACE_SV

import fifo_package::*;

interface fifo_interface(
    input   wire    clk,
    input   wire    rst_n
);
    logic                       wr_en;
    logic                       rd_en;
    logic                       full;
    logic                       empty;
    logic [DATA_WIDTH-1:0]      din;
    logic [DATA_WIDTH-1:0]      dout;
endinterface

`endif