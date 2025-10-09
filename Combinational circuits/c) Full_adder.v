//Full Adder Module (full_adder.v)

module full_adder(
    input a,
    input b,
    input cin, // carry-in
    output sum,
    output cout // carry-out
);

    assign sum = a ^ b ^ cin; // XOR for sum
    assign cout = (a & b) | (cin & (a ^ b)); // carry-out logic

endmodule


//Full Adder Testbench (full_adder_tb.v)

module full_adder_tb;

    reg a, b, cin;
    wire sum, cout;

    full_adder uut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        $dumpfile("full_adder_tb.vcd");
        $dumpvars(0, full_adder_tb);

        // Test cases
        a = 1'b0; b = 1'b0; cin = 1'b0; #10; 
        a = 1'b0; b = 1'b0; cin = 1'b1; #10; 
        a = 1'b0; b = 1'b1; cin = 1'b0; #10; 
        a = 1'b0; b = 1'b1; cin = 1'b1; #10; 
        a = 1'b1; b = 1'b0; cin = 1'b0; #10; 
        a = 1'b1; b = 1'b0; cin = 1'b1; #10; 
        a = 1'b1; b = 1'b1; cin = 1'b0; #10; 
        a = 1'b1; b = 1'b1; cin = 1'b1; #10; 

        #10 $finish;
    end

    initial begin
        $monitor("a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
    end

endmodule
