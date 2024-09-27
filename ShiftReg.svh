// Modeling a single bit shift 4 stage register.
// input -> ff_0 -> ff_1 -> ff_2 -> ff_out
// The model has to have clk, 
// active low reset (rst_n), 
// 1 bit input (d), 
// 1 bit output (q), 
// and 1 bit negated output (q_n)
// Use async reset

// Code your design here
`timescale 1ns/100ps;

module shiftreg(
	input clk,
	input rst_n,
	input d,
	output logic q,
  	output logic q_n);
  
  logic f1 = 0;
  logic f2 = 0;
  logic f3 = 0;
  
 
  always @(posedge clk, rst_n) begin
    if(!rst_n) begin
       q  <= 'b0;
       q_n <= 'b1;
    end else begin
       f1 <= d;
       f2 <= f1;
       f3 <= f2;
       q  <= f3;
       q_n <= !f3;
  	end
  end
    

endmodule