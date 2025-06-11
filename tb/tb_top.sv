`timescale 1ps/1ps

`include "fifo_define.svh"
`include "fifo_interface.sv"

`include "fifo_package.svh"
import fifo_package::*;

import uvm_pkg::*;

module tb_top;

    bit                 clk, rst_n;
    fifo_interface      vif (clk, rst_n);

    sync_fifo #(
        .DATA_WIDTH(`D_DATA_WIDTH),
        .FIFO_DEPTH(`D_FIFO_DEPTH)
    ) dut (
        .clk    (clk),
        .rst_n  (rst_n),
        .wr_en  (vif.wr_en),
        .rd_en  (vif.rd_en),
        .din    (vif.din),
        .dout   (vif.dout),
        .full   (vif.full),
        .empty  (vif.empty)
    );

    always #5 clk = ~clk;

    initial begin

        uvm_config_db #(virtual fifo_interface) :: set (null, "uvm_test_top", "vif", vif);
        
        clk = 0;
        rst_n = 0;

        #10;
        rst_n = 1;

        run_test();
    end

    initial begin
        $fsdbDumpfile("wave.fsdb");
        $fsdbDumpvars;
    end

endmodule