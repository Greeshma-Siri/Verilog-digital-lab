//4bit ripple carry adder using fulladder

//full adder module(full_adder.v)
module full_adder (
    input a,      // Input bit a
    input b,      // Input bit b
    input cin,    // Carry in
    output sum,   // Sum output
    output cout   // Carry out
);

    assign sum = a ^ b ^ cin;
    
    assign cout = (a & b) | (cin & (a ^ b));

endmodule

//ripple carry adder module(ripple_carry_adder.v)
module ripple_carry_adder_4bit (
    input [3:0] a,      // 4-bit input A
    input [3:0] b,      // 4-bit input B
    input cin,          // Carry input
    output [3:0] sum,   // 4-bit sum output
    output cout         // Carry output
);

    // Internal carry wires
    wire [3:0] carry;
    
    // Instantiate 4 full adders in cascade
    full_adder fa0 (.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(carry[0]) );
    
    full_adder fa1 (.a(a[1]),.b(b[1]),.cin(carry[0]),.sum(sum[1]),.cout(carry[1]) );
    
    full_adder fa2 (.a(a[2]),.b(b[2]),.cin(carry[1]),.sum(sum[2]),.cout(carry[2]) );
    
    full_adder fa3 (.a(a[3]),.b(b[3]),.cin(carry[2]),.sum(sum[3]),.cout(cout) );

endmodule

//ripple carry adder testbench(ripple_carry_adder_tb.v)
module ripple_carry_adder_tb;
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout;
    
    // Expected results
    reg [3:0] expected_sum;
    reg expected_cout;
    wire [4:0] expected_result;  // 5-bit result {cout, sum}
    
    // Instantiate the 4-bit ripple carry adder
    ripple_carry_adder_4bit dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    
    initial begin
        // Initialize monitor
        $monitor("Time=%0t: a=%b, b=%b, cin=%b -> sum=%b, cout=%b ",
                 $time, a, b, cin, sum, cout, );
        

        
        // Test case 1: Basic addition without carry
        #10 a = 4'b0000; b = 4'b0000; cin = 1'b0;
        #10 a = 4'b0001; b = 4'b0001; cin = 1'b0;
        #10 a = 4'b0010; b = 4'b0011; cin = 1'b0;
        
        // Test case 2: Addition with carry input
        #10 a = 4'b0001; b = 4'b0001; cin = 1'b1;
        #10 a = 4'b0010; b = 4'b0011; cin = 1'b1;

       // Test case 3: Overflow cases
        #10 a = 4'b1111; b = 4'b0001; cin = 1'b0;
        #10 a = 4'b1111; b = 4'b1111; cin = 1'b0;
        #10 a = 4'b1111; b = 4'b1111; cin = 1'b1;
        
        #10 $finish;
    end

endmodule
