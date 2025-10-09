//1:2 DEMUX Module (demux_1to2.v)

module demux_1to2(
    input data_in,
    input sel,           // 1-bit select line
    output out0,         // Output when sel=0
    output out1          // Output when sel=1
);

    assign out0 = (sel == 1'b0) ? data_in : 1'b0;
    assign out1 = (sel == 1'b1) ? data_in : 1'b0;

endmodule


//1:2 DEMUX Testbench (demux_1to2_tb.v)

module demux_1to2_tb;

    reg data_in;
    reg sel;
    wire out0, out1;
    
    demux_1to2 dut (
        .data_in(data_in),
        .sel(sel),
        .out0(out0),
        .out1(out1)
    );
    
    initial begin
        $dumpfile("demux_1to2_tb.vcd");
        $dumpvars(0, demux_1to2_tb);
        data_in = 0;
        sel = 0;
       

        // Test cases
        #5 data_in = 1; sel = 0;
        #5 sel = 1;
        #5 data_in = 0;
        #5 sel = 0;
        #5 data_in = 1; sel = 1;
        #5 data_in = 0;
        #5 sel = 0; 

        #10 $finish;
    end

    initial begin
      $monitor("TIME=%0t: DATA_IN=%b, SEL=%b -> OUT0=%b, OUT1=%b", $time, data_in, sel, out0, out1);
    end

endmodule
