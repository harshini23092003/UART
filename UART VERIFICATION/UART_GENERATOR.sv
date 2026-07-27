class uart_generator;
  mailbox gen2drv;

  function new(mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task run();
repeat(500) begin
    uart_txn txn;
    txn = new();
    txn.data = $urandom_range(0,255); // Random 8-bit data
    gen2drv.put(txn);                 // Send only once
    $display("[%0t] GEN: Generated 0x%0h", $time, txn.data);
end
  endtask
endclass

