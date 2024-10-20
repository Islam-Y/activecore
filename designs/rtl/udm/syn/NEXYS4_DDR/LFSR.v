`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2024 21:48:00
// Design Name: 
// Module Name: LFSR
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


module LFSR (
    input wire clk,
    input wire rst,
    input wire [31:0] seed,
    output reg [31:0] lfsr_out  // lfsr_out �������� ��� reg, ��� ��� �� ��������� ��� ������ always �����
);
reg [31:0] lfsr_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        lfsr_reg <= seed;  // ������������� ��� ������
        lfsr_out <= seed;  // ��������� lfsr_out ������ � lfsr_reg
    end else begin
        // ������� ��� LFSR (������: 32, 31, 30, 28, 26, 1)
        lfsr_reg <= {lfsr_reg[30:0], lfsr_reg[31] ^ lfsr_reg[30] ^ lfsr_reg[29] ^ lfsr_reg[27] ^ lfsr_reg[25] ^ lfsr_reg[0]};
        lfsr_out <= lfsr_reg;  // ��������� �������� ������� lfsr_out ������ ����
    end
end

endmodule




