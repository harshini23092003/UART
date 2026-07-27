class uart_monitor;
  virtual uart_if.MONITOR vif;
  mailbox mon2sb;

  function new(virtual uart_if.MONITOR vif, mailbox mon2sb);
    this.vif = vif;
    this.mon2sb = mon2sb;
  endfunction

  task run();
    uart_txn txn;
    forever begin
      @(posedge vif.rdy);  // Rising edge of ready
      txn = new();
      txn.data = vif.data_out;
      txn.display("MONITOR CAPTURED");
      mon2sb.put(txn);

      // Clear rdy in DUT
      vif.rdy_clr <= 1'b1;
      @(posedge vif.clk);
      vif.rdy_clr <= 1'b0;
    end
  endtask
endclass

