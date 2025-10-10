module alu (
    input [31:0] a, b,
    input [3:0] opcode,
    output reg [31:0] result,
    output reg zero, carry
);
    
    parameter ADD  = 4'b0000;
    parameter SUB  = 4'b0001;
    parameter AND  = 4'b0010;
    parameter OR   = 4'b0011;
    parameter XOR  = 4'b0100;
    parameter NOT  = 4'b0101;
    parameter SLL  = 4'b0110;  // Shift Left Logical
    parameter SRL  = 4'b0111;  // Shift Right Logical
    
    always @(*) begin
        carry = 0;
        case(opcode)
            ADD: {carry, result} = a + b;
            SUB: result = a - b;
            AND: result = a & b;
            OR:  result = a | b;
            XOR: result = a ^ b;
            NOT: result = ~a;
            SLL: result = a << b[4:0];
            SRL: result = a >> b[4:0];
            default: result = 0;
        endcase
        zero = (result == 0);
    end
endmodule

module tb_alu;

    reg [31:0] a, b;
    reg [3:0] opcode;
    wire [31:0] result;
    wire zero, carry;
    
    alu uut (.a(a), .b(b), .opcode(opcode), .result(result), .zero(zero), .carry(carry));

    parameter ADD  = 4'b0000;
    parameter SUB  = 4'b0001;
    parameter AND  = 4'b0010;
    parameter OR   = 4'b0011;
    parameter XOR  = 4'b0100;
    parameter NOT  = 4'b0101;
    parameter SLL  = 4'b0110;
    parameter SRL  = 4'b0111;
    
    initial begin
        
        // Quick tests
      #10; a=10; b=5; opcode=ADD;  #10 $display("%0t\tADD\t%d\t%d\t  result-%d\tzero-%b\tcarry-%b", $time, a, b, result, zero, carry);
      #10; a=10; b=5; opcode=SUB;  #10 $display("%0t\tSUB\t%d\t%d\t  result-%d\tzero-%b\tcarry-%b", $time, a, b, result, zero, carry);
      #10; a=10; b=5; opcode=AND;  #10 $display("%0t\tAND\t%d\t%d\t  result-%d\tzero-%b\tcarry-%b", $time, a, b, result, zero, carry);
      #10; a=10; b=5; opcode=OR;  #10 $display("%0t\tOR \t%d\t%d\t  result-%d\tzero-%b\tcarry-%b", $time, a, b, result, zero, carry);
      #10; a=10; b=5; opcode=XOR;  #10 $display("%0t\tXOR\t%d\t%d\t  result-%d\tzero-%b\tcarry-%b", $time, a, b, result, zero, carry);
      #10; a=10; b=0; opcode=NOT;  #10 $display("%0t\tNOT\t%d\t%d\t  result-%d\tzero-%b\tcarry-%b", $time, a, b, result, zero, carry);
      #10; a=10; b=1; opcode=SLL;  #10 $display("%0t\tSLL\t%d\t%d\t  result-%d\tzero-%b\tcarry-%b", $time, a, b, result, zero, carry);
      #10; a=10; b=1; opcode=SRL;  #10 $display("%0t\tSRL\t%d\t%d\t  result-%d\tzero-%b\tcarry-%b", $time, a, b, result, zero, carry);
      
      
        
        $finish;
    end

endmodule
