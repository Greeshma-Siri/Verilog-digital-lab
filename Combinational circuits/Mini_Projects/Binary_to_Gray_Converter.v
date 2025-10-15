module binary_to_gray (
    input [3:0] binary,
    output [3:0] gray
);
    assign gray[3] = binary[3];
    assign gray[2] = binary[3] ^ binary[2];
    assign gray[1] = binary[2] ^ binary[1];
    assign gray[0] = binary[1] ^ binary[0];
endmodule


module tb_binary_to_gray;
    reg [3:0] binary;
    wire [3:0] gray;
    
    binary_to_gray uut (.binary(binary), .gray(gray));
    
    initial begin
      $display("Binary -> Gray code Conversion");
      $monitor("Binary:%b\tGray Code:%b", binary, gray);
        // Test patterns
        binary = 4'b0000; #10;
        binary = 4'b0001; #10; 
        binary = 4'b0011; #10; 
        binary = 4'b0111; #10; 
        binary = 4'b1111; #10;
        binary = 4'b1010; #10; 
        binary = 4'b0101; #10; 
        
        $finish;
    end
endmodule
