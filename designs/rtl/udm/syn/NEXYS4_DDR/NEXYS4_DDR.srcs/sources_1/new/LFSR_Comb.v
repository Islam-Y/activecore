module LFSR_Comb (
    input wire [31:0] seed,
    output wire [31:0] lfsr_out
);

assign lfsr_out = {seed[30:0], seed[31] ^ seed[30] ^ seed[29] ^ seed[27] ^ seed[25] ^ seed[0]};

endmodule