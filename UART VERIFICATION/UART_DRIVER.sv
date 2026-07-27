class uart_driver;
  uart_txn txn;
  virtual uart_if.DRIVER vif;

  function new(virtual uart_if.DRIVER vif);
    this.vif = vif;
  endfunction

  task reset_phase();
    vif.drv_cb.rst     <= 1'b1;
    vif.drv_cb.wr_en   <= 1'b0;
    vif.drv_cb.rdy_clr <= 1'b0;
    repeat (5) @(posedge vif.clk);
    vif.drv_cb.rst <= 1'b0;
  endtask

  task run(mailbox gen2drv, mailbox drv2sb, mailbox drv2rm);
    reset_phase();
    forever begin
      gen2drv.get(txn);       // Get transaction from generator
      send(txn);              // Drive DUT
      drv2sb.put(txn);        // Send to scoreboard
      drv2rm.put(txn);        // Send to reference model
    end
  endtask

  task send(uart_txn txn);
    @(posedge vif.clk);
    vif.drv_cb.data_in <= txn.data;
    vif.drv_cb.wr_en   <= 1'b1;
    @(posedge vif.clk);
    vif.drv_cb.wr_en   <= 1'b0;

    // Wait for DUT ready
	wait(!vif.drv_cb.busy)
    wait(vif.drv_cb.rdy);
    // Pulse rdy_clr to DUT
	txn.display("DRIVER SENT");
    vif.drv_cb.rdy_clr <= 1'b1;
    

    
  endtask
endclass

