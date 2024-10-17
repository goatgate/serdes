module sp_enable(
	input clk,
  	input reset,
  	input en,
  	output reg sp_en
);
  always@(posedge clk)
    begin
      if(reset)
        sp_en<=1'b0;
      else
        sp_en<=((en==0)?1:0);
    end
endmodule