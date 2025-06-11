`ifndef FIFO_ENV_SV
`define FIFO_ENV_SV

class fifo_env extends uvm_env;
    `uvm_component_utils(fifo_env)

    fifo_agent          agt_active, agt_passive;
    fifo_scoreboard     scb;
    fifo_coverage       cov;

    function new ( string name, uvm_component parent );
        super.new(name, parent);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);

        agt_active = fifo_agent :: type_id :: create ("agt_active", this);
        agt_passive = fifo_agent :: type_id :: create ("agt_passive", this);
        scb = fifo_scoreboard :: type_id :: create ("scb", this);
        cov = fifo_coverage :: type_id :: create ("cov", this);

        uvm_config_db #(uvm_active_passive_enum) :: set (this, "agt_active", "agt_mode", UVM_ACTIVE);
        uvm_config_db #(uvm_active_passive_enum) :: set (this, "agt_passive", "agt_mode", UVM_PASSIVE);
    endfunction

    function void connect_phase ( uvm_phase phase );
        super.connect_phase(phase);

        agt_active.mon.port.connect ( scb.imp_active );
        agt_passive.mon.port.connect ( scb.imp_passive );

        scb.cov_port.connect ( cov.analysis_export );
    endfunction
endclass

`endif
