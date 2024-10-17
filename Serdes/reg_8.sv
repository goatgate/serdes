module reg_8 (
    input clk,
    input reset,
    input data_en,
    input [7:0] din,
    output reg [7:0] dout
  );
  always @(posedge clk or negedge reset)
  begin
    if(!reset)
    begin
      dout<= 8'h00;
    end
    else
      if(data_en)
      begin
        dout <=din;
      end
      else
        dout <= dout;
  end
endmodule
`default_nettype wire
