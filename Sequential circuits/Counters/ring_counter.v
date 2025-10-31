module simple_ring_counter (
    input wire clk,          // Clock input
    input wire reset,        // Active high reset
    input wire enable,       // Shift enable
    output reg [3:0] count   // Ring counter output
);

    // Simple ring counter logic - shifts single '1' through the register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0001;  // Initialize with LSB as '1'
        end else if (enable) begin
            // Shift left with wrap-around (MSB goes to LSB)
            count <= {count[2:0], count[3]};
        end
    end
endmodule

module tb_simple_ring_counter;
    reg clk, reset, enable;
    wire [3:0] count;
    
    simple_ring_counter uut (clk, reset, enable, count);
    
    always #5 clk = ~clk;
    
    initial begin
        // Initialize
        clk = 0; reset = 0; enable = 0;
        
        // Simple test sequence
        #10 reset = 1;
        #20 reset = 0;
        #10 enable = 1;
        
        // Run for 2 complete cycles
        #160;
        
        $finish;
    end
    
    always @(posedge clk) begin
        if (enable)
            $display("Time: %0t, Count: %b", $time, count);
    end
endmodule
