`timescale 1ns/1ps

// ----------------------
// Design : OR Gate
// ----------------------

module or_gate (
    input  a, b,
    output y);
    assign y = a | b;
endmodule

// ----------------------
// Testbench
// ----------------------

module or_tb;
    reg a, b;
    wire y;
    or_gate uut (.a(a), .b(b), .y(y));

    initial begin
      $display("a | b = y");
      a=0; b=0; #10 $display("%b | %b = %b", a, b, y);
      a=0; b=1; #10 $display("%b | %b = %b", a, b, y);
      a=1; b=0; #10 $display("%b | %b = %b", a, b, y);
      a=1; b=1; #10 $display("%b | %b = %b", a, b, y);
        $finish;
    end
endmodule
