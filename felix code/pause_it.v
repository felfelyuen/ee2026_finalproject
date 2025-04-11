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
initial begin
pause = 1;
end

    always @ (wire_to_cut) begin
        pause = 1;
    end
    
    always @(curr_colour) begin
         pause = 0;
    end
endmodule