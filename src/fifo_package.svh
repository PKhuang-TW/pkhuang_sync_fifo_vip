`ifndef FIFO_PACKAGE_SVH
`define FIFO_PACKAGE_SVH

package fifo_package;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    `include "fifo_define.svh"
    `include "fifo_interface.sv"
    `include "fifo_config.sv"
    `include "fifo_seq_item.sv"
    `include "fifo_driver.sv"
    `include "fifo_monitor.sv"
endpackage

`endif