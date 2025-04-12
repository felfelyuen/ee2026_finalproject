`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 08:54:04 PM
// Design Name: 
// Module Name: button_handler_two
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


module button_handler_two(
    input CLK, //use a 5HZ clock
    input RESET,
    input UPbtn,
    input DOWNbtn,
    input RIGHTbtn,
    input LEFTbtn,
    input CTRLbtn,
    input [7:0] count,
    input [197:0] mazestate,
    input [7:0] begin_spot,
    input game_pause,
    output reg [7:0] next_count
    );
    
    initial begin
    next_count = 181;
    end
    
    always @(posedge CLK) begin 
        if (game_pause == 0) begin
        end else
        if (RESET == 0) begin
            next_count = 181;
        end else
        if (next_count == 255 & CTRLbtn) begin
            next_count = begin_spot;
        end else
        if (UPbtn) begin
            next_count = count - 18;
        end 
        else if (DOWNbtn) begin
            next_count = count + 18;
        end
        else if (RIGHTbtn) begin
            next_count = count + 1;
        end
        else if (LEFTbtn) begin
            next_count = count - 1;
        end
        
        //else if (CTRLbtn) begin
        //next_count = count;
        //end
        
        
        
        if (mazestate[next_count] == 0) begin
        //set next_count to 255 if we hit the wall
            next_count = 255;
        end
        
    end
endmodule