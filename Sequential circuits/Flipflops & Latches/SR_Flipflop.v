module sr_flip_flop(
    input clk,      // Clock input
    input rst,      // Reset input (active high)
    input s,        // Set input
    input r,        // Reset input
    output reg q        // Data output
);

always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 1'b0;
   else begin
        case ({s, r})
            2'b00:q <= q;       // No change - Hold state
            2'b01:q <= 1'b0;    // Reset - Q=0
            2'b10:q <= 1'b1;    // Set - Q=1
            2'b11:q <= 1'bx;    // Invalid state - both set and reset
        endcase
    end
end
endmodule

module tb_sr_flip_flop;
    reg clk;
    reg rst;
    reg s;
    reg r;
    wire q;
  
    sr_flip_flop dut (.clk(clk), .rst(rst),.s(s),.r(r),.q(q));

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t | RST=%b | S=%b | R=%b | Q=%b",$time, rst, s, r, q);
    end
    
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        s = 0;
        r = 0;
        
        // Apply reset
        #2 rst = 1;
      @(posedge clk) rst = 0;
        
        // Test all SR combinations
        #10 s = 0; r = 0;  // Hold
        #10 s = 0; r = 1;  // Reset
        #10 s = 0; r = 0;  // Hold
        #10 s = 1; r = 0;  // Set
        #10 s = 0; r = 0;  // Hold
        #10 s = 1; r = 1;  // Invalid state
        #10 s = 0; r = 0;  // Hold (comes out of invalid)
        
       
        #30 $finish;
    end
    
endmodule
