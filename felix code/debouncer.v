`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2025 02:16:26 PM
// Design Name: 
// Module Name: debouncer
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

/*
the debouncer works such that
it waits for 200ms before taking in the next count
*/

module debouncer (
    input button,
    input CLK,
    output reg pressed
    );
    
    reg [8:0] count200;
    
    initial begin
    pressed = 1'b0;
    count200 = 0;
    end
    
    always @(posedge CLK) begin
        if (button | pressed) begin
            if (count200 == 0) begin
            //200ms ignore time is passed
                if (button) begin
                //make pressed = 1
                    pressed = 1;
                end
                else begin
                    pressed = 0;
                end
            end
            else begin
                //in 200ms ignore mode
                count200 = (count200 == 400) ? 0 : count200 + 1;
            end
        end
    end
endmodule
