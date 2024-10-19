module up_down_counter_tb;
timeunit 1ns/100ps;
  import custom_package::*;
  localparam time CP = 10ns;
  
  logic clk = 'b0;
  logic rst_n;
  logic en;
  logic clear;
  direction_t direction;
  logic [31:0] start_val;
  logic [31:0] end_val;
  status_t status;
  err_t error_status;
  logic [31:0] cnt;
  
  function void display_data();
        $display("Time %t:\t clk= %b, rst_n= %b, en= %b, clear= %b, direction= %p, start_val= %2d, end_val= %2d, status= %p, error= %p, cnt= %2d", $time, clk, rst_n, en, clear, direction, start_val, end_val, status, error_status, cnt);
    endfunction
   
  // Use dot-name format to instantiate the uut
  up_down_counter DUT (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clear(clear),
        .direction(direction),
        .start_val(start_val),
        .end_val(end_val),
        .status(status),
        .error_status(error_status),
        .cnt(cnt)
    );
  
  always #(CP/2) clk <= ~clk;
  
  
 initial begin
   $timeformat(-9,0,"ns",0);
   $display("------------TESTING BEGINS---------------");
   $display("1. INITIALIZING INPUTS");
   rst_n = 'b1;
   en = 'b0;
   clear = 'b0;
   direction = default_dir;
   start_val = 'd0;
   end_val = 'd10;
   display_data();
   
   $display("2. RESET CHECK ");
   repeat(10)begin
    display_data();
    #1ns;
   end
   rst_n = 'b0;
   repeat(5)begin
    display_data();
    #1ns;
   end
   display_data();
   assert(cnt == 'b0 && status == READY) $display("RESET CHECK PASSED :)"); else $error("RESET CHECK FAILED :(");
   
   $display("3. COUNT UP CHECK");
   rst_n = 'b1;
   en = 'b1;
   repeat(12) begin
    @(posedge clk);
    display_data();
   end
   assert(cnt == 'd10 && status == DONE) $display("COUNT UP CHECK PASSED :)"); else $error("COUNT UP CHECK FAILED :(");
   
   $display("4. CLEAR CHECK");
   en = 'b0;
   clear = 'b1;
   display_data();
   repeat(1) begin
    @(posedge clk);
    display_data();
   end
   assert(cnt == 'd0 && status == READY) $display("CLEAR CHECK PASSED :)"); else $error("CLEAR CHECK FAILED :(");
   
   $display("4. COUNT UP ERROR CHECK");
   clear = 'b1;
   en = 'b1;
   start_val = 'd10;
   end_val = 'd5;
   display_data();
   @(posedge clk);
   clear = 'b0;
   repeat(2) begin
    @(posedge clk);
    display_data();
   end
   assert(status == ERROR && error_status == UP_ERR) $display("COUNT UP ERROR PASSED :)"); else $error("COUNT UP ERROR FAILED :(");
   
   
   $display("4. COUNT DOWN CHECK");
   clear = 'd1;
   start_val = 'd10;
   end_val = 'd4;
   direction = DOWN;
   @(posedge clk);
   clear = 'd0;
   display_data();
   repeat(7) begin
    @(posedge clk);
    display_data();
   end
   
   assert(cnt =='d4 && status == DONE) $display("COUNT DOWN CHECK PASSED :)"); else $error("COUNT DOWN CHECK FAILED :(");
   
   
   $display("5. COUNT DOWN ERROR CHECK");
   rst_n = 'd0;
   start_val = 'd4;
   end_val = 'd10;
   direction = DOWN;
   @(posedge clk);
   rst_n = 'd1;
   display_data();
   repeat(1) begin
    @(posedge clk);
    display_data();
   end
   assert(status == ERROR && error_status == DOWN_ERR) $display("COUNT DOWN ERROR PASSED :)"); else $error("COUNT DOWN ERROR FAILED :(");
   
   $display("------------TESTING COMPLETE---------------");
   $finish;
 end


  
endmodule