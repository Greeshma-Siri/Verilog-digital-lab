module sr_latch(
    input s,        // Set input
    input r,        // Reset input
    output reg q         // Data output
);

// Initialize q to avoid unknown state
initial    q = 1'b0;

always @(*) begin
    case ({s, r})
        2'b00: ;         // Hold - no action needed
        2'b01: q = 1'b0; // Reset
        2'b10: q = 1'b1; // Set
        2'b11: q = 1'bx; // Invalid state
    endcase
end
endmodule

module tb_sr_latch;
    reg s;
    reg r;
    wire q;
    
    // Instantiate the SR Latch
    sr_latch dut (.s(s),.r(r),.q(q));
    
    // Monitor to automatically display changes
    initial begin
        $monitor("Time=%0t | S=%b | R=%b | Q=%b", 
                 $time, s, r, q);
    end
    
    // Test sequence
    initial begin
        // Initialize signals
        s = 0;
        r = 0;
        
        // Start with Reset
        #10 s = 0; r = 1;  // Reset
        #10 s = 0; r = 0;  // Hold (should maintain reset state)
        
        // Test Set operation
        #10 s = 1; r = 0;  // Set
        #10 s = 0; r = 0;  // Hold (should maintain set state)
        
        // Test Reset operation again
        #10 s = 0; r = 1;  // Reset
        #10 s = 0; r = 0;  // Hold
        
        // Test Invalid state
        #10 s = 1; r = 1;  // Invalid
        #10 s = 0; r = 0;  // Hold (unpredictable after invalid)
        
        // Recovery from invalid state
        #10 s = 0; r = 1;  // Reset to known state
        #10 s = 0; r = 0;  // Hold
        
        #10 $finish;
    end
endmodule
