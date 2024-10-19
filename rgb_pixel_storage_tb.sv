module rgb_pixel_storage_tb;
    
    typedef struct {
        logic [7:0] RED;
        logic [7:0] GREEN;
        logic [7:0] BLUE;
        } rgb_pixel_t;
        
    rgb_pixel_t arr [24][24];
    
    initial begin
        arr[0][0].RED = 8'hFF;
        arr[0][0].GREEN = 8'h00;
        arr[0][0].BLUE = 8'h00;
        
        arr[0][1].RED = 8'h00;
        arr[0][1].GREEN = 8'hFF;
        arr[0][1].BLUE = 8'h00;   
        
        arr[0][2].RED = 8'h00;
        arr[0][2].GREEN = 8'h00;
        arr[0][2].BLUE = 8'hFF;      
        
        arr[0][3].RED = 8'hFF;
        arr[0][3].GREEN = 8'hFF;
        arr[0][3].BLUE = 8'hFF;  
        
        for(int i=0; i<4;i++)begin
            $display("Pixel (0,%0d) - RED: %0d, GREEN: %0d, BLUE: %0d", 
                    i, arr[0][i].RED, arr[0][i].GREEN, arr[0][i].BLUE);
        end
    
    end
    
        

endmodule
