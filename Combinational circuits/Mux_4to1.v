//4:1 MUX Module (mux_4to1.v)

module mux_4to1(
    input [3:0] i, // 4-bit input
    input [1:0] s, // 2-bit select signal
    output y
);

    assign y = i[s]; // select input based on s

endmodule


//4:1 MUX Testbench (mux_4to1_tb.v)

module mux_4to1_tb;

    reg [3:0] i;
    reg [1:0] s;
    wire y;

    mux_4to1 uut (.i(i), .s(s), .y(y));

    initial begin
        $dumpfile("mux_4to1_tb.vcd");
        $dumpvars(0, mux_4to1_tb);

        // Test cases
        i = 4'b1010; s = 2'b00; #10; 
        i = 4'b1010; s = 2'b01; #10; 
        i = 4'b1010; s = 2'b10; #10; 
        i = 4'b1010; s = 2'b11; #10; 

        #10 $finish;
    end

    initial begin
        $monitor("i=%b s=%b y=%b", i, s, y);
    end

endmodule
