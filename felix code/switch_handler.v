`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 08:51:54 PM
// Design Name: 
// Module Name: switch_handler
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


module switch_handler(
    input CLK,
    input SW1,
    input SW2,
    input SW3, 
    input [6:0] x,
    input [5:0] y,
    output reg [15:0] olede 
    );
    
    always @(posedge CLK) begin
        if (SW1) begin
            if (x < 32) begin
                olede = 16'hFFFF;
            end
            else begin
                olede = 16'h0000;
            end
        end 
        else if (SW2) begin
            if (x > 31 & x < 64) begin
                olede = 16'hFFFF;
            end 
            else begin
                olede = 16'h0000;
            end
        end
        else if (SW3) begin
            if (x > 63) begin
                olede = 16'hFFFF;
            end
            else begin
                olede = 16'h0000;
            end
        end 
        else begin
        olede = 16'h0000;
        end
    end
endmodule
