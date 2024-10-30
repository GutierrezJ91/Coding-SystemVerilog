`timescale 1ns / 1ps

interface myintrface (input logic clk, input logic rst);
  
  logic [7:0] addr;
  logic as;
  logic rw;
  logic ds;
  logic da;
  logic [15:0] data;
  
  modport busread(
    input clk, rst, da, data,
    output addr, as, rw, ds
  );
  
  modport busmgr(
    input clk, rst, addr, as, rw, ds,
    output da, data
  );
    
endinterface


module busreader(
  myintrface.busread intf
);

  always_ff @(posedge intf.clk, negedge intf.rst)
    begin
     if(intf.rst) begin
        $display(" Reader Rst ");
      end else begin
        $display(" Reader Print ");
      end
    end
  
endmodule


module busmanager(
  myintrface.busmgr intf
);
  
  always_ff@(posedge intf.clk, negedge intf.rst)
    begin
      if(intf.rst) begin
        $display("Manager Rst ");
      end else begin
        $display("Manager Print");
      end
    end
  
endmodule 
