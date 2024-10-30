module top;
  timeunit 1ns/100ps;
  localparam time CP = 10ns;
  
  logic clk = 'b0;
  logic rst = 'b0;
  
  myintrface intface(clk, rst);
  
  busreader u1(
    .intf(intface.busread)
  );
  
  busmanager u2(
    .intf(intface.busmgr)
  );
  
  
 always #(CP/2) clk = ~clk;
  
  
 initial begin
  $timeformat(-9,0,"ns",0);
  $display("Test Bench Begins");
  $display("Time: %t  clk: %b, rst: %b ",$time,clk,rst);
  #5ns;
  rst = 'b1;
  $display("Time: %t  clk: %b, rst: %b ",$time,clk,rst);
  #5ns;
  rst = 'b0;
  $display("Time: %t  clk: %b, rst: %b ",$time,clk,rst);
  repeat(3)begin
    @(posedge clk);
    $display("Time: %t  clk: %b, rst: %b ",$time,clk,rst);
  end
  $finish;
 end
  
endmodule