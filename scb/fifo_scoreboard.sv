`ifndef FIFO_SCOREBOARD_SV
`define FIFO_SCOREBOARD_SV

import fifo_package::*;

class fifo_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(fifo_scoreboard)

    `uvm_analysis_imp_decl(_active)
    `uvm_analysis_imp_decl(_passive)

    bit                                                         wr_en, rd_en, full, empty;
    bit [`D_ADDR_WIDTH-1:0]                                      counter;
    bit [`D_DATA_WIDTH-1:0]                                      ref_q[$];

    fifo_config                                                 cfg;
    virtual fifo_interface                                      vif;

    uvm_analysis_imp_active #(fifo_seq_item, fifo_scoreboard)   imp_active;
    uvm_analysis_imp_passive #(fifo_seq_item, fifo_scoreboard)  imp_passive;

    function new (string name = "fifo_scoreboard", uvm_component parent );
        super.new(name, parent);
        imp_active = new("imp_active", this);
        imp_passive = new("imp_passive", this);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);

        if ( !uvm_config_db #(fifo_config) :: get (this, "", "cfg", cfg) )
            `uvm_error("NOCFG", $sformatf("No config set for %s.cfg", get_full_name()))
        vif = cfg.vif;
    endfunction

    task void run_phase ( uvm_phase phase );
        forever begin
            @ ( posedge vif.clk );
            if ( !vif.rst_n ) begin
                wr_en   = 0;
                rd_en   = 0;
                full    = 0;
                empty   = 1;
                counter = 0;
                ref_q.delete();
            end
        end
    endtask

    function void write_active ( fifo_seq_item _txn );
        {wr_en, rd_en}  = {_txn.wr_en, _txn.rd_en};

        if ( wr_en && !full ) begin
            ref_q.push_back(_txn.din);
            counter = counter + 1;
        end else if ( rd_en && !empty ) begin
            counter = counter - 1;
        end

        if ( counter == `D_FIFO_DEPTH ) begin
            full = 1;
        end else begin
            full = 0;
        end 
        
        if ( counter == 0 ) begin
            empty = 1;
        end else begin
            empty = 0;
        end
    endfunction

    function void write_passive ( fifo_seq_item _txn );
        bit[`D_DATA_WIDTH-1:0]   data;

        if ( full != _txn.full)
            `uvm_fatal("SCB", $sformatf("Full signal Miscompare!! Get %0d while expected %0d", _txn.full, full))

        if ( empty != _txn.empty)
            `uvm_fatal("SCB", $sformatf("Empty signal Miscompare!! Get %0d while expected %0d", _txn.empty, empty))

        if ( rd_en && !empty ) begin
            data = ref_q.pop_front();
            if ( data != _txn.dout )
                `uvm_fatal("SCB", $sformatf("Data Miscompare!! Get %0d while expected %0d", _txn.dout, data))
        end
    endfunction

endclass

`endif