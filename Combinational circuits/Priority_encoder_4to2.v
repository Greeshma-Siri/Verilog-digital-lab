module priority_encoder_4to2 (
    input [3:0] in,        // 4-bit input
    output reg [1:0] out,  // 2-bit encoded output
    output reg valid       // Valid indicator (high when at least one input is high)
);

    always @(*) begin
        valid = 1'b1;
        casez (in)  // casez treats 'z' and '?' as don't-care
            4'b1???: begin out = 2'b11; end  // Highest priority: in[3]
            4'b01??: begin out = 2'b10; end  // in[2]
            4'b001?: begin out = 2'b01; end  // in[1]
            4'b0001: begin out = 2'b00; end  // in[0]
            default: begin 
                out = 2'b00; 
                valid = 1'b0;  // No valid input
            end
        endcase
    end

endmodule
module tb_priority_encoder_monitor;
    reg [3:0] in;
    wire [1:0] out;
    wire valid;
    
    // Instantiate the priority encoder
    priority_encoder_4to2 dut (
        .in(in),
        .out(out),
        .valid(valid)
    );
    
    initial begin

        $monitor("Time=%0t: in=%b -> out=%b, valid=%b", $time, in, out, valid);
        
        // Initialize inputs
        in = 4'b0000;
        #10;
        
        // Test case 1: No input active
        in = 4'b0000;
        #10;
        
        // Test case 2: Single inputs (lowest to highest priority)
        in = 4'b0001;  // in[0] active
        #10;
        
        in = 4'b0010;  // in[1] active
        #10;
        
        in = 4'b0100;  // in[2] active
        #10;
        
        in = 4'b1000;  // in[3] active
        #10;
        
        // Test case 3: Multiple inputs - highest priority should win
        in = 4'b0011;  // in[1] and in[0] - in[1] should win
        #10;
        
        in = 4'b0110;  // in[2] and in[1] - in[2] should win
        #10;
        
        in = 4'b1100;  // in[3] and in[2] - in[3] should win
        #10;
        
        in = 4'b1010;  // in[3] and in[1] - in[3] should win
        #10;
        
        // Test case 4: All inputs active
        in = 4'b1111;
        #10;
        
        $finish;
    end
    
endmodule
