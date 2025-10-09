//2-to-4 Decoder Module (decoder_2to4.v)

module decoder_2to4(
    input [1:0] in, // 2-bit input
    output [3:0] out // 4-bit output
);

    assign out = 1 << in; // decode input to output

endmodule


//2-to-4 Decoder Testbench (decoder_2to4_tb.v)

module decoder_2to4_tb;

    reg [1:0] in;
    wire [3:0] out;

    decoder_2to4 uut (.in(in), .out(out));

    initial begin
        $dumpfile("decoder_2to4_tb.vcd");
        $dumpvars(0, decoder_2to4_tb);

        // Test cases
        in = 2'b00; #10; 
        in = 2'b01; #10; 
        in = 2'b10; #10; 
        in = 2'b11; #10; 

        #10 $finish;
    end

    initial begin
        $monitor("in=%b out=%b", in, out);
    end

endmodule
