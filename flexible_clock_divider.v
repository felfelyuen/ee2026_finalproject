`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 22:21:18
// Design Name: 
// Module Name: flexible_clock_divider
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


module flexible_clock_divider(
    input basys_clk,
    input [31:0] m,
    output reg slow_clk
    );
    
    reg [31:0] COUNT;
        
    initial begin
        COUNT = 0;
        slow_clk = 1;
    end
    
    always @ (posedge basys_clk) begin
        COUNT <= ( COUNT == m ) ? 0 : COUNT + 1;
        slow_clk <= ( COUNT == m ) ? ~slow_clk : slow_clk;
    end
endmodule
