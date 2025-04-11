`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2025 16:30:05
// Design Name: 
// Module Name: vert_tile
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


module vert_tile(
    input clk_1khz,
    input pbCenter,
    input [6:0] tile_dx,
    input [5:0] tile_dy,
    input [6:0] x,
    input [5:0] y,
    input [6:0] selector_x,
    input [5:0] selector_y,
    input reset,
    input [15:0] colour,
    output reg [15:0] vert_tile_data,
    output reg [2:0] state
    );
    
    reg [2:0]toggle_tile;
    reg prev_pbCenter;
    
    initial begin
        toggle_tile = 0;
        prev_pbCenter = 0;
    end
    
    //Toggle between each tile shape
    always @ (posedge clk_1khz) begin
        if (!reset && (selector_x == tile_dx - 7 || selector_x == tile_dx - 8) && (selector_y == tile_dy - 4 || selector_y == tile_dy - 5) && !prev_pbCenter && pbCenter) begin
            toggle_tile <= ( toggle_tile == 3'b110 ) ? 0 : toggle_tile + 1;
        end else if (reset) begin
            toggle_tile <= 0;
        end
        prev_pbCenter <= pbCenter;
    end
    
    always @ (*) begin
        case (toggle_tile)
            3'b000: begin
                vert_tile_data = 0;
            end
            3'b001: begin
                if (x >= tile_dx && x <= tile_dx + 3 && y >= tile_dy - 3 && y <= tile_dy + 6) begin
                    vert_tile_data = colour;
                end else begin
                    vert_tile_data = 0;
                end
            end
            3'b010: begin
                if (x >= tile_dx - 6 && x <= tile_dx + 9 && y >= tile_dy && y <= tile_dy + 3) begin
                    vert_tile_data = colour;
                end else begin
                    vert_tile_data = 0;
                end
            end
            3'b011: begin
                if ((x >= tile_dx && x <= tile_dx + 3 && y >= tile_dy - 3 && y <= tile_dy +3) || (x >= tile_dx + 4 && x <= tile_dx + 9 && y >= tile_dy && y <= tile_dy + 3)) begin
                    vert_tile_data = colour;
                end else begin
                    vert_tile_data = 0;
                end
            end
            3'b100: begin
                if ((x >= tile_dx && x <= tile_dx + 3 && y >= tile_dy - 3 && y <= tile_dy + 3) || (x >= tile_dx - 6 && x <= tile_dx - 1 && y >= tile_dy && y <= tile_dy + 3)) begin
                    vert_tile_data = colour;
                end else begin
                    vert_tile_data = 0;
                end
            end
            3'b101: begin
                if ((x >= tile_dx && x <= tile_dx + 3 && y >= tile_dy && y <= tile_dy + 6) || (x >= tile_dx - 6 && x <= tile_dx - 1 && y >= tile_dy && y <= tile_dy + 3)) begin
                    vert_tile_data = colour;
                end else begin
                    vert_tile_data = 0;
                end
            end
            3'b110: begin
                if ((x >= tile_dx && x <= tile_dx + 3 && y >= tile_dy && y <= tile_dy + 6) || (x >= tile_dx + 4 && x <= tile_dx + 9 && y >= tile_dy && y <= tile_dy + 3)) begin
                    vert_tile_data = colour;
                end else begin
                    vert_tile_data = 0;
                end
            end
            default: begin
                vert_tile_data <= vert_tile_data;
            end
        endcase
        state = toggle_tile;
    end
    
endmodule
