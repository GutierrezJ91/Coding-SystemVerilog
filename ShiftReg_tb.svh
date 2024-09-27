// Code your testbench here
// or browse Examples

module shiftreg_tb();
timeunit 1ns/100ps;
localparam time CP = 10ns;

logic d;
logic rst_n;
logic clk;
logic q;
logic q_n;

shiftreg u0 ( 
  .clk(clk),
  .rst_n(rst_n),
  .d(d),
  .q(q),
  .q_n(q_n));

initial
  begin
    $timeformat(-9,0,"ns",0);
    $display("----------Input Initialization-----------");
    d = 'b0;
    clk = 'b0;
    rst_n = 'b0;
    $display("time: %0t,	clk: %0b,	 d: %0b,	 rstn: %0b,	 q: %0b,	 qn: %0b",$time, clk, d, rst_n, q, q_n);
    $display("..........Performing Asynchronous Reset..........");
    @(posedge clk);
    $display("time: %0t,	clk: %0b,	 d: %0b,	 rstn: %0b,	 q: %0b,	 qn: %0b",$time, clk, d, rst_n, q, q_n);
    #2.5ns;
    rst_n = 'b1;
    $display("time: %0t,	clk: %0b,	 d: %0b,	 rstn: %0b,	 q: %0b,	 qn: %0b",$time, clk, d, rst_n, q, q_n);
    $display("----------Initialization Done-----------");
    #2.5ns;
    
  end

always #(CP/2) clk = ~clk;
 
initial
  begin
    wait(rst_n == 'b1)
    $display("----------Test Start-----------");
    d = 'b1;
    @(posedge clk)
    $display(".........1st Rising Edge");
    $display("time: %0t,	clk: %0b,	 d: %0b,	 rstn: %0b,	 q: %0b,	 qn: %0b",$time, clk, d, rst_n, q, q_n);
    assert(q == 0 && q_n == 1) $display("passed!"); else $error("error");
    @(posedge clk)
    $display(".........2nd Rising Edge");
    $display("time: %0t,	clk: %0b,	 d: %0b,	 rstn: %0b,	 q: %0b,	 qn: %0b",$time, clk, d, rst_n, q, q_n);
    assert(q == 0 && q_n == 1) $display("passed!"); else $error("error");
    @(posedge clk)
    $display(".........3rd Rising Edge");
    $display("time: %0t,	clk: %0b,	 d: %0b,	 rstn: %0b,	 q: %0b,	 qn: %0b",$time, clk, d, rst_n, q, q_n);
    assert(q == 0 && q_n == 1) $display("passed!"); else $error("error");
    @(posedge clk)
    $display(".........4th Rising Edge");
    $display("time: %0t,	clk: %0b,	 d: %0b,	 rstn: %0b,	 q: %0b,	 qn: %0b",$time, clk, d, rst_n, q, q_n);
    assert(q == 1 && q_n == 0) $display("passed!"); else $error("error");
    $display("----------Test End-----------");
    $finish;
  end

endmodule
