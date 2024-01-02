`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2023 06:09:31 AM
// Design Name: 
// Module Name: router_test_top
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

interface router_io(input bit clk);
    logic [1:0]din;
    logic [1:0]dout;
    logic [1:0]frame_n;
    logic [1:0]frameo_n;
    logic [1:0]valid_n;
    logic [1:0]valido_n;
    logic reset_n;
    clocking cb @(posedge clk);
    input frameo_n,valido_n,dout;
    output din,valid_n,frame_n;
    output reset_n;
    endclocking
    modport TB (clocking cb,output reset_n);
endinterface
module router_test_top(
    
    );
    parameter simulation_cycle=10;
    bit SystemClock;
    initial
    begin
    SystemClock=0;
    forever #(simulation_cycle/2)SystemClock=~SystemClock;
    end
    router_io top_io(SystemClock); 
    router dut(.clk(SystemClock),
           .din(top_io.din),
           .frame_n(top_io.frame_n),
           .valid_n(top_io.valid_n),
           .dout(top_io.dout),
           .frameo_n(top_io.frameo_n),
           .valido_n(top_io.valido_n),
           .reset_n(top_io.reset_n));
    test test_program(top_io);
endmodule
program automatic test(router_io.TB rtr_io);
//Instance
bit sa;
bit da;
logic[7:0] payload[$];
//main program
initial 
    begin
        //reset
        reset();
        //send 21 packets
        for(int i=0;i<21;i++)
        begin
        gen();
        send();
        end
    end

task send();
    rtr_io.cb.frame_n[sa]<=0;
    send_addrs();
    send_pad();
    send_payload();
    rtr_io.cb.frame_n[sa]<=1;
    #30;
endtask: send

task reset();
#10
rtr_io.cb.din<=2'bxx;
rtr_io.cb.frame_n<=2'b11;
rtr_io.cb.valid_n<=2'b11;
rtr_io.cb.reset_n<=0;
#20 rtr_io.cb.reset_n<=1;
#130;

endtask: reset

task send_pad;
rtr_io.cb.valid_n[sa]<=1;
rtr_io.cb.din[sa]<=1;
#30;
endtask: send_pad

task send_payload();
    for(int i=0;i<payload.size();i++)
        begin
        rtr_io.cb.valid_n[sa]<=0;
        for(int k=7;k>=0;k--)
            begin
            
            rtr_io.cb.din[sa]<=payload[i][k];
            #10;
            end
        rtr_io.cb.valid_n[sa]<=1;
        #10;
        end
endtask: send_payload

task send_addrs();
rtr_io.cb.valid_n[sa]<=1'bx;
rtr_io.cb.din[sa]<=da;
#10;
endtask:send_addrs

task gen();
    sa = $urandom_range(0,1);
    da = $urandom_range(0,1);
    payload.delete();
    repeat($urandom_range(2,4))
        payload.push_back($urandom);
endtask:gen
endprogram