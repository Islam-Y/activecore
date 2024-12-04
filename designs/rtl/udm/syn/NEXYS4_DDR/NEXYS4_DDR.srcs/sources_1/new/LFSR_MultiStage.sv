`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2024 09:58:21 PM
// Design Name: 
// Module Name: LFSR_MultiStage
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

    
//    module LFSR_MultiStage (    
//    input logic clk,            // Clock signal
//    input logic rst,            // Reset signal (synchronous or asynchronous depending on system)
//    input logic [31:0] seed,    // Initial seed value for the LFSR
//    output logic [31:0] lfsr_out  // Output of the LFSR after the final state
//);

//    logic [31:0] current_state;   // Current state of the LFSR    
//    logic [5:0] counter;          // Cycle counter (runs for 32 iterations)
//    logic feedback;              // XOR feedback signal based on the polynomial

//    // Polynomial: (32, 31, 30, 28, 26, 1)
//    assign feedback = current_state[31] ^ current_state[30] ^ current_state[29] ^ current_state[27] ^ current_state[25] ^ current_state[0];

//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            current_state <= seed;      // Initialize LFSR state with seed on reset
//            lfsr_out <= 32'b0;         // Reset output to 0
//            counter <= 0;              // Reset the counter
//        end else if (counter < 32) begin
//            current_state <= {feedback, current_state[31:1]};  // Shift LFSR with feedback
//            counter <= counter + 1;                           // Increment the counter
//        end
//        lfsr_out <= current_state;       // Assign the final LFSR state to output
//        $display("Time: %0t | Counter: %0d | Feedback: %b | Current State: %h | LFSR Output: %h", 
//                 $time, counter, feedback, current_state, lfsr_out);
//    end

//endmodule


module LFSR_MultiStage (    
    input logic clk,            // Clock signal
    input logic rst,            // Reset signal (synchronous or asynchronous depending on system)
    input logic [31:0] seed,    // Initial seed value for the LFSR
    output logic [31:0] lfsr_out  // Output of the LFSR after the final state
);

 logic [31:0] current_state;
    logic [31:0] next_state;
    logic feedback;
    logic [5:0] counter;

    LFSR_Core core (
        .clk(clk),
        .rst(rst),
        .current_state_in(current_state),
        .next_state(next_state),
        .feedback(feedback)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= seed;
            lfsr_out <= 32'b0;
            counter <= 0;
        end else if (counter < 32) begin
            current_state <= next_state;
            counter <= counter + 1;
        end else begin
            lfsr_out <= current_state;
        end
    end

endmodule
