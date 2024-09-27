// Update the following verilog code to use SystemVerilog alwasy_ff, always_comb and always_latch instead
// of simple always block

// Code your design here
`timescale 1ns/100ps;

module inference_examples(
    input logic clk,           // Clock input for the flip-flop
    input logic rst_n,         // Asynchronous reset for the flip-flop (active low)
    input logic enable,        // Enable signal for the latch
    input logic sel,           // Selector for the multiplexer
    input logic [7:0] d,       // Data input for the flip-flop and latch
    input logic [7:0] mux_in0, // First input for the multiplexer
    input logic [7:0] mux_in1, // Second input for the multiplexer
    output logic [7:0] q_ff,    // Output of the flip-flop
    output logic [7:0] q_latch, // Output of the latch
    output logic [7:0] q_mux    // Output of the multiplexer
);

    // Flip-Flop (positive edge triggered with asynchronous reset)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q_ff <= 'b0; // Reset the flip-flop to 0
        end else begin
            q_ff <= d;    // Load the input d into the flip-flop on clock edge
        end
    end

    // Latch (inferred when enable is high)
    always_latch begin
        if (enable) begin
            q_latch <= d; // Latch the input d when enable is high
        end
    end

    // Combinational Logic Multiplexer using if
    always_comb begin
        if (sel == 1'b0) begin
            q_mux = mux_in0; // Select input 0
        end else begin
            q_mux = mux_in1; // Select input 1
        end
    end

endmodule