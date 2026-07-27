`timescale 1ns / 1ps
`include "uart_top.v";
`include "UART_TEST.sv"



module uart_tb_top;

  // Clock & Reset
  bit clk;
  bit rst;

  // DUT signals
  bit [7:0] data_in;
  bit wr_en;
  bit rdy_clr;
  wire rdy;
  wire busy;
  wire [7:0] data_out;

// Test handle
  uart_test test;

  // Instantiate interface
  uart_if uif(clk);

  // DUT instantiation and interface connection
  uart_top dut (
    .rst     (uif.rst),
    .data_in (uif.data_in),
    .wr_en   (uif.wr_en),
    .clk     (clk),
    .rdy_clr (uif.rdy_clr),
    .rdy     (uif.rdy),
    .busy    (uif.busy),
    .data_out(uif.data_out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz clock
  end

  // Reset generation
  initial begin
    rst = 1;
    uif.rst = 1;
    repeat (5) @(posedge clk);
    rst = 0;
    uif.rst = 0;
  end

  

  // Instantiate and start the test
  initial begin
    test = new(uif);
    test.run();
  end

endmodule

