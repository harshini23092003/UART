class uart_env;
  uart_generator    gen;
  uart_driver       drv;
  uart_monitor      mon;
  uart_scoreboard   sb;
  uart_ref_model    rm;

  mailbox gen2drv, drv2sb, mon2sb, drv2rm, rm2sb;
  virtual uart_if vif;

  function new(virtual uart_if vif);
    this.vif = vif;
    gen2drv = new();
    drv2sb  = new();
    mon2sb  = new();
    drv2rm  = new();
    rm2sb   = new();

    gen = new(gen2drv);
    drv = new(vif.DRIVER);
    mon = new(vif.MONITOR, mon2sb);
    sb  = new(rm2sb, mon2sb);
    rm  = new(drv2rm, rm2sb);
  endfunction

  task run();
    fork
      gen.run();
      drv.run(gen2drv, drv2sb, drv2rm);
      rm.run();
      mon.run();
      sb.run();
    join_none
  endtask
endclass

