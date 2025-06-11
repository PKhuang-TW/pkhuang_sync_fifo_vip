`ifndef FIFO_TEST_BASE_SV
`define FIFO_TEST_BASE_SV

class fifo_test_base extends uvm_test;
    `uvm_component_utils(fifo_test_base)

    fifo_env            env;

    fifo_config         cfg;

    function new ( string name = "fifo_test_base", uvm_component parent );
        super.new(name, parent);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);

        env = fifo_env :: type_id :: create ("env", this);
        cfg = fifo_config :: type_id :: create ("cfg");

        if ( !uvm_config_db #(virtual fifo_interface) :: get (this, "", "vif", cfg.vif) )
            `uvm_error("NOVIF", $sformatf("No interface set for %s.vif", get_full_name()))

        uvm_config_db #(fifo_config) :: set (this, "*", "cfg", cfg);
    endfunction
endclass


`endif