//`timescale 1ns / 1ps

//module mod_tb;

//reg [31:0] in, out;
//  //reg clk;
//    //reg rst;
//   // reg load_seed;


//LFSR_Comb mod(
//   // .clk(clk),
//   // .rst(rst),
//    //.load_seed(load_seed),
//    .seed(in),
//    .lfsr_out(out)
//);

//initial begin
//     //clk = 0;
//      //  rst = 1;
//       // load_seed = 0;
//    in = 32'hffffffff;
//       // #5 rst = 0;           // Сброс снят

//        //#10 load_seed = 1;    // Загрузка начального seed
//        //#10 load_seed = 0;    // Остановка загрузки

//        // Ожидание генерации нескольких значений
//        //#100;
//    #10

//    $display("%b", out); 
//    $stop;
//end

//endmodule




`timescale 1ns / 1ps

module tb_LFSR_Comb;

    reg [31:0] seed;
    reg [31:0] lfsr_out;

    // ??????????? ???????????? ??????
    LFSR_Comb uut (
        .seed(seed),
        .lfsr_out(lfsr_out)
    );

    initial begin
        // ???? 1
        seed = 32'h00000001;
        #10;
        $display("Test 1: seed = %h, lfsr_out = %h", seed, lfsr_out);

        
        if (lfsr_out !== {seed[30:0], seed[31] ^ seed[30] ^ seed[29] ^ seed[27] ^ seed[25] ^ seed[0]})
            $display("Error in Test 1!");

        // ???? 2
        seed = 32'hfffffff;
        #10;
        $display("Test 2: seed = %h, lfsr_out = %h", seed, lfsr_out);

        if (lfsr_out !== {seed[30:0], seed[31] ^ seed[30] ^ seed[29] ^ seed[27] ^ seed[25] ^ seed[0]})
            $display("Error in Test 2!");

        // ???? 3
        seed = 32'h1234fadc;
        #10;
        $display("Test 3: seed = %h, lfsr_out = %h", seed, lfsr_out);

        if (lfsr_out !== {seed[30:0], seed[31] ^ seed[30] ^ seed[29] ^ seed[27] ^ seed[25] ^ seed[0]})
            $display("Error in Test 3!");

        // ???? 4
        seed = 32'hdeadbeef;
        #10;
        $display("Test 4: seed = %h, lfsr_out = %h", seed, lfsr_out);

        if (lfsr_out !== {seed[30:0], seed[31] ^ seed[30] ^ seed[29] ^ seed[27] ^ seed[25] ^ seed[0]})
            $display("Error in Test 4!");

        // ???? ????????
        $display("All tests completed.");
        $stop;
    end
endmodule
