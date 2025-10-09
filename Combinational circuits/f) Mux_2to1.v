//2:1 MUX Module (mux_2to1.v)

module mux_2to1(
    input a,
    input b,
    input s, // select signal
    output y
);

    assign y = s ? b : a; // select b if s=1, otherwise select a

endmodule


//2:1 MUX Testbench (mux_2to1_tb.v)

module mux_2to1_tb;

    reg a, b, s;
    wire y;

    mux_2to1 uut (.a(a), .b(b), .s(s), .y(y));

    initial begin
        $dumpfile("mux_2to1_tb.vcd");
        $dumpvars(0, mux_2to1_tb);

        // Test cases
        a = 1'b0; b = 1'b0; s = 1'b0; #10; 
        a = 1'b0; b = 1'b1; s = 1'b0; #10; 
        a = 1'b1; b = 1'b0; s = 1'b0; #10; 
        a = 1'b1; b = 1'b1; s = 1'b0; #10; 
        a = 1'b0; b = 1'b0; s = 1'b1; #10; 
        a = 1'b0; b = 1'b1; s = 1'b1; #10; 
        a = 1'b1; b = 1'b0; s = 1'b1; #10; 
        a = 1'b1; b = 1'b1; s = 1'b1; #10; 

        #10 $finish;
    end

    initial begin
        $monitor("a=%b b=%b s=%b y=%b", a, b, s, y);
    end

endmodule
