module t_flip_flop(
    input wire clk,      // Clock input
    input wire rst,      // Reset input (active high)
    input wire t,        // Toggle input
    output reg q         // Data output
);

// T Flip-Flop behavior
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset condition - output goes to 0
        q <= 1'b0;
    end else begin
        // T Flip-Flop functionality
        if (t) begin
            q <= ~q;    // Toggle when T=1
        end
        // Note: No else needed - q holds its value automatically
    end
end

endmodule
module tb_t_flip_flop;
    reg clk;
    reg rst;
    reg t;
    wire q;
    
    // Instantiate the T Flip-Flop
    t_flip_flop dut (.clk(clk), .rst(rst), .t(t), .q(q));
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        $monitor("time=%0t | rst=%b | t=%b | q=%b", $time, rst, t, q);
    end
  
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        t = 0;
        
        // Apply reset
        #2 rst = 1;
        @(posedge clk) rst = 0;
        
        // Test T=0 (Hold mode)
        @(posedge clk) t = 0;
        @(posedge clk) t = 0;  // Continue holding
        
        // Test T=1 (Toggle mode)
        @(posedge clk) t = 1;
        @(posedge clk) t = 1;  // Toggle again
        @(posedge clk) t = 1;  // Toggle again
        @(posedge clk) t = 1;  // Toggle again
        
        // Test alternating T input
        @(posedge clk) t = 0;  // Hold
        @(posedge clk) t = 1;  // Toggle
        @(posedge clk) t = 0;  // Hold
        @(posedge clk) t = 1;  // Toggle
        @(posedge clk) t = 0;  // Hold
        
        #30 $finish;
    end
endmodule
