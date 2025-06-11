`ifndef RAND_RW_SEQ_SV
`define RAND_RW_SEQ_SV

class rand_rw_seq extends uvm_sequence #(fifo_seq_item);
    `uvm_object_utils(rand_rw_seq)

    function new ( string name = "rand_rw_seq" );
        super.new(name);
    endfunction

    virtual task body ();
        fifo_seq_item txn;

        for ( int i=0; i<10000; i++ ) begin
            txn = fifo_seq_item :: type_id :: create ("txn");
            if ( !txn.randomize() )
                `uvm_error("RANDERR", "txn randomize error!");
            start_item(txn);
            finish_item(txn);
        end
    endtask

endclass

`endif