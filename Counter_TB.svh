module Counter_TB;
timeunit 1ns/100ps;
	localparam time CP = 10ns;
    
    logic clk;
    logic rst_n;
    logic load;
    logic enable;
    logic [4:0] start_val;
    logic [4:0] count;
    int failurecount;
    
    
    initial begin
    	clk = 'b1;
        forever
        	#(CP/2) clk = !clk;
    end
  
    RollOverCounter uut(
    .clk(clk),
    .rst_n(rst_n),
    .load(load),
    .enable(enable),
    .start_val(start_val),
    .count(count)
    );
    
    initial begin
    	$timeformat(-9,0,"ns",0);
        $monitor("Time %t:  clk = %b, rst_n = %b, load = %b, enable = %b, start_val = %5b, count = %5b", $time,clk,rst_n,load,enable,start_val,count);
    end
    
	initial begin
      $display("1. RESET CHECK");
      @(negedge clk);
      rst_n = 'b0;
      load = 'b0;
      enable = 'b0;
      start_val = 'b0;
      failurecount = 0;
      @(posedge clk);
      assert (count == 'b0) $display ("\tRESET CHECK Passed! :)"); else begin $error ("\tRESET CHECK Failed :'( "); failurecount++; end
      
      @(posedge clk);	
      $display("2. ENABLE COUNT CHECK");
      rst_n = 'b1;
      load = 'b0;
      enable = 'b1;
      for(int i = 1;i <= 5;i=i+1) begin
        @(posedge clk);
        assert (count == i) $display ("\tENABLE COUNT CHECK Passed! :)"); else begin $error ("\tENABLE COUNT CHECK Failed :'("); failurecount++; end
      end
      
      @(posedge clk);	
      $display("3. DISABLE COUNT CHECK");
      rst_n = 'b1;
      load = 'b0;
      enable = 'b0;
      repeat(5) begin
        @(posedge clk);
        assert (count == 'b110) $display ("\tDISABLE COUNT CHECK Passed! :)"); else begin $error ("\tDISABLE COUNT CHECK Failed :'("); failurecount++; end
      end
      
      @(posedge clk);	
      $display("4. LOAD FUNCTION CHECK");
      start_val = 'h8;
      
      @(posedge clk);
      rst_n = 'b1;
      load = 'b1;
      enable = 'b0;
      
      @(posedge clk);
      assert (count == 'h8) $display ("\tLOAD FUNCTION CHECK Passed! :)"); else begin $error ("\tLOAD FUNCTION CHECK Failed :'("); failurecount++; end
      
      @(posedge clk);	
      $display("5. LOAD AND ENABLE PRIORITY CHECK");
      
      repeat(2) begin 
        rst_n = 'b1;
        load = 'b1;
        enable = 'b1;
        @(posedge clk);
        assert (count == 'h8) $display ("\tLOAD AND ENABLE PRIORITY Passed! :)"); else begin $error ("\tLOAD AND ENABLE PRIORITY  Failed :'("); failurecount++; end
      end
      
      @(posedge clk);	
      $display("6. COUNTER ROLLOVER CHECK");
      rst_n = 'b1;
      load = 'b0;
      enable = 'b1;
      wait(count == 'b11111);
      repeat(2) @(posedge clk);
      assert(count == 0) $display ("\tCOUNTER ROLLOVER CHECK  Passed! :)"); else begin $error ("\tCOUNTER ROLLOVER CHECK  Failed :'("); failurecount++; end
      
      $display("*******************************************");
      assert(failurecount == 0) $display("+++++COUNTER TEST PASSED+++++"); else $error("-----COUNTER TEST FAILED-----\n\t\t Failure Count = %d",failurecount);
      $finish;

    end

endmodule;