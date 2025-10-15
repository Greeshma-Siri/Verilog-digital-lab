module jk_flip_flop(
    input clk,      // Clock input
    input rst,      // Reset input (active high)
    input j,        // J input
    input k,        // K input
    output reg q         // Data output
);

always @(posedge clk) begin
    if (rst) begin
        q <= 1'b0;
    end 
    else begin
        case ({j, k})
            2'b00: q <= q;   // No change - Hold state
            2'b01: q <= 1'b0; // Reset - Q goes to 0
            2'b10: q <= 1'b1; // Set - Q goes to 1
            2'b11: q <= ~q;   // Toggle - Q becomes complement
        endcase
    end
end
endmodule

module tb_jk_flip_flop;
    // Test bench signals
    reg clk;
    reg rst;
    reg j;
    reg k;
    wire q;
    
    // Instantiate the JK Flip-Flop
    jk_flip_flop dut (.clk(clk),.rst(rst),.j(j), .k(k),.q(q));
    
    always #5 clk = ~clk;
    
    initial begin
        $monitor(" j = %b | k = %b | q = %b", j, k, q);
    end
    
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        j = 0;
        k = 0;
        
        // Apply reset
        #2 rst = 1;
        @(posedge clk) rst = 0;
        
        // Test all JK combinations
        @(posedge clk) j = 0; k = 0;  // Hold
        @(posedge clk) j = 0; k = 1;  // Reset
        @(posedge clk) j = 1; k = 0;  // Set
        @(posedge clk) j = 1; k = 1;  // Toggle
        @(posedge clk) j = 1; k = 1;  // Toggle again
        @(posedge clk) j = 0; k = 0;  // Hold
        @(posedge clk) j = 0; k = 1;  // Reset
        @(posedge clk) j = 1; k = 1;  // Toggle
        @(posedge clk) j = 0; k = 0;  // Hold
            
        #30 $finish;
    end
    
endmodule
