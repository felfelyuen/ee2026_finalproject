`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 09:31:05 PM
// Design Name: 
// Module Name: move_red_square_two
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


module move_red_square_two(
    input CLK, //use 6.25MHZ clock
    input [9:0] x,
    input [6:0] y,
    input [7:0] count, //should update at 10HZ clock
    input [197:0] mazestate,
    input [2:0] curr_colour,
    output reg [15:0] user_square,
    output reg [2:0] wire_to_cut,
    output reg [7:0] begin_spot
    );
    
    reg [3:0] row;
    reg [4:0] column;
    
    initial begin
    begin_spot = 181;
    end
    
    always @(posedge CLK) begin
        if (count == 255) begin
        //we hit the fuckin towers
        user_square = 16'hFB30;
        end 
        
        else if (mazestate[count] == 1) begin
        //all good, we in the walls
            if (count == 31) begin
            //first checkpoint
                if (curr_colour == 3'b001) begin
                //set checkpoint to this point
                begin_spot = 31;
                //GO TO THE CUTTER
                wire_to_cut = 3'b001;
                end else begin
                wire_to_cut = 3'b111;
                end
            end else
            if (count == 113) begin
            //second checkpoint
                if (curr_colour == 3'b010) begin
                //set checkpoint to this point
                begin_spot = 113;
                //GO TO THE CUTTER
                wire_to_cut = 3'b010;
                end else begin
                wire_to_cut = 3'b111;
                end
            end else
            if (count == 178) begin
            //third checkpoint
                if (curr_colour == 3'b011) begin
                //set checkpoint to this point
                begin_spot = 178;
                //GO TO THE CUTTER
                wire_to_cut = 3'b011;
                end else begin
                wire_to_cut = 3'b111;
                end
            end else
            if (count == 37) begin
            //fourth checkpoint
                if (curr_colour == 3'b100) begin
                //set checkpoint to this point
                begin_spot = 37;
                //GO TO THE CUTTER
                wire_to_cut = 3'b100;
                end else begin
                wire_to_cut = 3'b111;
                end
            end else
            if (count == 139) begin 
            //last checkpoint
                if (curr_colour == 3'b101) begin
                //set checkpoint to this point
                begin_spot = 139;
                //GO TO THE CUTTER
                wire_to_cut = 3'b101;
                end else begin
                wire_to_cut = 3'b111;
                end          
            end
        //all squares need to show this
            //show the red square within that count
            row = count / 18;
            column = count % 18;
            if (y > (9 + (row * 5)) & (y < (13 + (row* 5))) & (x > (column * 5)) & (x < 4 + (column * 5) )) begin
                user_square = 16'h93A0;
            end
            else begin
                user_square = 16'hFFFF;
            end
        end
        end

endmodule
