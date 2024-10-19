

module calc_inv_tb;
    timeunit 1ns/100ps;
    localparam time CP = 10ns;
    
    logic clk = 'b0;
    logic rst_n;
    logic en;
    logic [127:0] data_i;
    logic [127:0] data_o;
    logic done;
    
    logic[127:0] expected;
    
    function void display_data();
        $display("Time %t:\t clk= %b, rst_n= %b, en= %b, data_i= %h, data_o= %h, done = %b", $time, clk, rst_n, en, data_i, data_o, done);
    endfunction
    
    function logic [127:0] calc_inverse(
        input logic [127:0] input_val
        );
        return ~input_val;
    endfunction
    
    calc_inv DUT(
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .data_i(data_i),
        .data_o(data_o),
        .done(done)
        );
        
        
    always #(CP/2) clk = ~clk;
    
    initial begin
      $timeformat(-9,0,"ns",0);
      $display("--------TESTING BEGINS---------");
      $display("1.INITIALIZING INPUTS AND RESET");
      data_i = 'hFFFFFFFFFFFFFFFF0000000000000000;
      en = 'b0;
      rst_n = 'b0;
      #CP;
      rst_n = 'b1;
      display_data();
      
      
      $display("2.ENABLE ACTIVATED");
      @(posedge clk);
      en= 'b1;
      display_data();
      expected = calc_inverse(data_i);
      wait(done == 'b1);
      display_data();
      assert(data_o == expected)$display("Data output matches expected value: Test Passed :)"); else $error("data output does not match expected value: Test Failed");
      $display("--------TESTING COMPLETED---------");
      $finish;
    end
        
    
endmodule
