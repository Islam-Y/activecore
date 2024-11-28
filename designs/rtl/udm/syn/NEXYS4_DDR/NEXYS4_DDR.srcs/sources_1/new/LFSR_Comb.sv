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
//module LFSR_Comb (    
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
//The end of lab3



module LFSR_Comb (
    input logic clk,            // ???????? ??????
    input logic rst,            // ?????? ??????
    input logic [31:0] seed,    // ????????? ???????? ??? LFSR
    output logic [31:0] lfsr_out // ????????? LFSR ????? 32 ?????
);

    // ?????? ??? ???????? ????????? LFSR ?? ?????? ?????
    logic [31:0] state [0:32];  
    // ?????? ??? ???????? ???????? ?? ?????? ?????
    logic feedback [0:32];    

    // ???? 1: ????????????? ????????? ?? ?????? ?????
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state[0] <= seed;  // ????????? seed ? state[0]
            feedback[0] <= seed[31] ^ seed[30] ^ seed[29] ^ seed[27] ^ seed[25] ^ seed[0]; // ?????? ??????
        end else begin
            // ?????? ??? ??????? ????? (??????????? ?? ???????? ???????)
            feedback[0] <= state[0][31] ^ state[0][30] ^ state[0][29] ^ state[0][27] ^ state[0][25] ^ state[0][0];
            // ????? ????????? ??? ??????? ?????
            state[1] <= {feedback[0], state[0][31:1]};  // ????? ????????? ? ?????????? ???????
        end
    end

    // ????? 2 ? ?????: ????????? ????? ????????
    genvar i;
    generate
        for (i = 1; i < 31; i = i + 1) begin : pipeline_stage
            always_ff @(posedge clk or posedge rst) begin
                if (rst) begin
                    state[i] <= 32'b0;    // ????????????? ?? ??????
                    feedback[i] <= 0;     // ????????????? ???????
                end else begin
                    // ?????? ?? ??????? ???? (?????????? ??????? ?? ???????)
                    feedback[i] <= state[i][31] ^ state[i][30] ^ state[i][29] ^ state[i][27] ^ state[i][25] ^ state[i][0];
                    // ????? ????????? ?? ??????? ???? ? ?????????? ???????
                    state[i+1] <= {feedback[i], state[i][31:1]};
                end
            end
        end
    endgenerate

    // ????????? 32-? ????
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state[32] <= 32'b0;  // ????????????? ?? ??????
            feedback[32] <= 0;   // ????????????? ???????
        end else begin
            // ?????? ??? 32-?? ?????
            feedback[32] <= state[31][31] ^ state[31][30] ^ state[31][29] ^ state[31][27] ^ state[31][25] ^ state[31][0];
            // ????? ????????? ??? 32-?? ????? ? ?????????? ???????
            state[32] <= {feedback[32], state[31][31:1]};
        end
    end
    
    // ????????? ????: ?????????? ?????? ????????? ? ????? ??????????
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            lfsr_out <= 32'b0;  // ????????????? ?? ??????
        end else begin
            lfsr_out <= state[32];  // ????? ?????????? ????? 32 ?????
        end
    end

endmodule
