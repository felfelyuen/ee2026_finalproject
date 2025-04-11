`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2025 08:16:00 PM
// Design Name: 
// Module Name: show_maze_two
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


module show_maze_two(
    input CLK,
    input [6:0] x,
    input [5:0] y,
    input [7:0] counter,
    input [197:0] mazestate,
    output reg [15:0] olede
    );
    
    reg [7:0] t_state;
    
    always @(posedge CLK) begin
    if (x > 89 | y < 9 ) begin
    olede = 16'h0000;
    end 
    else begin
        t_state = (x / 5) + 18 * ((y - 9) /5);
        if (mazestate[t_state] == 1) begin
            //show the maze
            if (counter == 255) begin
            //we hit the towers
            //everywhere in the maze we red
            olede = 16'hFB30;
            end else begin
                //checkpoints
                if (t_state == 31) begin
                olede = 16'hFC0D;
                end else if (t_state == 37) begin
                olede = 16'hFD20;
                end else if (t_state == 113) begin
                olede = 16'hF800;
                end else if (t_state == 139) begin
                olede = 16'h07E0;
                end else if (t_state == 178) begin
                olede = 16'hD01F;
                end else
                olede = 16'hFFFF;
            end
        end else begin
        olede = 16'h0000;
        end
        end
    end
endmodule
