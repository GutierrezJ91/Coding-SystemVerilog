`timescale 1ns/1ps;
// Name the module counter.
module RollOverCounter(
  input logic clk,
  input logic rst_n,
  input logic load,
  input logic enable,
  input logic [4:0] start_val,
  output logic [4:0] count
);
  

  always_ff @ (posedge clk,negedge rst_n)begin
      if(!rst_n) begin
        count <= 'b0;
      end
      else if(load) begin
         count <= start_val;
      end
      else if(enable) begin
      	 count <= count + 1;
      end
      else begin
         count <= count;
      end
  end
  
  endmodule;