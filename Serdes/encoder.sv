module encoder (
    input clk,
    input reset,
    input [7:0] din,
    input enc_en,
  	output reg piso_en,
    output reg [9:0] dout
);
    reg [3:0] temp_4;
    reg [5:0] temp_6;

    // Asynchronous reset block
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            temp_4 <= 4'h0;
            temp_6 <= 6'h0;
            dout <= 10'h0; // Reset dout
        end
        else if (!enc_en) begin
            // Encoding logic when enc_en is low
            case (din[7:5])
                3'b000: temp_4 <= 4'b0100;
                3'b001: temp_4 <= 4'b1001;
                3'b010: temp_4 <= 4'b0101;
                3'b011: temp_4 <= 4'b0011;
                3'b100: temp_4 <= 4'b0010;
                3'b101: temp_4 <= 4'b1010;
                3'b110: temp_4 <= 4'b0110;
                3'b111: temp_4 <= 4'b0001;
                default: temp_4 <= 4'b0000;
            endcase
            
            case (din[4:0])
                5'b00000: temp_6 <= 6'b011000;
                5'b00001: temp_6 <= 6'b011101;
                5'b00010: temp_6 <= 6'b010010;
                5'b00011: temp_6 <= 6'b110001;
                5'b00100: temp_6 <= 6'b110101;
                5'b00101: temp_6 <= 6'b101001;
                5'b00110: temp_6 <= 6'b011001;
                5'b00111: temp_6 <= 6'b111000;
                5'b01000: temp_6 <= 6'b111001;
                5'b01001: temp_6 <= 6'b100101;
                5'b01010: temp_6 <= 6'b010101;
                5'b01011: temp_6 <= 6'b110100;
                5'b01100: temp_6 <= 6'b001101;
                5'b01101: temp_6 <= 6'b101100;
                5'b01110: temp_6 <= 6'b011100;
                5'b01111: temp_6 <= 6'b010111;
                5'b10000: temp_6 <= 6'b011011;
                5'b10001: temp_6 <= 6'b100011;
                5'b10010: temp_6 <= 6'b010011;
                5'b10011: temp_6 <= 6'b110010;
                5'b10100: temp_6 <= 6'b001011;
                5'b10101: temp_6 <= 6'b101010;
                5'b10110: temp_6 <= 6'b011010;
                5'b10111: temp_6 <= 6'b111010;
                5'b11000: temp_6 <= 6'b110011;
                5'b11001: temp_6 <= 6'b100110;
                5'b11010: temp_6 <= 6'b010110;
                5'b11011: temp_6 <= 6'b110110;
                5'b11100: temp_6 <= 6'b001110;
                5'b11101: temp_6 <= 6'b101110;
                5'b11110: temp_6 <= 6'b011110;
                5'b11111: temp_6 <= 6'b101011;
                default: temp_6 <= 6'b000000;
            endcase
        end
    end

    // Output assignment based on the encoder enable signal
    always @(posedge clk) begin
        if (enc_en) begin
            dout <= {temp_4, temp_6}; // Update dout when enc_en is high
        end
    end
assign piso_en = enc_en;
endmodule
