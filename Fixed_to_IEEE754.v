`timescale 1ns / 1ps
module Fixed_to_IEEE754 #(
    parameter WIDTH = 16,
    parameter FBITS = 8
)(
    input  [WIDTH-1:0] fixed_in,
    output reg [31:0]  float_out
);
    integer i;
    reg sign;
    reg [7:0] exponent;
    reg [22:0] mantissa;
    reg [31:0] abs_val;
    reg [5:0] leading_one;

    always @(*) begin
        float_out   = 32'b0;
        sign        = fixed_in[WIDTH-1];
        abs_val     = sign ? -fixed_in : fixed_in;
        leading_one = 0;

        if (abs_val != 0) begin
            for (i = WIDTH-1; i >= 0; i = i - 1)
                if (abs_val[i] && leading_one == 0)
                    leading_one = i;

            exponent = leading_one - FBITS + 127;

            if (leading_one > 23)
                abs_val = abs_val >> (leading_one - 23);
            else
                abs_val = abs_val << (23 - leading_one);

            mantissa  = abs_val[22:0];
            float_out = {sign, exponent, mantissa};
        end
    end
endmodule
