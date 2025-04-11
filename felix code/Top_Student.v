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
    output [7:0] JA
);

    wire [15:0] oled_data_two; 
    wire SLOWCLK_6_25MHZ; 
    wire fb_two; wire [12:0] pi_two; wire sendp_two; wire samplep_two; wire SLOWCLK_6_25MHZ; 
//flexible_clock_divider clock6_25MHZ (basys_clock, 4'b0111, SLOWCLK_6_25MHZ);
    //we are using JA for the maze (or anything)
Oled_Display oleddd (
    .clk(SLOWCLK_6_25MHZ), 
    .reset(0), 
    .frame_begin(fb_two), 
    .sending_pixels(sendp_two), 
    .sample_pixel(samplep_two), 
    .pixel_index(pi_two), 
    .pixel_data(oled_data), 
    .cs(JA[0]), 
    .sdin(JA[1]), 
    .sclk(JA[3]), 
    .d_cn(JA[4]), 
    .resn(JA[5]), 
    .vccen(JA[6]),
    .pmoden(JA[7]));
  
    wire [6:0] x_two; wire [5:0] y_two;
    coord_system coordinates (pi_two, x_two, y_two);
wire [2:0] wire_to_cut; wire curr_colour;
//curr_colour from isaac, wire_to_cut to ryan

maze mazee (basys_clock, pb, x_two, y_two, sw, curr_colour, oled_data_two, wire_to_cut);

endmodule
