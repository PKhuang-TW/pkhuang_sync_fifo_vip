`ifndef FIFO_COVERAGE_SV
`define FIFO_COVERAGE_SV

class fifo_coverage extends uvm_subscriber #(fifo_cov_item);
    `uvm_component_utils(fifo_coverage)

    fifo_cov_item   cov_item;

    covergroup fifo_cg;
        cp_wrEn:    coverpoint cov_item.wr_en;
        cp_rdEn:    coverpoint cov_item.rd_en;
        cp_full:    coverpoint cov_item.full;
        cp_empty:   coverpoint cov_item.empty;
        cp_counter: coverpoint cov_item.counter { bins range[] = {[0 : `D_FIFO_DEPTH]}; }

        cross cp_wrEn, cp_full;
        cross cp_rdEn, cp_full;
        cross cp_wrEn, cp_empty;
        cross cp_rdEn, cp_empty;
        cross cp_counter, cp_wrEn;
        cross cp_counter, cp_rdEn;
    endgroup

    function new (string name = "fifo_coverage", uvm_component parent);
        super.new(name, parent);
        fifo_cg = new();
    endfunction

    function void write (fifo_cov_item t);
        // Default var name shall be "t"
        cov_item = t;
        fifo_cg.sample();
    endfunction

endclass

`endif