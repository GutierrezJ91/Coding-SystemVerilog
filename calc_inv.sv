module calc_inv(
    input  logic clk,      
    input  logic rst_n,    
    input  logic en,      
    input  logic [127:0] data_i,  
    output logic [127:0] data_o, 
    output logic done
);

    logic [127:0] data_in;
    logic [127:0] data_out;
    logic done_out;
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_in   <= 'b0;
            data_out  <= 'b0;
            done_out  <= 'b0;
        end else if (en) begin
            data_in   <= data_i;
            data_out  <= ~data_i; 
            done_out <= 'b1;     
        end else begin
            done_out <= 'b0;
        end
    end
    
    assign data_o = data_out;
    assign done = done_out;


endmodule
