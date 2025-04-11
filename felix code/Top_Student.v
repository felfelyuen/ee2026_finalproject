`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2025 05:39:12 PM
// Design Name: 
// Module Name: Top_Student
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


module Top_Student(
    input basys_clock,
    input [4:0] pb,
    input [2:0] sw,
    output [7:0] JB
);

wire [15:0] oled_data; 
wire fb; wire [12:0] pi; wire sendp; wire samplep; wire SLOWCLK_6_25MHZ; 

flexible_clock_divider clock6_25MHZ (basys_clock, 4'b0111, SLOWCLK_6_25MHZ);

Oled_Display oleddd (
    .clk(SLOWCLK_6_25MHZ), 
    .reset(0), 
    .frame_begin(fb), 
    .sending_pixels(sendp), 
    .sample_pixel(samplep), 
    .pixel_index(pi), 
    .pixel_data(oled_data), 
    .cs(JB[0]), 
    .sdin(JB[1]), 
    .sclk(JB[3]), 
    .d_cn(JB[4]), 
    .resn(JB[5]), 
    .vccen(JB[6]),
    .pmoden(JB[7]));
  
wire [9:0] x; wire [6:0] y;
coord_system coordinates (pi, x, y);
wire [2:0] wire_to_cut; wire curr_colour;
//curr_colour from isaac, wire_to_cut to ryan

maze mazee (basys_clock, pb, x, y, sw, curr_colour, oled_data, wire_to_cut);

endmodule
