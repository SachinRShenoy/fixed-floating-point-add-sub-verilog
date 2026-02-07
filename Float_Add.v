`timescale 1ns / 1ps
module Float_Add (
    input  [31:0] A,
    input  [31:0] B,
    output reg [31:0] Sum
);
    reg signA, signB, signR;
    reg [7:0] expA, expB, expR;
    reg [24:0] mantA, mantB, mantR;
    integer shift;

    always @(*) begin
        signA = A[31];
        signB = B[31];
        expA  = A[30:23];
        expB  = B[30:23];

        mantA = (expA == 0) ? {1'b0, A[22:0]} : {1'b1, A[22:0]};
        mantB = (expB == 0) ? {1'b0, B[22:0]} : {1'b1, B[22:0]};

        if (expA > expB) begin
            shift = expA - expB;
            mantB = mantB >> shift;
            expR  = expA;
        end else begin
            shift = expB - expA;
            mantA = mantA >> shift;
            expR  = expB;
        end

        if (signA == signB) begin
            mantR = mantA + mantB;
            signR = signA;
        end else begin
            if (mantA >= mantB) begin
                mantR = mantA - mantB;
                signR = signA;
            end else begin
                mantR = mantB - mantA;
                signR = signB;
            end
        end

        if (mantR[24]) begin
            mantR = mantR >> 1;
            expR  = expR + 1;
        end

        while (mantR[23] == 0 && expR > 0 && mantR != 0) begin
            mantR = mantR << 1;
            expR  = expR - 1;
        end

        if (mantR == 0)
            Sum = 32'b0;
        else
            Sum = {signR, expR, mantR[22:0]};
    end
endmodule
