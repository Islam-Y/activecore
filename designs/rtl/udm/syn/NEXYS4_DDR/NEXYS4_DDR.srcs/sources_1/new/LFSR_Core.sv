`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 05:27:59 PM
// Design Name: 
// Module Name: LFSR_Core
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


module LFSR_Core(
    input logic clk,
    input logic rst,
    input logic [31:0] current_state_in,
    output logic [31:0] next_state,
    output logic feedback
);
    // Polynomial: (32, 31, 30, 28, 26, 1)
    assign feedback = current_state_in[31] ^ current_state_in[30] ^ current_state_in[29] ^ current_state_in[27] ^ current_state_in[25] ^ current_state_in[0];
    assign next_state = {feedback, current_state_in[31:1]};

endmodule