`ifndef FIFO_PACKAGE_SVH
`define FIFO_PACKAGE_SVH

package fifo_package;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    `include "fifo_config.sv"
    `include "fifo_seq_item.sv"
    `include "fifo_cov_item.sv"
    `include "fifo_coverage.sv"
    `include "fifo_driver.sv"
    `include "fifo_monitor.sv"
    `include "fifo_scoreboard.sv"
    `include "fifo_agent.sv"
    `include "fifo_env.sv"
    `include "fifo_test_base.sv"

    `include "rand_rw_seq.sv"
    `include "rand_rw_test.sv"
endpackage

`endif