

class uart_txn;
  rand bit [7:0] data;
  bit rdy_clr;

  function new();
    data = 8'h00;
    rdy_clr = 1'b0;
  endfunction

  task display(string msg);
    $display("[%0t] %s: DATA=0x%0h", $time, msg, data);
  endtask
endclass

