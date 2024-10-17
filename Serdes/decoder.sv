module decoder (
    input clk,
    input reset,
    input [9:0] din,
    input dec_en,
    output reg [7:0] dout
  );
  reg [2:0] temp_3;
  reg [4:0] temp_5;
  reg [3:0] count;

  always @ (posedge clk or negedge reset)
  begin
    if (!reset)
    begin
      temp_3 <= 3'b000;
      temp_5 <= 5'b00000;
      dout <= 10'h0; // Reset dout
    end
    else
    begin
      if(dec_en)
      begin
        case (din[9:6])
          4'b0100:
            temp_3 <= 3'b000;
          4'b1001:
            temp_3 <= 3'b001;
          4'b0101:
            temp_3 <= 3'b010;
          4'b0011:
            temp_3 <= 3'b011;
          4'b0010:
            temp_3 <= 3'b100;
          4'b1010:
            temp_3 <= 3'b101;
          4'b0110:
            temp_3 <= 3'b110;
          4'b0001:
            temp_3 <= 3'b111;
          default:
            temp_3 <= 3'b000;
        endcase
        case (din[5:0])
          6'b011000:
            temp_5 <= 5'b00000;
          6'b011101:
            temp_5 <= 5'b00001;
          6'b010010:
            temp_5 <= 5'b00010;
          6'b110001:
            temp_5 <= 5'b00011;
          6'b110101:
            temp_5 <= 5'b00100;
          6'b101001:
            temp_5 <= 5'b00101;
          6'b011001:
            temp_5 <= 5'b00110;
          6'b111000:
            temp_5 <= 5'b00111;
          6'b111001:
            temp_5 <= 5'b01000;
          6'b100101:
            temp_5 <= 5'b01001;
          6'b010101:
            temp_5 <= 5'b01010;
          6'b110100:
            temp_5<= 5'b01011;
          6'b001101:
            temp_5 <= 5'b01100;
          6'b101100:
            temp_5 <= 5'b01101;
          6'b011100:
            temp_5 <= 5'b01110;
          6'b010111:
            temp_5 <= 5'b01111;
          6'b011011:
            temp_5 <= 5'b10000;
          6'b100011:
            temp_5 <= 5'b10001;
          6'b010011:
            temp_5 <= 5'b10010;
          6'b110010:
            temp_5 <= 5'b10011;
          6'b001011:
            temp_5 <= 5'b10100;
          6'b101010:
            temp_5 <= 5'b10101;
          6'b011010:
            temp_5 <= 5'b10110;
          6'b111010:
            temp_5 <= 5'b10111;
          6'b110011:
            temp_5 <= 5'b11000;
          6'b100110:
            temp_5 <= 5'b11001;
          6'b010110:
            temp_5 <= 5'b11010;
          6'b110110:
            temp_5 <= 5'b11011;
          6'b001110:
            temp_5 <= 5'b11100;
          6'b101110:
            temp_5 <= 5'b11101;
          6'b011110:
            temp_5 <= 5'b11110;
          6'b101011:
            temp_5 <= 5'b11111;
          default:
            temp_5 <= 5'b00000;
        endcase
        
      end
      //else dout <= {temp_3, temp_5};
    end
  end
  always @(posedge clk) begin
    if (dec_en) begin
      dout <= {temp_3, temp_5}; // Update dout when enc_en is high
        end
    end
endmodule
