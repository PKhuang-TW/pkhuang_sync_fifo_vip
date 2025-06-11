`ifndef FIFO_AGENT_SV
`define FIFO_AGENT_SV

class fifo_agent extends uvm_agent;
    `uvm_component_utils(fifo_agent)

    uvm_active_passive_enum         agt_mode;

    fifo_driver                     drv;
    fifo_monitor                    mon;
    uvm_sequencer #(fifo_seq_item)  seqr;

    function new ( string name = "fifo_agent", uvm_component parent );
        super.new(name, parent);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);

        if ( !uvm_config_db #(uvm_active_passive_enum) :: get (this, "", "agt_mode", agt_mode) )
            `uvm_error("AGTMODE", $sformatf("No agt_mode set for %s.agt_mode", get_full_name()))

        uvm_config_db #(uvm_active_passive_enum) :: set (this, "mon", "agt_mode", agt_mode);

        mon = fifo_monitor :: type_id :: create ("mon", this);
        if ( agt_mode == UVM_ACTIVE ) begin
            drv = fifo_driver :: type_id :: create ("drv", this);
            seqr = uvm_sequencer #(fifo_seq_item) :: type_id :: create ("seqr", this);
        end
    endfunction

    function void connect_phase ( uvm_phase phase );
        super.connect_phase(phase);
        if ( agt_mode == UVM_ACTIVE )
            drv.seq_item_port.connect ( seqr.seq_item_export );
    endfunction

endclass

`endif