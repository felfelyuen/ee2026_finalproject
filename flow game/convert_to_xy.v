`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 22:23:45
// Design Name: 
// Module Name: convert_to_xy
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


module convert_to_xy(
    input [12:0] pixel_index,
    output [6:0] x,
    output [5:0] y
    );
    
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
endmodule
