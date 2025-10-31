module johnson_counter (
    input wire clk,
    input wire reset,
    input wire enable,
    output reg [3:0] count
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (enable) begin
            //shift and complement the feedback
            count <= {~count[0], count[3:1]};
        end
    end
endmodule

module tb_johnson_counter;
    reg clk, reset, enable;
    wire [3:0] count;
    
    johnson_counter uut (clk, reset, enable, count);
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0; reset = 0; enable = 0;
        
        $display("Testing Johnson Counter...");
        
        reset = 1; #20; reset = 0; #10;
        enable = 1;
        
        #160;
        
        $finish;
    end
    
    always @(posedge clk) begin
        $display("Time: %0t, Johnson Count: %b", $time, count);
    end
endmodule
