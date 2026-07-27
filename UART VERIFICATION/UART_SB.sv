class uart_scoreboard;

  mailbox rm2sb;
  mailbox mon2sb;

  // For functional coverage
  bit [7:0] act_data, exp_data;
  int num_txns = 0;

  uart_txn act, exp;

  // --------------------------------------------------
  // COVERAGE GROUP (auto-created embedded covergroup)
  // --------------------------------------------------
  covergroup cov;
    // Cover sent and received data ranges
    coverpoint exp_data {
      bins low_vals  = {[0:63]};
      bins mid_vals  = {[64:127]};
      bins high_vals = {[128:255]};
    }

   /* coverpoint act_data {
      bins low_vals[]  = {[0:63]};
      bins mid_vals[]  = {[64:127]};
      bins high_vals[] = {[128:255]};*/
    

    // Cross coverage ? ensures both tx and rx data combinations occur
    //cross exp_data, act_data;
  endgroup : cov


  // --------------------------------------------------
  // CONSTRUCTOR
  // --------------------------------------------------
  function new(mailbox rm2sb, mailbox mon2sb);
    this.rm2sb = rm2sb;
    this.mon2sb = mon2sb;
    cov = new();
  endfunction


  // --------------------------------------------------
  // MAIN SCOREBOARD LOGIC
  // --------------------------------------------------
  task run();
    forever begin
      fork
        mon2sb.get(act);
        rm2sb.get(exp);
      join

      act_data = act.data;
      exp_data = exp.data;

      // Compare results
      if (act.data === exp.data)
        $display("[%0t] SB: PASS! DATA=0x%0h", $time, act.data);
      else
        $display("[%0t] SB: FAIL! ACT=0x%0h EXP=0x%0h", $time, act.data, exp.data);

      // Sample coverage
      cov.sample();
      num_txns++;
    end
  endtask


  // --------------------------------------------------
  // TASK TO REPORT COVERAGE
  // --------------------------------------------------
  function void report();
    $display("--------------------------------------------------");
    $display("Functional Coverage = %0.2f%%", cov.get_coverage());
    $display("Total Transactions  = %0d", num_txns);
    $display("--------------------------------------------------");
  endfunction

endclass

