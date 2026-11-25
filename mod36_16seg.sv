module mod36_16seg_fsm (
    input  logic       clk,
    input  logic       rst_n,      // Active-low asynchronous reset
    output logic [5:0] state_q,    // Current 6-bit state (A to F)
    output logic [15:0] segs      
);

    // Internal next state logic 
    logic [5:0] state_next;

    always_comb begin
        if (state_q >= 6'd35) begin
            state_next = 6'd0;
        end else begin
            state_next = state_q + 6'd1;
        end
    end

    // D Flip-Flops
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q <= 6'd0;
        end else begin
            state_q <= state_next;
        end
    end

    // Unpack state bits for equations
    logic A, B, C, D, E, F;
    assign {A, B, C, D, E, F} = state_q;

    // Minimized SOP
    logic a1, a2, b, c, d1, d2, e, f, g1, g2, h, j, k, l, m, n;

    assign a1  = (C & ~E) | (~A & ~D & ~F) | (~B & D & E) | (~B & D & F) | (~D & E & F);
    assign a2  = a1; 
    assign b   = (C & ~D) | (~A & ~B & ~D) | (B & ~C & D & E) | (B & D & ~E & ~F) | (B & ~D & ~E & F) | (~B & C & ~E & F) | (~B & ~C & ~E & ~F);
    assign c   = (B & C & ~F) | (C & ~D & ~F) | (~D & ~E & ~F) | (~A & ~B & ~D & F) | (B & ~C & D & E) | (B & ~C & ~D & ~E) | (~B & C & ~E & F) | (~B & ~C & D & ~F);
    assign d1  = (B & ~D & ~F) | (C & D & ~F) | (C & ~E & ~F) | (~A & ~C & ~D & ~F) | (~B & D & E & ~F) | (~B & D & ~E & F) | (~B & ~D & E & F) | (~C & D & ~E & F) | (~C & ~D & E & F);
    assign d2  = (B & ~D & ~F) | (~B & C & ~E) | (C & D & ~F) | (C & ~E & ~F) | (~A & ~C & ~D & ~F) | (~B & D & E & ~F) | (~B & ~D & E & F) | (~C & D & ~E & F);
    assign e   = (B & C & ~D) | (B & ~C & D) | (B & ~D & ~E) | (~B & C & ~F) | (C & D & E) | (~D & ~E & ~F) | (~A & ~B & E & ~F) | (~C & D & ~E & F);
    assign f   = (C & ~F) | (D & ~F) | (~E & ~F) | (B & C & E) | (B & ~C & ~E) | (B & D & E) | (C & D & E) | (C & ~D & ~E);
    assign g1  = (~B & ~C & D) | (~B & D & E) | (~A & ~B & ~C & E) | (B & C & ~D & F) | (B & D & ~E & ~F) | (~B & C & ~D & ~F) | (~C & D & ~E & F) | (~B & D & ~E & F);
    assign g2  = (~A & ~B & E) | (~B & C & ~D) | (C & D & ~F) | (B & ~C & ~D & ~E) | (~B & ~C & D & ~F) | (B & C & D & ~E & ~F);
    assign h   = (A & E & ~F) | (A & ~E & F) | (B & C & ~D & E);
    assign j   = (B & ~C & ~D & E) | (C & D & ~E & F) | (~B & C & D & ~E & F);
    assign k   = (A & E) | (A & F) | (B & C & ~D & ~F) | (~B & ~C & D & F) | (~A & ~B & ~C & ~D & ~E) | (B & C & D & E & F);
    assign l   = (A & ~E) | (B & C & ~D & E) | (B & C & ~D & E & F) | (B & C & ~D & ~E & ~F);
    assign m   = (A & E & ~F) | (B & C & ~D & E) | (C & D & ~E & F) | (~B & C & D & ~E & F);
    assign n   = (A & F) | (B & C & D & E & F) | (~B & ~C & D & E & F) | (~B & ~C & ~D & ~E & ~F);

    // 16-bit output bus vector
    assign segs = {a1, a2, b, c, d1, d2, e, f, g1, g2, h, j, k, l, m, n};

endmodule