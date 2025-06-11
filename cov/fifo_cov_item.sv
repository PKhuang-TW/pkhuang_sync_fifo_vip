`ifndef FIFO_COV_ITEM_SV
`define FIFO_COV_ITEM_SV

`include "fifo_define.svh"

class fifo_cov_item extends uvm_object;
    `uvm_object_utils(fifo_cov_item)

    bit                     wr_en;
    bit                     rd_en;
    bit                     full;
    bit                     empty;
    bit [`D_ADDR_WIDTH:0]   counter;

    function new (string name = "fifo_cov_item");
        super.new(name);
    endfunction
endclass

`endif