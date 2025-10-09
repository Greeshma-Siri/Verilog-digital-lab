//Half Subtractor Module (half_subtractor.v)

module half_subtractor(
    input a, 
    input b, 
    output diff, 
    output borrow
);

    assign diff = a ^ b; // XOR for difference
    assign borrow = ~a & b; // borrow logic

endmodule


//Half Subtractor Testbench (half_subtractor_tb.v)

module half_subtractor_tb;

    reg a, b;
    wire diff, borrow;

    half_subtractor uut (.a(a), .b(b), .diff(diff), .borrow(borrow));

    initial begin
        $dumpfile("half_subtractor_tb.vcd");
        $dumpvars(0, half_subtractor_tb);

        // Test cases
        a = 1'b0; b = 1'b0; #10; 
        a = 1'b0; b = 1'b1; #10; 
        a = 1'b1; b = 1'b0; #10; 
        a = 1'b1; b = 1'b1; #10; 

        #10 $finish;
    end

    initial begin
        $monitor("a=%b b=%b diff=%b borrow=%b", a, b, diff, borrow);
    end

endmodule
