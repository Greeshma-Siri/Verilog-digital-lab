module up_down_counter (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire up_down,      // 1 for up, 0 for down
    output reg [3:0] count
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (enable) begin
            if (up_down) begin
                count <= count + 1;  // Count up
            end else begin
                count <= count - 1;  // Count down
            end
        end
    end

endmodule

module tb_up_down_counter;
    reg clk;
    reg reset;
    reg enable;
    reg up_down;
    wire [3:0] count;
    
    up_down_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .up_down(up_down),
        .count(count)
    );

    always #5 clk = ~clk;
    
    initial begin
        // Initialize
        clk = 0;
        reset = 0;
        enable = 0;
        up_down = 1;
        
        // Reset
        reset = 1;
        #20;
        reset = 0;
        #10;
        
        // Count up
        $display("Counting up...");
        enable = 1;
        up_down = 1;
        #100;
        
        // Count down
        $display("Counting down...");
        up_down = 0;
        #100;
        
        // Disable
        $display("Disabled...");
        enable = 0;
        #50;
        
        $finish;
    end
    
    always @(posedge clk) begin
        $display("Time: %0t, Count: %0d, Direction: %s", 
                 $time, count, up_down ? "UP" : "DOWN");
    end
    
endmodule
