class uart_ref_model;
  mailbox drv2rm;
  mailbox rm2sb;

  function new(mailbox drv2rm, mailbox rm2sb);
    this.drv2rm = drv2rm;
    this.rm2sb = rm2sb;
  endfunction

  task run();
    uart_txn txn;
    uart_txn exp;
    forever begin
      drv2rm.get(txn);   // Get transaction from driver
      exp = new();
      exp.data = txn.data; // For UART, expected = transmitted
      rm2sb.put(exp);
      exp.display("RM GENERATED");
    end
  endtask
endclass

