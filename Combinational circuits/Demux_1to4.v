//1:4 DEMUX Module (demux_1to4.v)

module demux_1to4(
    input data_in,
    input [1:0] sel,     // 2-bit select line
    output out0,         // Output when sel=00
    output out1,         // Output when sel=01
    output out2,         // Output when sel=10
    output out3          // Output when sel=11
);

    assign out0 = (sel == 2'b00) ? data_in : 1'b0;
    assign out1 = (sel == 2'b01) ? data_in : 1'b0;
    assign out2 = (sel == 2'b10) ? data_in : 1'b0;
    assign out3 = (sel == 2'b11) ? data_in : 1'b0;
  
endmodule


//1:4 DEMUX Testbench (demux_1to4_tb.v)

module demux_1to4_tb;

    reg data_in;
    reg [1:0] sel;
    wire out0, out1, out2, out3;
    
    demux_1to4 dut (
        .data_in(data_in),
        .sel(sel),
        .out0(out0),
        .out1(out1),
        .out2(out2),
        .out3(out3)
    );
    
    initial begin
      $dumpfile("demux_1to4_tb.vcd");
      $dumpvars(0, demux_1to4_tb);
        data_in = 0;
        sel = 0;
       

        // Test cases
        #5 data_in = 1; sel = 2'b00;
        #5 sel = 2'b01;
        #5 sel = 2'b10;
        #5 sel = 2'b11;
        
        #5 data_in = 0; sel = 2'b00;
        #5 sel = 2'b01;
        #5 sel = 2'b10;
        #5 sel = 2'b11;
        
        // Test data transitions
        #5 data_in = 1; sel = 2'b01;
        #5 data_in = 0;
        #5 data_in = 1;
        #5 data_in = 0; 

        #10 $finish;
    end

    initial begin
      $monitor("TIME=%0t: DATA_IN=%b, SEL=%b -> OUT0=%b, OUT1=%b, OUT2=%b, OUT3=%b", $time, data_in, sel, out0, out1, out2, out3);
    end

endmodule
