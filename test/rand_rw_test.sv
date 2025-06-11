`ifndef RAND_RW_TEST_SV
`define RAND_RW_TEST_SV

class rand_rw_test extends fifo_test_base;
    `uvm_component_utils(rand_rw_test)

    rand_rw_seq     seq;

    function new (string name = "rand_rw_test", uvm_component parent );
        super.new(name, parent);
    endfunction

    function void build_phase ( uvm_phase phase );
        super.build_phase(phase);
    endfunction

    virtual task run_phase ( uvm_phase phase );
        phase.raise_objection(this);
        seq = rand_rw_seq :: type_id :: create ("seq");
        seq.start ( env.agt_active.seqr );
        phase.drop_objection(this);
    endtask
endclass

`endif