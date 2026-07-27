`timescale 1ns / 1ps

import UART_PKG::*;  // Contains uart_txn and uart_env



`timescale 1ns / 1ps

import UART_PKG ::*;

class uart_test;

  uart_env env;

virtual uart_if vif;

  // Constructor
  function new(virtual uart_if vif);
    env = new(vif);
  endfunction

  // Run phase
  task run();
    $display("[%0t] TEST: Starting UART Testbench...", $time);
    env.run();

    // Run for a fixed simulation time or wait for completion
    #5000000;

    $display("[%0t] TEST: Simulation completed.", $time);


    
  endtask

endclass




