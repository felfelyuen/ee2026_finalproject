`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input basys_clock,
    input [4:0]pb,
    output [7:0]JB,
    input [4:0]sw,
    output [15:0] led
);
    //Pixel display
    reg reset;
    wire [15:0]oled_data;
    wire [12:0]pixel_index;
    wire fb, sending_pixels, sample_pixel;
    
    //Slow clocks
    wire clk_6p25mhz, clk_1khz;
    
    //Pixel coordinates
    wire [6:0]x;
    wire [5:0]y;
    
    wire [15:0]grid_data, home_data;
    
    //Flow game
    wire is_connected;
    
    //Colour code display
    wire [2:0] curr_colour;
    
    start_screen bomb_go_off (
        .x(x),
        .y(y),
        .start_screen_data(home_data)
    );
    //Clock dividers
    flexible_clock_divider my_6p25mhz_clk (.basys_clk(basys_clock), .m(32'b0111), .slow_clk(clk_6p25mhz));
    flexible_clock_divider my_1khz_clk (.basys_clk(basys_clock), .m(32'hC34F), .slow_clk(clk_1khz));


    //Converts pixel_index to x and y coordinates
    convert_to_xy xy_coordinates (.pixel_index(pixel_index), .x(x), .y(y));
    
    flow_game flow_minigame (
        .clk_1khz(clk_1khz),
        .pbUp(pb[0]),
        .pbDown(pb[1]),
        .pbLeft(pb[2]),
        .pbRight(pb[3]),
        .pbCenter(pb[4]),
        .x(x),
        .y(y),
        .reset(!sw[0]),
        .data(grid_data),
        .is_connected(is_connected));
    
    assign oled_data = (sw[0]) ? grid_data : home_data;
    
    show_colour_code colour_code_display (
        .cut_wire(sw[3:1]),
        .is_connected(is_connected),
        .reset(!sw[0]),
        .led_colour_code(led),
        .curr_colour(curr_colour)
    );
    
    Oled_Display led_display (
            .clk(clk_6p25mhz),
            .reset(0),
            .frame_begin(fb),
            .sending_pixels(sending_pixels),
            .sample_pixel(sample_pixel),
            .pixel_index(pixel_index),
            .pixel_data(oled_data),
            .cs(JB[0]),
            .sdin(JB[1]),
            .sclk(JB[3]),
            .d_cn(JB[4]),
            .resn(JB[5]),
            .vccen(JB[6]),
            .pmoden(JB[7])
    );

endmodule
