module up_counter_4bit (
    input wire clk,          // Clock input
    input wire reset,        // Active high reset
    input wire enable,       // Count enable
    output reg [3:0] count,  // 4-bit counter output
    output wire overflow     // Overflow indicator
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;  // Reset to 0
        end else if (enable) begin
            count <= count + 1; // Increment when enabled
        end
    end

    assign overflow = (count == 4'b1111) & enable;

endmodule

module tb_up_counter_4bit;
    // Testbench signals
    reg clk;
    reg reset;
    reg enable;
    wire [3:0] count;
    wire overflow;
    
    up_counter_4bit uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count),
        .overflow(overflow)
    );
 
    always #5 clk = ~clk;
    
    initial begin
        // Initialize signals
        $display("Initializing testbench...");
        clk = 0;
        reset = 0;
        enable = 0;
        
        // Test 1: Reset test
        $display("\n=== Test 1: Reset Test ===");
        reset = 1;
        #20;
        reset = 0;
        #10;
        if (count !== 4'b0000) begin
            $display("ERROR: Reset failed! Count = %b", count);
        end else begin
            $display("PASS: Reset successful");
        end
        
        // Test 2: Disabled counting
        $display("\n=== Test 2: Disabled Counting ===");
        enable = 0;
        #50;
        if (count !== 4'b0000) begin
            $display("ERROR: Counter should not count when disabled!");
        end else begin
            $display("PASS: Counter correctly disabled");
        end
        
        // Test 3: Normal counting
        $display("\n=== Test 3: Normal Counting ===");
        enable = 1;
        #100; // Count for 10 clock cycles
        
        // Test 4: Count to overflow
        $display("\n=== Test 4: Overflow Test ===");
        // Continue counting until overflow
        wait(overflow == 1);
        $display("Overflow detected at count = %d", count);

                
        #50;
        $finish;
    end
    

    always @(posedge clk) begin
        $display("Time: %0t ns, Clock: ↑, Reset: %b, Enable: %b, Count: %d (%b), Overflow: %b",
                $time, reset, enable, count, count, overflow);
    end
    
    initial begin
        $dumpfile("up_counter_waveforms.vcd");
        $dumpvars(0, tb_up_counter_4bit);
    end
    
endmodule
