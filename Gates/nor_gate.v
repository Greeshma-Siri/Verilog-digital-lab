`timescale 1ns/1ps

// ----------------------
// Design : NOR Gate
// ----------------------

module nor_gate (
    input  a, b,
    output y);
  assign y = !(a | b);
endmodule

// ----------------------
// Testbench
// ----------------------

module and_tb;
    reg a, b;
    wire y;
    nor_gate uut (.a(a), .b(b), .y(y));

    initial begin
      $display("a NOR b = y");
      a=0; b=0; #10 $display("%b NOR %b = %b", a, b, y);
      a=0; b=1; #10 $display("%b NOR %b = %b", a, b, y);
      a=1; b=0; #10 $display("%b NOR %b = %b", a, b, y);
      a=1; b=1; #10 $display("%b NOR %b = %b", a, b, y);
        $finish;
    end
endmodule
