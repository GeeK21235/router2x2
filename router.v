`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2023 10:39:05 PM
// Design Name: 
// Module Name: router
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



module router(
    input wire clk,
    input wire reset_n,
    input wire [1:0] din,
    input wire [1:0] frame_n,
    input wire [1:0] valid_n,
    output [1:0] busy_n,
    output [1:0] dout,
    output [1:0] frameo_n,
    output [1:0] valido_n
);

    reg des0;
    reg des1;
    reg done0;
    reg done1;
    reg firstbit0;
    reg firstbit1;

    always @(posedge clk) begin
        if (~reset_n) begin
            firstbit0 = 1'b0;
            firstbit1 = 1'b0;
            done0 = 1'b0;
            done1 = 1'b0;
        end
        else begin
            if (~frame_n[0]) 
            begin
                if ((!firstbit0) && (done0==0)) 
                begin
                    des0 = din[0];
                    firstbit0 = 1;
                end
                else 
                begin
                    firstbit0 = 0;
                    done0 = 1'b1;
                end
            end
            else 
            begin
                done0 = 1'b0;
            end

            if (~frame_n[1]) 
            begin
                if ((!firstbit1) && (done1==0)) 
                begin
                    des1 = din[1];
                    firstbit1 = 1;
                end
                else 
                begin
                    firstbit1 = 0;
                    done1 = 1;
                end
            end
            else 
            begin
                done1 = 1'b0;
            end
        end
    end

    fixed_priority fix(.des0(des0),
                       .des1(des1),
                       .done0(done0),
                       .done1(done1),
                       .busy_n(busy_n),
                       .frame_n(frame_n),
                       .valid_n(valid_n),
                       .din(din),
                       .dout(dout),
                       .frameo_n(frameo_n),
                       .valido_n(valido_n)
                       );
endmodule

