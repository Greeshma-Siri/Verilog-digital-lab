module bcd_adder (
    input [3:0] a, b,
    output reg [3:0] sum,
    output reg carry
);
    wire [4:0] binary_sum;
    
    assign binary_sum = a + b;
    
    always @(*) begin
        if (binary_sum > 9) begin
            sum = binary_sum + 6;
            carry = 1'b1;
        end else begin
            sum = binary_sum[3:0];
            carry = 1'b0;
        end
    end
endmodule

module tb_bcd;
    reg [3:0] a, b;
    wire [3:0] sum;
    wire carry;
    
    bcd_adder uut (.a(a), .b(b), .sum(sum), .carry(carry));
    
    initial begin
        
        a=0; b=0; #10 $display("a:%d b:%d |  sum:%d    carry:%b", a, b, sum, carry);
        a=1; b=2; #10 $display("a:%d b:%d |  sum:%d    carry:%b", a, b, sum, carry);
        a=5; b=5; #10 $display("a:%d b:%d |  sum:%d    carry:%b", a, b, sum, carry);
        a=9; b=1; #10 $display("a:%d b:%d |  sum:%d    carry:%b", a, b, sum, carry);
        a=9; b=9; #10 $display("a:%d b:%d |  sum:%d    carry:%b", a, b, sum, carry);
        
        $finish;
    end
endmodule
