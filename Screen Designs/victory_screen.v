module victory_screen(
    input [6:0] x, // 0-95 (7-bit)
    input [5:0] y, // 0-63 (6-bit)
    output reg [15:0] victory_data
);

// VICTORY text parameters
localparam START_X = 20;  // Starting X coordinate
localparam START_Y = 24;  // Starting Y coordinate
localparam CHAR_WIDTH = 8; // Each character width
localparam CHAR_HEIGHT = 16; // Each character height

always @(*) begin
    // Default background color (black)
    victory_data = 16'b00000_000000_00000;
    
    
    if (y == 3)
        victory_data = 16'b00000_111111_00000;
    if (y >= 8 && y <= 9)
        victory_data = 16'b11111_000000_00000;
    if (y>= 13 && y <= 15)
        victory_data = 16'b00000_000000_11111;
    if (( y == 50 || y == 53) && ((x == 42) || (x == 55)) || (( y == 54 || y == 51) && ((x == 43) || (x == 54))))
        victory_data = 16'b11111_101010_00000;
    
    if (((y == 50) && ((x >= 45) && (x <= 52))) ||
        ((y >= 51 && y <= 53) && ((x >= 46) && (x <= 51))) || 
        ((y == 54) && ((x >= 47) && (x <= 50))) ||
        ((y >= 55 && y <= 57) && ((x >= 48) && (x <= 49))) ||
        ((y >= 58 && y <= 59) && ((x >= 46) && (x <= 51))))
        
         victory_data = 16'b11111_101010_00000; // 底座
 
      
    // Check if within the vertical range of the text
    if (y >= START_Y && y < START_Y + CHAR_HEIGHT) begin
        // 'V' at X:20-27
        if (x >= 14 && x <= 21) begin
            // Left and right slanted lines with thickness
            if (((x - 14) * 4 <= (y - 24) + 3 && (x - 14) * 4 >= (y - 24) - 3) || 
                    ((21 - x) * 4 <= (y - 24) + 3 && (21 - x) * 4 >= (y - 24) - 3) ||
                    (x >=14 && x <= 15 || x >= 20 && x <= 21 ) && (y>= START_Y && y <= (START_Y + 2))) begin
                    victory_data = 16'b11111_111111_11111; // White
            end
        end
        // 'I' at X:28-35
        else if (x >= 24 && x <= 31) begin
            // Top, bottom, and vertical line
            if ((y == START_Y || y == START_Y + CHAR_HEIGHT - 1) || 
                (x >= 27 && x <= 28)) begin
                victory_data = 16'b11111_111111_11111;
            end
        end
        // 'C' at X:36-43
        else if (x >= 34 && x <= 41) begin
            // Left vertical and horizontal lines
            if ((x <= 35) || (y == START_Y || y == START_Y + CHAR_HEIGHT - 1)) begin
                victory_data = 16'b11111_111111_11111;
            end
        end
        // 'T' at X:44-51
        else if (x >= 44 && x <= 51) begin
            // Top horizontal and middle vertical line
            if ((y == START_Y) || (x >= 47 && x <= 48)) begin
                victory_data = 16'b11111_111111_11111;
            end
        end
        // 'O' at X:52-59
        else if (x >= 54 && x <= 61) begin
            // Borders
            if ((x <= 55 || x >= 60) || (y == START_Y || y == START_Y + CHAR_HEIGHT - 1)) begin
                victory_data = 16'b11111_111111_11111;
            end
        end
        // 'R' at X:60-67
        else if (x >= 64 && x <= 71) begin
            // Vertical line, top/middle horizontal, and diagonal
            if ((x <= 65) || (y == START_Y) || (y == START_Y + 7) || 
                ((x - 65) == (y - START_Y - 8) && y >= START_Y + 8) ||
                ((x - 64) == (y - START_Y - 8) && y >= START_Y + 8) ||
                ((x >= 70 && x <= 71) && y >= START_Y && y <= START_Y + 7)) begin
                victory_data = 16'b11111_111111_11111;
            end
        end
        // 'Y' at X:68-75
        else if (x >= 74 && x <= 81) begin
            // Upper V-shape with thicker slants and lower vertical line
            if (((((x - 74) * 4 <= (y - 24) + 3 && (x - 74) * 4 >= (y - 24) - 3) && x <= 77) || 
                (((81 - x) * 4 <= (y - 24) + 3 && (81 - x) * 4 >= (y - 24) - 3) && x >= 78) || 
                (x >= 77 && x <= 78 && y >= START_Y + 8) ||
                ((x == 74 || x == 81) && y == START_Y) ||
                ((x >= 74 && x <= 75) || (x >= 80 && x <= 81)) && (y >= START_Y && y <=  START_Y + 2)) && ~((x == 76 || x == 79) && (y >= 33 && y <= 35))) begin
                victory_data = 16'b11111_111111_11111; // White pixel
            end
        end
        
    end
end

endmodule
