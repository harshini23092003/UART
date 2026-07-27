// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;

class my_component extends uvm_component;
  
  `uvm_component_utils(my_component)

  function new(string name = "my_component", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    string msg;
    msg = $sformatf("Build phase started. File: %s | Line: %0d", `__FILE__, `__LINE__);
    //uvm_report_info("BUILD_PHASE", msg, UVM_LOW);
	//uvm_report_warning("BUILD_PHASE","BUILD PHASE IS GOING TO COMPLETE SOON",UVM_LOW);
	`uvm_info(get_type_name(),msg,UVM_LOW)  
endfunction

  task run_phase(uvm_phase phase);
    string msg;
    msg = $sformatf("Running simulation logic... File: %s | Line: %0d", `__FILE__, `__LINE__);
    uvm_report_info("RUN_PHASE", msg, UVM_MEDIUM);
    
    
    msg = $sformatf("Simulation completed! File: %s | Line: %0d", `__FILE__, `__LINE__);
    uvm_report_info("RUN_PHASE", msg, UVM_LOW);

	uvm_report_fatal("RUN_PHASE","ERROR GETTING THE DATA",UVM_LOW);
   
  endtask

endclass


class my_test extends uvm_test;
  my_component comp;
  
  `uvm_component_utils(my_test)

  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    comp = my_component::type_id::create("comp", this);
  endfunction

endclass


module top;
  initial begin
    run_test("my_test");
uvm_top.set_report_verbosity_level(UVM_MEDIUM);
  end
endmodule

