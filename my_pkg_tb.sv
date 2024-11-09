module my_pkg_tb;
  import my_pkg::*;
  
 
  bit [7:0] d;
  bit strt_bit;
  bit [1:0] stp_bits;
  bit prty_bit;
  
  UartTransactionClass c1;
  
  initial begin
    
    $display("***********TestBench Begins************");
    $display("Initializating TestBench Variables........");
    d = 'h57;
    strt_bit = 'b1;
    stp_bits = 'b10;
    prty_bit = 'b1;
    $display("Current TestBench Variables and Values:  data_tb: %b , start_bit_tb: %b,  stop_bits_tb: %b, parity_bit_tb: %b",d,strt_bit,stp_bits,prty_bit);
    
    $display("Creating Class Instance c1.........");
    c1 = new();
    $display("Current Instance c1 Variables and Values:   data: %b , start_bit: %b,  stop_bits: %b, parity_bit: %b", c1.data, c1.start_bit, c1.stop_bits, c1.parity_bit);
    $display("Calling functions c1.set_data().........");
    c1.set_data(d);
    $display("Verifying function operation.........");
    assert(c1.data == d) $display("PASS!"); else $error("FAIL!");
    $display("Calling functions c1.set_parity().........");
    c1.set_parity();
    $display("Current Instance c1 Variables and Values:   data: %b , start_bit: %b,  stop_bits: %b, parity_bit: %b", c1.data, c1.start_bit, c1.stop_bits, c1.parity_bit);
    $display("Verify parity bit w/ c1.check_parity()......");
    assert(c1.check_parity() == 'b1) $display("PASS!"); else $error("FAIL!");
    $display("***********TestBench Complete************");
   
  end
      
  
endmodule
