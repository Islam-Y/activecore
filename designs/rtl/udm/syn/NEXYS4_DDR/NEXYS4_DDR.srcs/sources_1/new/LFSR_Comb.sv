//It's a lab2. Dont toach it
//module LFSR_Comb (
//    input wire [31:0] seed,
//    output wire [31:0] lfsr_out
//);

//    reg [31:0] temp_state;
//    integer i;
   
//   always @(*) 
//   begin
//    temp_state = seed; // initial value

//   for (i = 0; i < 32; i = i + 1) 
//     begin
//        temp_state = {((temp_state >> 31) ^ (temp_state >> 30) ^ (temp_state >> 29) ^ (temp_state >> 27) ^ (temp_state >> 25) ^ temp_state) & 1, temp_state[31:1]};
//     end
//   end

//// Assigning a result after 32 shifts
//assign lfsr_out = temp_state;

//endmodule
//The end of the lab2




//It's a lab3.
module LFSR_Comb (    
    input logic clk,            // Clock signal
    input logic rst,            // Reset signal (synchronous or asynchronous depending on system)
    input logic [31:0] seed,    // Initial seed value for the LFSR
    output reg [31:0] lfsr_out  // Output of the LFSR after the final state
);

    reg [31:0] current_state;   // Current state of the LFSR    
    reg [5:0] counter;          // Cycle counter (runs for 32 iterations)
    wire feedback;              // XOR feedback signal based on the polynomial

    // Polynomial: (32, 31, 30, 28, 26, 1)
    assign feedback = current_state[31] ^ current_state[30] ^ current_state[29] ^ current_state[27] ^ current_state[25] ^ current_state[0];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= seed;      // Initialize LFSR state with seed on reset
            lfsr_out <= 32'b0;         // Reset output to 0
            counter <= 0;              // Reset the counter
        end else if (counter < 32) begin
            current_state <= {feedback, current_state[31:1]};  // Shift LFSR with feedback
            counter <= counter + 1;                           // Increment the counter
        end
        lfsr_out <= current_state;       // Assign the final LFSR state to output
        $display("Time: %0t | Counter: %0d | Feedback: %b | Current State: %h | LFSR Output: %h", 
                 $time, counter, feedback, current_state, lfsr_out);
    end

endmodule

