/*
 * tb.v
 *
 *  Created on: 17.10.2019
 *      Author: Alexander Antonov <antonov.alex.alex@gmail.com>
 *     License: See LICENSE file for details
 */




`timescale 1ns / 1ps

`define HALF_PERIOD			5						//external 100 MHZ
`define DIVIDER_115200		32'd8680
`define DIVIDER_19200		32'd52083
`define DIVIDER_9600		32'd104166
`define DIVIDER_4800		32'd208333
`define DIVIDER_2400		32'd416666


module tb ();
    logic clk;
    logic rst;
    logic [31:0] seed;
    logic [31:0] lfsr_out;
	
	LFSR_Comb dut (
        .clk(clk),        
        .rst(rst),       
        .seed(seed),
        .lfsr_out(lfsr_out)
        );
               
        
      
  initial begin
        clk = 0;
        forever #5 clk = ~clk;  // ?????? = 10 ?????? ???????
    end

    // ???????? ????????
    initial begin
        // ?????????????
        rst = 1;
        seed = 32'h1234FADC; // ????????? ?????????? ????????

        // ?????
        #10 rst = 0;


        // ?????????? ?? ????????????
//        #350; // ????, ???? ?????????? ??????????
        #750; // ????, ???? ?????????? ??????????
        $finish;
    end

    // ?????????? ????? ????????
    always @(posedge clk) begin
       $monitor("At time %0t: LFSR Output = %h", $time, lfsr_out);
    end
	
	// ?????????????? ????? ????????? ??? ???????
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : debug_state
            always @(posedge clk) begin
                $display("At time %0t: State[%0d] = %h", $time, i, dut.state[i]);
            end
        end
    endgenerate
	
	
	
	
// The object of LFSR, lab2
//LFSR_Comb lfsr_inst (
//    .clk(clk),       // Connect the clock signal to the LFSR module
//    .rst(rst),       // Connect the reset signal to the LFSR module
//    .seed(seed),     // Pass the seed value to initialize the LFSR
//    .lfsr_out(lfsr_out) // Output the final LFSR value
//);

//  // Clock generation logic
//  initial begin
//      clk = 0;
//      forever #5 clk = ~clk;  // Clock period = 10 time units
//  end

//  // Testbench stimulus
//  initial begin
//      // Initialization
//      rst = 1;                   // Assert reset
//      seed = 32'h1234FADC;       // Set the seed value for the LFSR

//      // Start simulation
//      #10 rst = 0;               // De-assert reset after 10 time units

//      // Run the simulation for a sufficient time
//      #350; // Wait for the LFSR to complete a few cycles
//      $finish; // End the simulation
//  end

//  // Display LFSR state and debug information at every positive clock edge
//  always @(posedge clk) begin
//      $display("Time: %0t | Counter: %0d | Feedback: %b | Current State: %h | LFSR Output: %h",
//               $time, lfsr_inst.counter, lfsr_inst.feedback, lfsr_inst.current_state, lfsr_out);
//  end
  
  

// Combination logic (Optional for additional tests)
// initial begin
//     seed = 32'b11111111111111111111111111111111; // Example seed values
//     #10;
//end

endmodule

// Example seed values:
// seed = 0x00000001; // Binary: 00000000000000000000000000000001
// seed = 0xFFFFFFFF; // Binary: 11111111111111111111111111111111
// seed = 0x1234FADC; // Binary: 00010010001101001111101011011100
// seed = 0xDEADBEEF; // Binary: 11011110101011011011111011101111

// Expected LFSR output (example outputs for specific seeds):
// lfsr_out = 0x5D9FAD13; // Binary: 1011101100111111010110100010011
// lfsr_out = 0x348A9B0E; // Binary: 110100100010101001101100001110
// lfsr_out = 0xC089F109; // Binary: 11000000100010011111000100001001
// lfsr_out = 0xD7545151; // Binary: 11010111010101000101000101010001









/*
 * tb.v
 *
 *  Created on: 17.10.2019
 *      Author: Alexander Antonov <antonov.alex.alex@gmail.com>
 *     License: See LICENSE file for details
 */

/*
`timescale 1ns / 1ps

