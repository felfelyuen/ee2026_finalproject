`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2025 23:02:57
// Design Name: 
// Module Name: show_colour_code
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


module show_colour_code(
    input [2:0] cut_wire,
    input is_connected,
    input reset,
    output reg [15:0] led_colour_code,
    output reg [2:0] curr_colour
    );
    
    initial begin
        led_colour_code = 0;
        curr_colour = 0;
    end
    
    always @ (*) begin
        if (is_connected) begin
            case (cut_wire)
                3'b000: begin
                    led_colour_code = 16'b11111_100000_01101; //after flow game is done, led is pink code
                    curr_colour = 3'b001; //pink
                end
                3'b001: begin
                    led_colour_code = 16'b11111_000000_00000; //red code
                    curr_colour = 3'b010; //red
                end
                3'b010: begin
                    led_colour_code = 16'b00000_000000_11111; //blue code
                    curr_colour = 3'b011; //blue
                end
                3'b011: begin
                    led_colour_code = 16'b11111_101001_00000; //orange code
                    curr_colour = 3'b100; //orange
                end
                3'b100: begin
                    led_colour_code = 16'b00000_111111_00000; //green code
                    curr_colour = 3'b100; //green
                end
                3'b101: begin
                    led_colour_code = 16'b11111_111111_11111; //win
                end
                3'b111: begin
                    led_colour_code = 16'b10101_010101_01010; //lose
                end
                default: begin
                    led_colour_code = led_colour_code;
                    curr_colour = curr_colour;
                end
            endcase
        end else if (!is_connected || reset) begin
            led_colour_code = 0;
            curr_colour = 0;
        end
    end
    
    
    
endmodule
