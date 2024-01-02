`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2023 09:25:34 PM
// Design Name: 
// Module Name: fixed_priority
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


module fixed_priority(
    input wire des0,
    input wire des1,
    input wire done0,
    input wire done1,
    input wire [1:0] frame_n,
    input wire [1:0] valid_n,
    input wire [1:0] din,
    output reg [1:0] busy_n,
    output reg [1:0] dout,
    output reg [1:0] frameo_n,
    output reg [1:0] valido_n
);
////gán assign
//assign busy_n[da_0] = (da_0 != da_1) ? (done0 ? 1'b0 : busy_n[da_0]) : (done0 ? 1'b0 : busy_n[da_0]);
//assign busy_n[da_1] = (da_0 != da_1) ? (done1 ? 1'b0 : busy_n[da_1]) : (done1 ? 1'b0 : busy_n[da_1]);

//assign frameo_n[da_0] = (da_0 != da_1) ? frame_n[0] : frame_n[0];
//assign frameo_n[da_1] = (da_0 != da_1) ? frame_n[1] : frame_n[1];

//assign valido_n[da_0] = (da_0 != da_1) ? valid_n[0] : valid_n[0];
//assign valido_n[da_1] = (da_0 != da_1) ? valid_n[1] : valid_n[1];

//assign dout[da_0] = (da_0 != da_1) ? (done0 ? (valid_n[0] ? 1'bx : din[0]) : 1'bx) : (done0 ? (valid_n[0] ? 1'bx : din[0]) : 1'bx);
//assign dout[da_1] = (da_0 != da_1) ? (done1 ? (valid_n[1] ? 1'bx : din[1]) : 1'bx) : (done1 ? (valid_n[1] ? 1'bx : din[1]) : 1'bx);

////
always @(*) begin
    if (des0 != des1) begin
        if (done0) begin
            busy_n[des0] = 1'b0;
            frameo_n[des0] = frame_n[0];
            valido_n[des0] = valid_n[0];
            if (~valid_n[0]) begin
                dout[des0] = din[0];
            end
            else dout[des0] = 1'bx;
        end
        else begin
            dout[des0] = 1'bx;
        end

        if (done1) begin
            busy_n[des1] = 1'b0;
            frameo_n[des1] = frame_n[1];
            valido_n[des1] = valid_n[1];
            if (~valid_n[1]) begin
                dout[des1] = din[1];
            end
            else dout[des1] = 1'bx;
        end
        else begin
            dout[des1] = 1'bx;
        end
    end
    else begin
        if (done0) begin
            busy_n[des0] = 1'b0;
            frameo_n[des0] = frame_n[0];
            valido_n[des0] = valid_n[0];
            if (~valid_n[0]) begin
                dout[des0] = din[0];
            end
            else dout[des0] = 1'bx;
        end
        else begin
            dout[des0] = 1'bx;
        end

        if (done1) begin
            busy_n[~des1] = 1'b0;
            frameo_n[~des1] = frame_n[1];
            valido_n[~des1] = valid_n[1];
            if (~valid_n[1]) begin
                dout[~des1] = din[1];
            end
            else dout[~des1] = 1'bx;
        end
        else begin
            dout[~des1] = 1'bx;
        end
    end
end

endmodule