module sipo (
  input clk,
  input reset,
  input din,
  input shift,
  output reg deco,
  output reg [9:0] dout
);
  reg [9:0] shift_reg;
  reg [3:0] count;

  always @(posedge clk or negedge reset)
  begin
    if (!reset)
    begin
      shift_reg <= 10'h0;
      count <= 4'h0;
    end
    else
    begin
      if (shift)
      begin
        shift_reg <= {din, shift_reg[9:1]}; // Shift the bits and input din
        count = count+1;
      end
    end
  end

  // Update dout with the current shift_reg value every cycle
  always @(posedge clk or negedge reset)
  begin
    if (!reset)
    begin
      dout <= 10'h0;
    end
    else
    begin
      dout <= shift_reg; // Always output the current state of the shift register
    end
  end
  
  always @(posedge clk or negedge reset)
    begin
    if(count == 4'h10)
      
      deco <= 1'b1; // Always output the current state of the shift register

  	else
      deco <= 1'b0;
    end
  
  //assign deco = shift;
endmodule

