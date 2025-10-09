//4-bit Magnitude Comparator Module (comparator.v)

module comparator(
    input [3:0] a, // 4-bit input a
    input [3:0] b, // 4-bit input b
    output agtb, // a greater than b
    output altb, // a less than b
    output aeqb  // a equal to b
);

    assign agtb = (a > b);
    assign altb = (a < b);
    assign aeqb = (a == b);

endmodule


//4-bit Magnitude Comparator Testbench (comparator_tb.v)

module comparator_tb;

    reg [3:0] a, b;
    wire agtb, altb, aeqb;

    comparator uut (.a(a), .b(b), .agtb(agtb), .altb(altb), .aeqb(aeqb));

    initial begin
        $dumpfile("comparator_tb.vcd");
        $dumpvars(0, comparator_tb);

        // Test cases
        a = 4'b1010; b = 4'b1000; #10; 
        a = 4'b1000; b = 4'b1010; #10; 
        a = 4'b1010; b = 4'b1010; #10; 

        #10 $finish;
    end

    initial begin
        $monitor("a=%b b=%b agtb=%b altb=%b aeqb=%b", a, b, agtb, altb, aeqb);
    end

endmodule
