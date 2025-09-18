//Half Adder Module (half_adder.v)

module half_adder(
    input a,
    input b,
    output sum,
    output carry
);

    assign sum = a ^ b; // XOR for sum
    assign carry = a & b; // AND for carry

endmodule


//Half Adder Testbench (half_adder_tb.v)

module half_adder_tb;

    reg a, b;
    wire sum, carry;

    half_adder uut (.a(a), .b(b), .sum(sum), .carry(carry));

    initial begin
        $dumpfile("half_adder_tb.vcd");
        $dumpvars(0, half_adder_tb);

        // Test cases
        a = 1'b0; b = 1'b0; #10; // a=0, b=0
        a = 1'b0; b = 1'b1; #10; // a=0, b=1
        a = 1'b1; b = 1'b0; #10; // a=1, b=0
        a = 1'b1; b = 1'b1; #10; // a=1, b=1

        #10 $finish;
    end

    initial begin
        $monitor("a=%b b=%b sum=%b carry=%b", a, b, sum, carry);
    end

endmodule
