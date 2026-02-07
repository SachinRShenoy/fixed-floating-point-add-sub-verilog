`timescale 1ns / 1ps

module tb_FPGA_Fixed_Float_AddSub;

    // DUT inputs
    reg  [3:0] SW;
    reg  [1:0] KEY;

    // DUT outputs
    wire [6:0] HEX0, HEX1, HEX2, HEX3;
    wire [6:0] HEX4, HEX5, HEX6, HEX7;

    // Instantiate DUT
    FPGA_Fixed_Float_AddSub DUT (
        .SW(SW),
        .KEY(KEY),
        .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3),
        .HEX4(HEX4), .HEX5(HEX5), .HEX6(HEX6), .HEX7(HEX7)
    );

    // Utility task to print mode
    task print_mode;
        if (SW[2] == 0)
            $display("MODE : FIXED-POINT (Q8.8)");
        else
            $display("MODE : FLOATING-POINT (IEEE-754)");
    endtask

    initial begin
        $display("==============================================");
        $display(" FIXED & FLOATING POINT ADD/SUB TESTBENCH ");
        $display("==============================================");

        // Default idle
        SW  = 4'b0000;
        KEY = 2'b11;   // both inactive (active-low)
        #10;

        // ====================================================
        // FIXED-POINT ADDITION
        // ====================================================
        SW[2] = 0;     // FIXED mode
        KEY   = 2'b11;
        #5;
        print_mode();

        KEY[1] = 1'b1;   // ADD (add_sub = 0)
        #10;
        $display("FIXED ADD : A = 6.5 , B = 2.25  => Result = Q8.8 (HEX shown)");

        // ====================================================
        // FIXED-POINT SUBTRACTION
        // ====================================================
        KEY[1] = 1'b0;   // SUB
        #10;
        $display("FIXED SUB : A = 6.5 , B = 2.25  => Result = Q8.8 (HEX shown)");

        // ====================================================
        // FLOATING-POINT ADDITION
        // ====================================================
        SW[2] = 1;     // FLOAT mode
        KEY   = 2'b11;
        #5;
        print_mode();

        KEY[0] = 1'b0;   // ADD
        #10;
        $display("FLOAT ADD : 6.5 + 2.25 = 8.75 (IEEE-754 HEX)");

        // ====================================================
        // FLOATING-POINT SUBTRACTION
        // ====================================================
        KEY   = 2'b11;
        #5;
        KEY[1] = 1'b0;   // SUB
        #10;
        $display("FLOAT SUB : 6.5 - 2.25 = 4.25 (IEEE-754 HEX)");

        // ====================================================
        // END
        // ====================================================
        $display("==============================================");
        $display(" TEST COMPLETE ");
        $display("==============================================");

        $finish;
    end

endmodule
