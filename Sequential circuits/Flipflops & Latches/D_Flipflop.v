module d_flip_flop(
    input clk,      // Clock input
    input rst,      // Reset input (active high)
    input d,        // Data input
    output reg q         // Data output
);

// D Flip-Flop behavior
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset condition - output goes to 0
        q <= 1'b0;
    end 
    else begin
        // On rising clock edge, capture input D
        q <= d;
    end
end
endmodule

module tb_d_flip_flop;
    // Test bench signals
    reg clk;
    reg rst;
    reg d;
    wire q;
    
    // Instantiate the D Flip-Flop
    d_flip_flop dut (
        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Monitor to automatically display changes
    initial begin
      $monitor("clk = %b | rst = %b | d = %b | q = %b",clk, rst, d, q);
    end
    
    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        d = 0;
        rst=0;
        
        // Apply reset
        #5 rst = 1;
      @(posedge clk) rst = 0;
        
        // Test data inputs
        @(posedge clk) d = 1;
        @(posedge clk) d = 0;
        @(posedge clk) d = 1;
        @(posedge clk) d = 1;
        @(posedge clk) d = 0;
        
      
        #20 $finish;
    end
    
endmodule
