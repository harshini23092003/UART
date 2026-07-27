`timescale 1ns / 1ps

interface uart_if(input bit clk);

  // Signals shared with DUT
  logic rst;
  logic [7:0] data_in;
  logic wr_en;
  logic rdy_clr;
  logic rdy;
  logic busy;
  logic [7:0] data_out;

  // Clocking block for synchronous access
  clocking drv_cb @(posedge clk);
    output rst, data_in, wr_en, rdy_clr;
    input  rdy, busy, data_out;
  endclocking

  //--------------------------------------
  // DRIVER modport
  //--------------------------------------
  modport DRIVER(input clk,
   clocking drv_cb
  );

  //--------------------------------------
  // MONITOR modport
  //--------------------------------------
  modport MONITOR(
    input rdy, data_out, clk,
    output rdy_clr
  );

endinterface

