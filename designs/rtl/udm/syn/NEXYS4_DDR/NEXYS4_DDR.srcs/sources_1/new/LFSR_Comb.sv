module LFSR_Comb (
    input logic [31:0] seed,
    output logic [31:0] lfsr_out
);

    logic [31:0] temp_state;
    integer i;
   
   always @(*) 
   begin
    temp_state = seed; // initial value

   for (i = 0; i < 32; i = i + 1) 
     begin
        temp_state = {((temp_state >> 31) ^ (temp_state >> 30) ^ (temp_state >> 29) ^ (temp_state >> 27) ^ (temp_state >> 25) ^ temp_state) & 1, temp_state[31:1]};
     end
   end

// Assigning a result after 32 shifts
assign lfsr_out = temp_state;

endmodule
