`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 19:58:46
// Design Name: 
// Module Name: LFSR_Stage
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


module LFSR_Stage (
    input  logic         clk,        // Clock signal
    input  logic         rst,        // Reset signal
    input  logic [31:0]  in_stage,   // Input to the stage
    output logic [31:0]  out_stage   // Output of the stage after feedback and shift
);

    logic feedback;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            out_stage <= in_stage;
        end else begin
            feedback <= in_stage[31] ^ in_stage[30] ^ 
                        in_stage[29] ^ in_stage[27] ^ 
                        in_stage[25] ^ in_stage[0];
            out_stage <= {feedback, in_stage[31:1]};  // Feedback is added to the leftmost bit
        end
    end

endmodule
