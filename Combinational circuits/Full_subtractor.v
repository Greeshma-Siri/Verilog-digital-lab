//Full Subtractor Module (full_subtractor.v)

module full_subtractor(
    input a, 
    input b, 
    input bin, 
    output diff, 
    output bout 
);

    assign diff = a ^ b ^ bin; // XOR for difference
    assign bout = (~a & (b | bin)) | (b & bin); // borrow-out logic

endmodule


//Full Subtractor Testbench (full_subtractor_tb.v)

module full_subtractor_tb;
    reg a, b, bin;
    wire diff, bout;

    full_subtractor uut (.a(a), .b(b), .bin(bin), .diff(diff), .bout(bout));

    initial begin
        $dumpfile("full_subtractor_tb.vcd");
        $dumpvars(0, full_subtractor_tb);

        // Test cases
        a = 1'b0; b = 1'b0; bin = 1'b0; #10; 
        a = 1'b0; b = 1'b0; bin = 1'b1; #10; 
        a = 1'b0; b = 1'b1; bin = 1'b0; #10; 
        a = 1'b0; b = 1'b1; bin = 1'b1; #10; 
        a = 1'b1; b = 1'b0; bin = 1'b0; #10; 
        a = 1'b1; b = 1'b0; bin = 1'b1; #10; 
        a = 1'b1; b = 1'b1; bin = 1'b0; #10; 
        a = 1'b1; b = 1'b1; bin = 1'b1; #10; 

        #10 $finish;
    end

    initial begin
        $monitor("a=%b b=%b bin=%b diff=%b bout=%b", a, b, bin, diff, bout);
    end

endmodule
