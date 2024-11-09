package my_pkg;
  
  class UartTransactionClass;
    bit [7:0] data;
    bit start_bit;
    bit [1:0] stop_bits;
    bit parity_bit;
    
    // Constructor with parameters
    function new(bit [7:0] data = 'h0, bit start_bit = 'b0, bit [1:0] stop_bits = 'b0, bit parity_bit = 'b0);
      this.data = data;
      this.start_bit = start_bit;
      this.stop_bits = stop_bits;
      this.parity_bit = parity_bit;
    endfunction
    
    function void set_data(input bit [7:0] new_data);
      data = new_data;
    endfunction
    
    function bit [7:0] get_data();
      return data;
    endfunction
    
    extern function void set_parity();
    extern function bit check_parity();
  
  endclass

  // Definition of the extern functions
  function void UartTransactionClass::set_parity();
    parity_bit = ^data;
  endfunction
  
  function bit UartTransactionClass::check_parity();
    if (parity_bit == ^data) begin
      return 'b1;
    end else begin
      return 'b0;
    end
  endfunction

endpackage
