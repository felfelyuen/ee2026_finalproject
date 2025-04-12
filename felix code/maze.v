
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2025 03:30:51 PM
// Design Name: 
// Module Name: maze
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

module maze(
    input CLK,
    input RESET,
    input [4:0] pb,
    input [6:0] x, 
    input [5:0] y,
    input sw1,
    input sw2,
    input sw3,
    input pausesw,
    input [2:0] curr_colour,
    output [15:0] oled_data,
    output [2:0] wire_to_cut
    );
    wire SLOWCLK_6_25MHZ; wire SLOWCLK_10HZ; 
    wire SLOWCLK_2kHZ;
    
    wire UPbtn; wire DOWNbtn; wire RIGHTbtn; wire LEFTbtn; wire CTRLbtn;
    
    reg [197:0] maze_state = 198'h00_0027_BBF9_2A8A_4EAE_90AA_26EA_F8E2_806E_BF90_A0A7_EFF8_0000;
    flexible_clock_divider clock6_25MHZ (CLK, 4'b0111, SLOWCLK_6_25MHZ);
    flexible_clock_divider clock10HZ (CLK, 23'h4C4B3F, SLOWCLK_10HZ);
    flexible_clock_divider clock2kHZ (CLK, 15'h61A7, SLOWCLK_2kHZ);
    
    wire [7:0] counter; wire [15:0] redsquare; wire [15:0] olede;
    wire [7:0] nextcounter; wire [15:0] switchh; wire [7:0] begin_spot;
    
    debouncer dbounceUP (pb[0], SLOWCLK_2kHZ, UPbtn);
    debouncer dbounceDOWN (pb[1], SLOWCLK_2kHZ, DOWNbtn);
    debouncer dbounceRIGHT (pb[3], SLOWCLK_2kHZ, RIGHTbtn);
    debouncer dbounceLEFT (pb[2], SLOWCLK_2kHZ, LEFTbtn);
    debouncer dbounceCTRL (pb[4], SLOWCLK_2kHZ, CTRLbtn);

    button_handler_two buttonner (SLOWCLK_10HZ, RESET, DOWNbtn, UPbtn, LEFTbtn, RIGHTbtn, CTRLbtn, counter, maze_state, begin_spot, pausesw, counter);

    move_red_square_two redmove (SLOWCLK_6_25MHZ, RESET, x, y, counter, maze_state, 3'b010, redsquare, wire_to_cut, begin_spot);
    switch_handler switcheroo (SLOWCLK_6_25MHZ, sw1, sw2, sw3, x, y, switchh);
    show_maze_two task2 (SLOWCLK_6_25MHZ, RESET, x, y, counter, maze_state, redsquare, switchh, olede);
    assign oled_data = olede;
    
endmodule
