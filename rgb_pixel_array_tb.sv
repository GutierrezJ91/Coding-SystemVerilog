
module rgb_pixel_array_tb;

    timeunit 1ns/100ps;
    localparam ROWS = 24;
    localparam COLS = 24;
    
    logic [7:0] image [ROWS][COLS][3];
    
    initial begin
        
        image[0][0][0] = 8'hFF;
        image[0][0][1] = 8'h00;
        image[0][0][2] = 8'h00;
        
        $display("Pixel (0,0) RGB: %h %h %h", image[0][0][0], image[0][0][1], image[0][0][2]);
   
    end
    
    



endmodule
