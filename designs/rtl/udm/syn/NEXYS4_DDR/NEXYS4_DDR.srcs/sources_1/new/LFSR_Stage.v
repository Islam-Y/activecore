`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 19:44:20
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
input logic clk,
input logic rst,
input logic [31:0] in_state,
output logic [31:0] out_state
);
logic feedback;

always_ff @(posedge clk or posedge rst) begin
if (rst) begin
out_state <= in_state;
end else begin
feedback <= in_state[31] ^ in_state[30] ^
in_state[29] ^ in_state[27] ^
in_state[25] ^ in_state[0];
out_state <= {feedback, in_state[31:1]};
end
end

endmodule
