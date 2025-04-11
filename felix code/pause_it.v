`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2025 07:24:10 PM
// Design Name: 
// Module Name: pause_it
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

module pause_it (
    input [2:0] wire_to_cut,
    input [2:0] curr_colour,
    output reg pause
);
    reg [2:0] prev_curr; reg [2:0] prev_wire;

    initial begin
        pause = 1;
        prev_curr = 3'b000;
        prev_wire = 3'b000;
    end

    always @ (*) begin
        if (curr_colour == 0) begin
            pause = 1;
        end else begin
            pause = 0;
        end
    end
endmodule
