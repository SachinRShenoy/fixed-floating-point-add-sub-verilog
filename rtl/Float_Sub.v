`timescale 1ns / 1ps
module Float_Sub (
    input  [31:0] A,
    input  [31:0] B,
    output [31:0] Diff
);
    wire [31:0] B_neg = {~B[31], B[30:0]};
    Float_Add ADD (A, B_neg, Diff);
endmodule
