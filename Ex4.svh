package custom_package;
// Define an enumerated type named 'direction_t' with possible values 'UP' and 'DOWN'
 typedef enum logic {
    UP,
    DOWN
  } direction_t;
// Define an enumerated type named 'status_t' with possible values 'READY', 'BUSY', 'DONE', 'ERROR'
typedef enum logic [1:0]{
    READY,
    BUSY,
    DONE,
    ERROR
 } status_t;
// Define an enumerated type named 'err_t' with possible values 'UP_ERR' and 'DOWN_ERR' and 'NO_ERR'
typedef enum logic [1:0]{
    NO_ERR,
    UP_ERR,
    DOWN_ERR
 } err_t;
 
// Declare a local parameter 'default_start' as an integer with an initial value of 0
localparam default_start = 0;
// Declare a local parameter 'default_end' as an integer with an initial value of 0
localparam default_end = 0;   
// Declare a local parameter 'default_dir' of type 'direction_t' with an initial value 'UP'
localparam direction_t default_dir = UP;

endpackage : custom_package



module up_down_counter import custom_package::*; (
    
    input logic clk, 
    input logic rst_n, // Asynchronous active low reset 
    input logic en,    // Enable and run the counter
    input logic clear, // clear the cntr and done status register to default 0 and READY
    input direction_t direction, // Direction of the counter
    input logic [31:0] start_val, // Value that counter will start from
    input logic [31:0] end_val, // Value that counter should stop at
    output status_t status, // READY, BUSY, DONE, ERROR
    output err_t error_status, // ERROR types 'UP_ERR' and 'DOWN_ERR' and 'NO_ERR'
    output logic [31:0] cnt  // Counter final output
);
  

  
  // When the cnt reaches the end val it should stop and it should send the done status.
  always_ff @(posedge clk, negedge rst_n) begin
    if(!rst_n || clear) begin
       cnt <= start_val;
       status <= READY;
    end else if (en) begin
      if(direction == UP)begin
        if(cnt > end_val)begin
            cnt <= cnt;
            status <= ERROR;
        end 
        else if(cnt == end_val) begin
            cnt <= cnt;
            status <= DONE;
        end
        else begin
            cnt <= cnt+1;
            status <= BUSY;
        end 
      end 
      else begin
        if(cnt < end_val)begin
            cnt <= cnt;
            status <= ERROR;
        end
        else if(cnt == end_val)begin
            cnt <= cnt;
            status <= DONE;
        end else begin
            cnt <= cnt - 1;
            status <= BUSY;
        end
      end
    end else begin
        cnt <= start_val;
        status <= READY;
    end
  end
  
  //generate error_status
  assign error_status = (direction == UP && (end_val < start_val)) ? UP_ERR :
                (direction == DOWN && (end_val > start_val)) ? DOWN_ERR :
                NO_ERR;
 
endmodule