`timescale 1ns/1ps

// ----------------------
// Design : NAND Gate
// ----------------------

module nand_gate (
    input  a, b,
    output y);
  assign y = !(a & b);
endmodule

// ----------------------
// Testbench
// ----------------------

module nand_tb;
    reg a, b;
    wire y;
    nand_gate uut (.a(a), .b(b), .y(y));

    initial begin
      $display("a NAND b = y");
      a=0; b=0; #10 $display("%b NAND %b = %b", a, b, y);
      a=0; b=1; #10 $display("%b NAND %b = %b", a, b, y);
      a=1; b=0; #10 $display("%b NAND %b = %b", a, b, y);
      a=1; b=1; #10 $display("%b NAND %b = %b", a, b, y);
        $finish;
    end
endmodule
