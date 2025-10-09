//4-to-2 Encoder Module (encoder_4to2.v)

module encoder_4to2(
    input [3:0] in, // 4-bit input
    output [1:0] out // 2-bit output
);

    always @(*) begin
        casex (in)
            4'b1xxx: out = 2'b11;
            4'b01xx: out = 2'b10;
            4'b001x: out = 2'b01;
            4'b0001: out = 2'b00;
            default: out = 2'b00; // or any other default value
        endcase
    end

endmodule


//4-to-2 Encoder Testbench (encoder_4to2_tb.v)

module encoder_4to2_tb;

    reg [3:0] in;
    wire [1:0] out;

    encoder_4to2 uut (.in(in), .out(out));

    initial begin
        $dumpfile("encoder_4to2_tb.vcd");
        $dumpvars(0, encoder_4to2_tb);

        // Test cases
        in = 4'b0001; #10; 
        in = 4'b0010; #10; 
        in = 4'b0100; #10; 
        in = 4'b1000; #10; 

        #10 $finish;
    end

    initial begin
        $monitor("in=%b out=%b", in, out);
    end

endmodule
