`ifndef FIFO_MONITOR_SV
`define FIFO_MONITOR_SV

import fifo_package::*;

class fifo_monitor extends uvm_monitor;
    `uvm_component_utils(fifo_monitor)

    fifo_seq_item                       txn;

    uvm_analysis_port #(fifo_seq_item)  port;

    fifo_config                         cfg;
    virtual fifo_interface              vif;

    uvm_active_passive_enum             agt_mode;

    function new (string name = "fifo_monitor", uvm_component parent );
        super.new(name, parent);
        port = new("port", this);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);
        
        if ( !uvm_config_db #(uvm_active_passive_enum) :: get (this, "", "agt_mode", agt_mode) )
            `uvm_error("AGTMODE", $sformatf("No agt_mode set for %s.agt_mode", get_full_name()))
        
        if ( !uvm_config_db #(fifo_config) :: get (this, "", "cfg", cfg) )
            `uvm_error("NOCFG", $sformatf("No config set for %s.cfg", get_full_name()))
        vif = cfg.vif;
    endfunction

    task void run_phase ( uvm_phase phase );
        forever begin
            @ ( posedge vif.clk );
            txn = fifo_seq_item :: type_id :: create("txn");
            if ( agt_mode == UVM_ACTIVE ) begin
                txn.wr_en       = vif.wr_en;
                txn.rd_en       = vif.rd_en;
                txn.din         = vif.din;
            end else begin  // agt_mode == UVM_PASSIVE
                if ( vif.wr_en ) begin
                    @ ( posedge vif.clk );
                    txn.full    = vif.full;
                    txn.empty   = vif.empty;
                end else if ( vif.rd_en ) begin
                    @ ( posedge vif.clk );
                    txn.dout    = vif.dout;
                    txn.full    = vif.full;
                    txn.empty   = vif.empty;
                end
            end
            port.write(txn);
        end
    endtask

endclass

`endif