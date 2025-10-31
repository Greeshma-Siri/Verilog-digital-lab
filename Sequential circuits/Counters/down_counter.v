module down_counter (
    input wire clk,
    input wire reset,
    input wire enable,
    output reg [3:0] count,
    output wire underflow
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b1111;  // Start from 15
        end else if (enable) begin
            count <= count - 1; // Count down
        end
    end

    assign underflow = (count == 4'b0000) & enable;

endmodule

module tb_down_counter;
    reg clk, reset, enable;
    wire [3:0] count;
    wire underflow;
    
    down_counter uut (clk, reset, enable, count, underflow);
    
    always #5 clk = ~clk;
    
    initial begin
        // Initialize
        clk = 0; reset = 0; enable = 0;
        
        // Test sequence
        #10 reset = 1;
        #20 reset = 0;
        #10 enable = 1;
        #200 $finish;
    end
    
    always @(posedge clk) begin
        $display("Time: %0t, Count: %d, Underflow: %b", $time, count, underflow);
    end
endmodule
