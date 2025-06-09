`ifndef FIFO_CONFIG_SV
`define FIFO_CONFIG_SV

import fifo_package::*;

class fifo_config extends uvm_object;
    `uvm_object_utils(fifo_config)

    virtual fifo_interface      vif;

    function new ( string name = "fifo_config" );
        super.new(name);
    endfunction
endclass

`endif