module cmos_inverter (output y, input a);
  supply1 Vdd;  // logic 1 (power)
  supply0 Gnd;  // logic 0 (ground)

  // drain, source, gate connections
  pmos (y, Vdd, a);  // PMOS: ON when a=0
  nmos (y, Gnd, a);  // NMOS: ON when a=1
endmodule
module tb_cmos_inverter;
  reg a;
  wire y;

  cmos_inverter uut (y, a);

  initial begin
    $monitor("time=%0t | a=%b | y=%b", $time, a, y);
    a = 0; #10;
    a = 1; #10;
  end
endmodule
