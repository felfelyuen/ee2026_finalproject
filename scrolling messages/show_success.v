`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2025 23:44:22
// Design Name: 
// Module Name: show_success
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


module show_success(
    input basys_clock,
    output reg [7:0] success_seg,
    output reg [3:0] success_an
    );
    
    reg [7:0] S, U, C, E, dash;
    reg [3:0] lett_select;
    reg [7:0] show_lett [0:3];
    reg [7:0] message [0:13];
    reg [1:0] digit_select;
    
    wire clk_slow, fast_clk;
    
    flexible_clock_divider clock_slow (basys_clock, 32'h1C9C380, clk_slow);
    flexible_clock_divider my_fast_clk (basys_clock, 32'h1E847, fast_clk);
    
    initial begin
        success_seg = 8'b11111111;
        success_an = 4'b1111;
        S = 8'b10010010;
        U = 8'b11000001;
        C = 8'b11000110;
        E = 8'b10000110;
        dash = 8'b10111111;
        lett_select = 4'b0000;
        digit_select = 2'b00;
        
        message[0] = dash;
        message[1] = dash;
        message[2] = dash;
        message[3] = S;
        message[4] = U;
        message[5] = C;
        message[6] = C;
        message[7] = E;
        message[8] = S;
        message[9] = S;
        message[10] = dash;
        message[11] = dash;
        message[12] = dash;
    end
    
    always @ (*) begin
        show_lett[0] = message[(0 + lett_select) % 12];
        show_lett[1] = message[(1 + lett_select) % 12];
        show_lett[2] = message[(2 + lett_select) % 12];
        show_lett[3] = message[(3 + lett_select) % 12];
    end
    
    always @ (posedge clk_slow) begin
        lett_select <= (lett_select < 4'b1010) ? lett_select + 1 : 4'b0000;
    end
    
    always @ (posedge fast_clk) begin
        case (digit_select)
            4'b00: begin
                success_seg <= show_lett[3];
                success_an <= 4'b1110;
            end
            4'b01: begin
                success_seg <= show_lett[2];
                success_an <= 4'b1101;
            end
            4'b10: begin
                success_seg <= show_lett[1];
                success_an <= 4'b1011;    
            end
            4'b11: begin
                success_seg <= show_lett[0];
                success_an <= 4'b0111;   
            end
            default: begin
                success_seg <= success_seg;
                success_an <= success_an;
            end
        endcase 
        digit_select <= digit_select + 1;
    end
    
endmodule
