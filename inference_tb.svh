

module inference_tb();
timeunit 1ns/100ps;
localparam time CP = 10;

  logic clk;
  logic rst_n;
  logic enable;
  logic sel;
  logic [7:0] d;
  logic [7:0] mux_in0;
  logic [7:0] mux_in1;
  logic [7:0] q_ff;
  logic [7:0] q_latch;
  logic [7:0] q_mux;
  string str;

inference_examples DUT( 
  .clk(clk),
  .rst_n(rst_n),
  .enable(enable),
  .sel(sel),
  .d(d),
  .mux_in0(mux_in0),
  .mux_in1(mux_in1),
  .q_ff(q_ff),
  .q_latch(q_latch),
  .q_mux(q_mux));

initial
  begin
    $timeformat(-9,0,"ns",0);
    $display("----------Initialization-----------");
    clk = 'b0;
    rst_n = 'b1;
    enable = 'b0;
    sel = 'b0;
    d = 'hAA;
    mux_in0 = 'hAB;
    mux_in1 = 'hCD;
    $write("time: %t, ctrl [clk: %b, rstn: %b, enable: %b, sel: %b]	",$time, clk, rst_n, enable, sel);
    $display("	data in [d: 0x%h, mux_in0: 0x%h, mux_in1: 0x%h]",d, mux_in0, mux_in1);
    $display("								data out [q_ff: 0x%h, q_latch: 0x%h, q_mux: 0x%h]", q_ff, q_latch, q_mux);
    $display("Performing Asynchronous Negative-Edge Triggered Reset.................................................");
    $display(" ");
    @(posedge clk);
    $write("time: %t, ctrl [clk: %b, rstn: %b, enable: %b, sel: %b]	",$time, clk, rst_n, enable, sel);
    $display("	data in [d: 0x%h, mux_in0: 0x%h, mux_in1: 0x%h]",d, mux_in0, mux_in1);
    $display("								data out [q_ff: 0x%h, q_latch: 0x%h, q_mux: 0x%h]", q_ff, q_latch, q_mux);
    rst_n = 'b0;
    #1ns;
    $write("time: %t, ctrl [clk: %b, rstn: %b, enable: %b, sel: %b]	",$time, clk, rst_n, enable, sel);
    $display("	data in [d: 0x%h, mux_in0: 0x%h, mux_in1: 0x%h]",d, mux_in0, mux_in1);
    $display("								data out [q_ff: 0x%h, q_latch: 0x%h, q_mux: 0x%h]", q_ff, q_latch, q_mux);
    assert(q_ff == 'h00) $display("				*** Reset Confirmed!"); else $error("				!!! Reset Error");
    #1ns;
    rst_n = 'b1;
    $display("----------Initialization Complete------");
    $display(" ");
  end

always #(CP/2) clk = ~clk;
 
initial
  begin
    wait(rst_n == 'b0);
    wait(rst_n == 'b1);
    $display("----------TESTBENCH BEGINS-----------");
    d = 'hFF;
    enable = 'b0;
    sel = 'b0;
    @(posedge clk)
    $display("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    $display(">>>>>>   FLIPFLOP TEST   <<<<<<");
    $display("");
    $display("1st Rising Edge.......");
    $display("");
    $write("time: %t, ctrl [clk: %b, rstn: %b, enable: %b, sel: %b]	",$time, clk, rst_n, enable, sel);
    $display("	data in [d: 0x%h, mux_in0: 0x%h, mux_in1: 0x%h]",d, mux_in0, mux_in1);
    $display("								data out [q_ff: 0x%h, q_latch: 0x%h, q_mux: 0x%h]", q_ff, q_latch, q_mux);
    $display("");
    @(posedge clk)
    $display("2nd Rising Edge.......");
    $display("");
    $write("time: %t, ctrl [clk: %b, rstn: %b, enable: %b, sel: %b]	",$time, clk, rst_n, enable, sel);
    $display("	data in [d: 0x%h, mux_in0: 0x%h, mux_in1: 0x%h]",d, mux_in0, mux_in1);
    $display("								data out [q_ff: 0x%h, q_latch: 0x%h, q_mux: 0x%h]", q_ff, q_latch, q_mux);
    $display("");
    assert(q_ff == 'hFF) $display("				*** PASSED! *** q_ff = d after 1 clock cycle"); else $error("				!!! FAILED! !!! q_ff != d");
    $display("");
    $display(">>>>>>   FLIPFLOP TEST DONE  <<<<<<");
    $display("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    $display(">>>>>>   	   LATCH TEST      <<<<<<");
    $display("");
    #1ns;
    enable = 'b1;
    $write("time: %t, ctrl [clk: %b, rstn: %b, enable: %b, sel: %b]	",$time, clk, rst_n, enable, sel);
    $display("	data in [d: 0x%h, mux_in0: 0x%h, mux_in1: 0x%h]",d, mux_in0, mux_in1);
    $display("								data out [q_ff: 0x%h, q_latch: 0x%h, q_mux: 0x%h]", q_ff, q_latch, q_mux);
    $display("");
    #1ns;
    $write("time: %t, ctrl [clk: %b, rstn: %b, enable: %b, sel: %b]	",$time, clk, rst_n, enable, sel);
    $display("	data in [d: 0x%h, mux_in0: 0x%h, mux_in1: 0x%h]",d, mux_in0, mux_in1);
    $display("								data out [q_ff: 0x%h, q_latch: 0x%h, q_mux: 0x%h]", q_ff, q_latch, q_mux);
    $display("");
    assert(q_latch == 'hFF) $display("				*** PASSED! *** d is latched into q_latch"); else $error("						!!! FAILED! !!! d is not latched into q_latch");
    $display("");
    $display(">>>>>>   	LATCH TEST DONE    <<<<<<");
    $display("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    $display(">>>>>>   	   MUX TEST      <<<<<<");
    #1ns;
    $write("time: %t, ctrl [clk: %b, rstn: %b, enable: %b, sel: %b]	",$time, clk, rst_n, enable, sel);
    $display("	data in [d: 0x%h, mux_in0: 0x%h, mux_in1: 0x%h]",d, mux_in0, mux_in1);
    $display("								data out [q_ff: 0x%h, q_latch: 0x%h, q_mux: 0x%h]", q_ff, q_latch, q_mux);
    assert(q_mux == mux_in0) $display("				*** PASSED! *** q_mux = mux_in0"); else $error("			!!! FAILED! !!! q_mux != mux_in0");
    sel = 'b1;
    #1ns;
    $write("time: %t, ctrl [clk: %b, rstn: %b, enable: %b, sel: %b]	",$time, clk, rst_n, enable, sel);
    $display("	data in [d: 0x%h, mux_in0: 0x%h, mux_in1: 0x%h]",d, mux_in0, mux_in1);
    $display("								data out [q_ff: 0x%h, q_latch: 0x%h, q_mux: 0x%h]", q_ff, q_latch, q_mux);
    assert(q_mux == mux_in1) $display("				*** PASSED! *** q_mux = mux_in1"); else $error("				!!! FAILED! !!! q_mux != mux_in1");
    $display(">>>>>>   	MUX TEST DONE    <<<<<<");
    $display("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    $display("----------TESTBENCH ENDS-------");
    $display("");
    
    $finish;
  end

endmodule
