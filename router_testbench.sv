`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2023 08:13:13 AM
// Design Name: 
// Module Name: router_testbench
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


module router_testbench();
    logic clk;
    logic reset_n;
    // input [1:0] addr_i,
    logic[1:0] din;
    logic[1:0] frame_n;
    logic[1:0] valid_n;
    logic[1:0] dout;
    logic[1:0] frameo_n;
    logic[1:0] valido_n;
 
    router r(
    .clk(clk),
    .reset_n(reset_n),
    .din(din),
    .frame_n(frame_n),
    .valid_n(valid_n),
    .dout(dout),
    .frameo_n(frameo_n),
    .valido_n(valido_n)
   
);
//    initial 
//    begin
//    clk = 0 ;
//    reset_n =1 ;
//    frame_n=2'b11;
//    valid_n=2'b11;
    
//    forever #10 clk = ~clk;
//    end
    
//    initial
//    fork
//    //assert reset
//    #31 reset_n=0;
//    //deassert reset
//    #52 reset_n=1;
//    //din port1 control
//    begin
//    #375;
//    #40 din[1]=1;
//    #20 din[1]=1'bx;
//    #20 din[1]=1'b0;
//    #20 din[1]=1'bx;
//    #20 din[1]=0;
//    #20 din[1]=1'bx;
//    #20 din[1]=1;
//    end
//    //din port0 control
//    begin
//    #375;
//    #40 din[0]=0;
//    #20 din[0]=1'bx;
//    #20 din[0]=1'b1;
//    #20 din[0]=1'bx;
//    #20 din[0]=1'b1;
//    #20 din[0]=1'bx;
//    #20 din[0]=0;
//    end
//    //valid_n port 1 control
//    begin
//    #375;
//    #80 valid_n[1]=0;
//    #20 valid_n[1]=1;
//    end
//    //valid_n port 0 control
//    begin
//    #375;
//    #80 valid_n[0]=0;
//    #20 valid_n[0]=1;
//    end
//    //frame_n port 1 control
//    begin
//    #375;
//    #40 frame_n[1]=0;
//    #60 frame_n[1]=1;
//    end
//    //frame_n port 0
//    begin
//    #375;
//    #40 frame_n[0]=0;
//    #60 frame_n[0]=1;
//    end
//    join
    initial
    begin
    clk=0;
    reset_n=1;
    forever #5 clk=~clk;
    end
    
    initial
    begin
    #5; 
    reset_n=0;
    frame_n=3;
    valid_n=3;
    #10; 
    reset_n=1;
    #80
    for(int n=0;n<100;n++)
        begin
        for(int i=1;i<4;i++)
            begin
            frame_n=0;
            din=i;
            #20;
            valid_n=0;
            din=$urandom_range(0,3);
            #10;
            valid_n=3;
            frame_n=3;
            #10;
            end
     end
    end
endmodule