`define HALF_PERIOD			5						//external 100 MHZ
`define DIVIDER_115200		32'd8680
`define DIVIDER_19200		32'd52083
`define DIVIDER_9600		32'd104166
`define DIVIDER_4800		32'd208333
`define DIVIDER_2400		32'd416666


module tb ();
//
logic CLK_100MHZ, RST, rx;
logic [15:0] SW;
logic [15:0] LED;

logic [31:0] seed;
logic [31:0] lfsr_out;
logic clk_gen;
logic srst;

always #`HALF_PERIOD CLK_100MHZ = ~CLK_100MHZ;

always #1000 SW = SW + 8'h1;
	
NEXYS4_DDR
#(
	.SIM("YES")
) DUT (
	.CLK100MHZ(CLK_100MHZ)
    , .CPU_RESETN(!RST)
    
    , .SW(SW)
    , .LED(LED)

    , .UART_TXD_IN(rx)
    , .UART_RXD_OUT()
);

LFSR_Comb mod(
    .seed(seed),
    .lfsr_out(lfsr_out),
    .clk(clk_gen),
    .rst(srst)
);

////reset all////
task RESET_ALL ();
    begin
    CLK_100MHZ = 1'b0;
    RST = 1'b1;
    rx = 1'b1;
    #(`HALF_PERIOD/2);
    RST = 1;
    #(`HALF_PERIOD*6);
    RST = 0;
    while (DUT.srst) WAIT(10);
    end
endtask

////wait////
task WAIT
    (
     input logic [15:0] periods
     );
    begin
    integer i;
    for (i=0; i<periods; i=i+1)
        begin
        #(`HALF_PERIOD*2);
        end
    end
endtask

`define UDM_RX_SIGNAL rx
`define UDM_BLOCK DUT.udm
`include "udm.svh"
udm_driver udm = new();

/////////////////////////
// main test procedure //
localparam CSR_LED_ADDR         = 32'h00000000;
localparam CSR_SW_ADDR          = 32'h00000004;
localparam INPUT_ADDR           = 32'h00000008;
localparam OUTPUT_ADDR          = 32'h0000000C;
localparam TESTMEM_ADDR         = 32'h80000000;

initial
    begin
    logic [31:0] wrdata [];
    integer ARRSIZE=10;
  //  logic lfsr_out;  //a variable for storing the result from OUTPUT_ADDR
    
	$display ("### SIMULATION STARTED ###");
	
	SW = 8'h30;
	RESET_ALL();
	WAIT(100);

	udm.cfg(`DIVIDER_115200, 2'b00);
	udm.check();
	udm.hreset();
	WAIT(100);
	
	// memory initialization
	udm.wr32(32'h80000000, 32'h112233cc);
	udm.wr32(32'h80000004, 32'h55aa55aa);
	udm.wr32(32'h80000008, 32'h01010202);
	udm.wr32(32'h8000000C, 32'h44556677);
	udm.wr32(32'h80000010, 32'h00000003);
	udm.wr32(32'h80000014, 32'h00000004);
	udm.wr32(32'h80000018, 32'h00000005);
	udm.wr32(32'h8000001C, 32'h00000006);
	udm.wr32(32'h80000020, 32'h00000007);
	udm.wr32(32'h80000024, 32'hdeadbeef);
	udm.wr32(32'h80000028, 32'hfefe8800);
	udm.wr32(32'h8000002C, 32'h23344556);
	udm.wr32(32'h80000030, 32'h05050505);
	udm.wr32(32'h80000034, 32'h07070707);
	udm.wr32(32'h80000038, 32'h99999999);
	udm.wr32(32'h8000003C, 32'hbadc0ffe);
	
	WAIT(100);
	
 // Writing initial data to INPUT_ADDRESS
    $display("### Writing seed to INPUT_ADDR ###");
    udm.wr32(INPUT_ADDR, 32'h1234FADC); // Example of the seed value

    // Additional waiting
    WAIT(50);
    
    // Reading the result from OUTPUT_ADDRESS
    $display("### Reading result from OUTPUT_ADDR ###");
    udm.rd32(OUTPUT_ADDR);

    $display("LFSR output: 0x%h", OUTPUT_ADDR);
    
    WAIT(1000);

    $display ("### TEST PROCEDURE FINISHED ###");
    $stop;
    end
endmodule
*/