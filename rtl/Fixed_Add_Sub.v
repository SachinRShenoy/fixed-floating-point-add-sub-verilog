`timescale 1ns / 1ps
module Fixed_Add_Sub (
    input  [15:0] A,
    input  [15:0] B,
    input         add_sub,   // 0 = ADD, 1 = SUB
    output reg [15:0] Result
);
    always @(*) begin
        if (add_sub == 1'b0)
            Result = A + B;
        else
            Result = A - B;
    end
endmodule
