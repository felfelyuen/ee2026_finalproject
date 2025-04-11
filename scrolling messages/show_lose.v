`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2025 02:05:09
// Design Name: 
// Module Name: show_lose
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


module show_lose(
    input basys_clock,
    output reg [7:0] lose_seg,
    output reg [3:0] lose_an
    );
    
    reg [7:0] L, O, S, E, dash;
    reg [3:0] lett_select;
    reg [7:0] show_lett [0:3];
    reg [7:0] message [0:7];
    reg [1:0] digit_select;
    
    wire clk_slow, fast_clk;
    
    flexible_clock_divider clock_slow (basys_clock, 32'h1C9C380, clk_slow);
    flexible_clock_divider my_fast_clk (basys_clock, 32'h1E847, fast_clk);
    
    initial begin
        lose_seg = 8'b11111111;
        lose_an = 4'b1111;
        S = 8'b10010010;
        E = 8'b10000110;
        L = 8'b11000111;
        O = 8'b11000000;
        dash = 8'b10111111;
        lett_select = 4'b0000;
        digit_select = 2'b00;
        
        message[0] = dash;
        message[1] = dash;
        message[2] = dash;
        message[3] = L;
        message[4] = O;
        message[5] = S;
        message[6] = E;
        message[7] = dash;
    end
    
    always @ (*) begin
        show_lett[0] = message[(0 + lett_select) % 7];
        show_lett[1] = message[(1 + lett_select) % 7];
        show_lett[2] = message[(2 + lett_select) % 7];
        show_lett[3] = message[(3 + lett_select) % 7];
    end
    
    always @ (posedge clk_slow) begin
        lett_select <= (lett_select < 4'b0110) ? lett_select + 1 : 4'b0000;
    end
    
    always @ (posedge fast_clk) begin
        case (digit_select)
            4'b00: begin
                lose_seg <= show_lett[3];
                lose_an <= 4'b1110;
            end
            4'b01: begin
                lose_seg <= show_lett[2];
                lose_an <= 4'b1101;
            end
            4'b10: begin
                lose_seg <= show_lett[1];
                lose_an <= 4'b1011;    
            end
            4'b11: begin
                lose_seg <= show_lett[0];
                lose_an <= 4'b0111;   
            end
            default: begin
                lose_seg <= lose_seg;
                lose_an <= lose_an;
            end
        endcase 
        digit_select <= digit_select + 1;
    end
endmodule
