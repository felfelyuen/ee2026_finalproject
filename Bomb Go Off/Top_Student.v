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
    output [7:0]JA,
    output [7:0]JB,
    output [7:0]JC,
    input [15:0]sw,
    output [15:0] led,
    output [7:0] seg,
    output [3:0] an
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
    
    //Wires for seg and anode to show timer or scrolling message
    wire [7:0] timer_seg, win_seg, lose_seg;
    wire [3:0] timer_an, win_an, lose_an;
    
    //Colour code display
    wire [2:0] curr_colour;
    
    //Felixs wires
    wire [2:0] wire_to_cut; wire [6:0] x_two; wire [5:0] y_two;

    ///Ryans output
    wire [2:0]wire_cut;

    //Lose conditions
    wire times_up;

    //============================7-Segment stuff==================================
    count_down bomb_timer (.clk(basys_clock), .seg(timer_seg), .ano(timer_an), .reset(!sw[0]), .lose(times_up));
    show_success success_scrolling (.basys_clock(basys_clock), .success_seg(win_seg), .success_an(win_an));
    show_lose lose_scrolling (.basys_clock(basys_clock), .lose_seg(lose_seg), .lose_an(lose_an));
    
    //assign seg = (wire_cut == 3'b111 || times_up) ? lose_seg : ((wire_cut == 3'b101) ? win_seg : timer_seg);
    //assign an = (wire_cut == 3'b111 || times_up) ? lose_an : ((wire_cut == 3'b101) ? win_an : timer_an);
    assign seg = (wire_cut == 3'b101) ? win_seg : ((wire_cut == 3'b111 || times_up) ? lose_seg : timer_seg);
    assign an = (wire_cut == 3'b101) ? win_an : ((wire_cut == 3'b111 || times_up) ? lose_an : timer_an);
    
    //===========================Home Screen=======================================
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
    
    //======================Isaac stuff ===================================
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
        .is_connected(is_connected)
    );
    
    wire [15:0] victory_data;
    victory_screen vict_screen (
        .x(x), 
        .y(y),
        .victory_data(victory_data)
    );
        
    wire [15:0] lose_screen;

    lose_screen loseeee_screen(
        .x(x),
        .y(y),
        .oled_data(lose_screen)
    ); 
        
    //Top right screen
    assign oled_data = (sw[0]) ? ((wire_cut == 3'b101) ? victory_data : ((wire_cut == 3'b111 || times_up) ?  lose_screen : grid_data)) : home_data;
    
    show_colour_code colour_code_display (
        .cut_wire(wire_cut),
        .is_connected(is_connected),
        .reset(!sw[0]),
        .led_colour_code(led),
        .curr_colour(curr_colour)
    );
    
    Oled_Display Isaac_oled_display (
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
//====================== Felixs stuff ===================================
    wire [15:0] oled_data_two, maze_game_data; 
    wire fb_two; wire [12:0] pi_two; wire sendp_two; wire samplep_two; 

    //we are using JA for the maze (or anything)
    Oled_Display oleddd (
        .clk(clk_6p25mhz), 
        .reset(0), 
        .frame_begin(fb_two), 
        .sending_pixels(sendp_two), 
        .sample_pixel(samplep_two), 
        .pixel_index(pi_two), 
        .pixel_data(oled_data_two), 
        .cs(JA[0]), 
        .sdin(JA[1]), 
        .sclk(JA[3]), 
        .d_cn(JA[4]), 
        .resn(JA[5]), 
        .vccen(JA[6]),
        .pmoden(JA[7])
    );
    
    wire [15:0] warning_screen = maze_game_data;

    assign oled_data_two = (sw[0]) ? ((wire_cut == 3'b101) ? warning_screen : ((wire_cut == 3'b111 || times_up) ?  0 : maze_game_data)) : warning_screen;
    
    convert_to_xy coordinates (pi_two, x_two, y_two);

    //curr_colour from isaac, wire_to_cut to ryan

    maze mazee (basys_clock, sw[0], pb, x_two, y_two, sw[15], sw[14], sw[13], sw[1], curr_colour, maze_game_data, wire_to_cut);
//======================== Ryans Stuff ======================================
    wire fb_3, send_pix_3, sample_pix_3;
        wire [15:0] oled_data_3;
        wire [12:0] pixel_index_3;
        wire [6:0] x_ryan;
        wire [5:0] y_ryan;
        wire [15:0] wire_game_data;
        
        convert_to_xy ryan_convertor (.pixel_index(pixel_index_3), .x(x_ryan), .y(y_ryan));
        
        Oled_Display display(
            .clk(clk_6p25mhz), .reset(0), .frame_begin(fb_3), .sending_pixels(send_pix_3),
            .sample_pixel(sample_pix_3), .pixel_index(pixel_index_3), .pixel_data(oled_data_3), 
            .cs(JC[0]), .sdin(JC[1]), .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), 
            .vccen(JC[6]), .pmoden(JC[7])
        ); 
        
        Top_Student_ryan fa3 (
            .is_connected(is_connected),
            .wire_to_cut(wire_to_cut),
            .slow_clock(clk_6p25mhz),
            .pb(pb),
            .sw(sw[3:0]),
            .wire_cut(wire_cut),
            .oled_data(wire_game_data),
            .x(x_ryan),
            .y(y_ryan)
        );
        
        assign oled_data_3 = (sw[0]) ? ((wire_cut == 3'b101) ? 0 : ((wire_cut == 3'b111 || times_up) ?  0 : wire_game_data)) : 0;
endmodule
