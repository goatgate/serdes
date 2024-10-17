module piso (
    input clk,
    input reset,
    input [9:0] din,
    input send_in,
    output reg dout,
    output reg sending // Signal that indicates when PISO is sending data
);

  reg [9:0] shift_reg;

  always @(posedge clk or negedge reset) 
  begin
    if (!reset) 
    begin
      shift_reg <= 10'h0; // Reset shift register
      dout <= 1'b0;       // Clear dout during reset
      sending <= 1'b0;    // Clear sending flag during reset
    end 
    else 
    begin
      if (send_in) 
      begin
        shift_reg <= din; // Load data into shift register
        sending <= 1'b1;  // Indicate that sending has started
      end 
      else if (sending) 
      begin
        dout <= shift_reg[0]; // Output the LSB
        shift_reg <= {1'b0, shift_reg[9:1]}; // Shift right
        
        // If the shift register is empty, stop sending
        if (shift_reg == 10'b0) 
          sending <= 1'b0; 
      end
    end
  end

endmodule
`default_nettype wire
