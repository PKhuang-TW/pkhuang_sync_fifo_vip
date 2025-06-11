`ifndef FIFO_DRIVER_SV
`define FIFO_DRIVER_SV

class fifo_driver extends uvm_driver #(fifo_seq_item);
    `uvm_component_utils(fifo_driver)

    fifo_seq_item               txn;

    fifo_config                 cfg;
    virtual fifo_interface      vif;

    function new (string name = "fifo_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);
        
        if ( !uvm_config_db #(fifo_config) :: get (this, "", "cfg", cfg) )
            `uvm_error("NOCFG", $sformatf("No config set for %s.cfg", get_full_name()))
        vif = cfg.vif;
    endfunction

    task void run_phase (uvm_phase phase);
        forever begin
            @ ( posedge vif.clk );
            txn = fifo_seq_item :: type_id :: create("txn");
            seq_item_port.get_next_item(txn);
            drive_item(txn);
            seq_item_port.item_done();

            @ ( posedge vif.clk );
            reset_signal();
        end
    endtask

    task void drive_item ( fifo_seq_item txn );
        vif.wr_en   <= txn.wr_en;
        vif.rd_en   <= txn.rd_en;

        if ( txn.wr_en )
            vif.din <= txn.din;
    endtask

    task void reset_signal();
        vif.wr_en   <= 0;
        vif.rd_en   <= 0;
        vif.din     <= 0;
    endtask

endclass

`endif