`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2024 09:48:49 PM
// Design Name: 
// Module Name: LFSR_Pipeline
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module LFSR_Pipeline (
    input  logic         clk,       // Clock signal
    input  logic         rst,       // Reset signal
    input  logic [31:0]  seed,      // Initial value for LFSR
    output logic [31:0]  lfsr_out   // Output of LFSR after 32 steps
);

    logic [31:0] stage [0:32];

    assign stage[0] = seed;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : pipeline_stage
            LFSR_Stage stg (
                .clk(clk),
                .rst(rst),
                .in_stage(stage[i]),
                .out_stage(stage[i + 1])
            );
        end
    endgenerate

    assign lfsr_out = stage[32];

endmodule

