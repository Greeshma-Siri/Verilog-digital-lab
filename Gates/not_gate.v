`timescale 1ns/1ps

// ----------------------
// Design : NOT Gate
// ----------------------

module and_gate (
    input  a,
    output y);
    assign y = !a;
endmodule

// ----------------------
// Testbench
// ----------------------

module and_tb;
    reg a;
    wire y;
    and_gate uut (.a(a), .y(y));

    initial begin
      $display("!a = y");
      a=0; #10 $display("!%b = %b", a, y);
      a=1; #10 $display("!%b = %b", a, y);
        $finish;
    end
endmodule
