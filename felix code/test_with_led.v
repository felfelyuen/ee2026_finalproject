`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2025 03:53:36 PM
// Design Name: 
// Module Name: test_with_led
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


module test_with_led(
input CLK,
input [2:0] wire_to_cut,
output reg led

    );
    always @(posedge CLK) begin
    if (wire_to_cut == 3'b101) begin
    led = 1;
    end else begin
    led = 0;
    end
    end
endmodule
