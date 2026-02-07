`timescale 1ns / 1ps
module Fixed_floating (
    input  [3:0] SW,
    input  [1:0] KEY,      // ACTIVE-LOW
    output [6:0] HEX0, HEX1, HEX2, HEX3,
                 HEX4, HEX5, HEX6, HEX7
);

    // Q8.8 Fixed-point inputs
    wire [15:0] fixed_A = 16'h0680;  // 6.5
    wire [15:0] fixed_B = 16'h0240;  // 2.25

    // Fixed-point result
    wire [15:0] fixed_result;
    Fixed_Add_Sub FIXED (
        .A(fixed_A),
        .B(fixed_B),
        .add_sub(~KEY[1]),
        .Result(fixed_result)
    );

    // Floating-point path
    wire [31:0] float_A, float_B;
    wire [31:0] float_add, float_sub;

    Fixed_to_IEEE754 FA (fixed_A, float_A);
    Fixed_to_IEEE754 FB (fixed_B, float_B);

    Float_Add ADD (float_A, float_B, float_add);
    Float_Sub SUB (float_A, float_B, float_sub);

    reg [31:0] display_data;

    always @(*) begin
        if (SW[2] == 0)
            display_data = {16'b0, fixed_result};
        else if (!KEY[0])
            display_data = float_add;
        else if (!KEY[1])
            display_data = float_sub;
        else
            display_data = 32'b0;
    end

    hex7seg H0 (display_data[3:0],   HEX0);
    hex7seg H1 (display_data[7:4],   HEX1);
    hex7seg H2 (display_data[11:8],  HEX2);
    hex7seg H3 (display_data[15:12], HEX3);
    hex7seg H4 (display_data[19:16], HEX4);
    hex7seg H5 (display_data[23:20], HEX5);
    hex7seg H6 (display_data[27:24], HEX6);
    hex7seg H7 (display_data[31:28], HEX7);

endmodule

