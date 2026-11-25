`timescale 1ns / 1ps

module mod36_16seg_fsm_tb;
    // Testbench signals
    logic        clk;
    logic        rst_n;
    logic [5:0]  state_q;
    logic [15:0] segs;

    // Character lookup mapping for console printing
    string char_map [36] = '{
        "0","1","2","3","4","5","6","7","8","9",
        "A","B","C","D","E","F","G","H","I","J",
        "K","L","M","N","O","P","Q","R","S","T",
        "U","V","W","X","Y","Z"
    };

    // Instantiate DUT
    mod36_16seg_fsm dut (
        .clk(clk),
        .rst_n(rst_n),
        .state_q(state_q),
        .segs(segs)
    );

    // Generate Clock: 10ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;

        // Apply Reset
        #15;
        rst_n = 1;
        $display("-------------------------------------------------------------");
        $display("Time(ns) | State (Bin) | Dec | Char | Segments [a1..n]      ");
        $display("-------------------------------------------------------------");

        // Run simulation for 45 clock cycles
        repeat (45) begin
            @(posedge clk);
            #1;
            $display("%0t      | %0b     | %2d  |  %s   | 16'b%0b", 
                     $time, state_q, state_q, char_map[state_q], segs);
        end

        $display("Simulation completed successfully.");
        $finish;
    end

endmodule