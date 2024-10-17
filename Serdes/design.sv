// Code your design here
`include "decoder.sv"
`include "encoder.sv"
`include "piso.sv"
`include "sipo.sv"
`include "reg_10.sv"
`include "reg_8.sv"
`include "enable.sv"

module top(
    input           clk,
    input           reset,
    //input           ser_in,
    input           dec_en,
    input           ser_en,
    output wire     ser_out,
    output wire [7:0] dout,
    input [7:0]     din
  );
  
  // Serializer module
  wire data_en = 1'b1;
  wire [7:0]       data_8b_reg_e;
  wire [9:0]       data_10b_enc;
  wire [9:0]       data_10b_reg_e;
  wire ser_in,ser_out;
  wire piso_en;
  reg_8 reg_8_inst_e (
               .clk(clk),
               .reset(reset),
               .din(din),
               .data_en(data_en),
               .dout(data_8b_reg_e)
             );
  
  encoder encoder_inst (
                   .clk(clk),
                   .reset(reset),
                   .din(data_8b_reg_e),
  				  .enc_en(ser_en),
  				  .piso_en(piso_en),
                   .dout(data_10b_enc)
                 );
  

  reg_10 reg_10_inst_e (
                .clk(clk),
                .reset(reset),
                .din(data_10b_enc),
                .data_en(data_en),
                .dout(data_10b_reg_e)
              );
  

  piso piso_inst_e (
               .clk(clk),
               .reset(reset),
               .din(data_10b_reg_e),
   				 .send_in(~piso_en),
  				  .sending(sipo_en),
               .dout(ser_out)
             );

  // Deserializer module
  wire [9:0]       data_10b;
  wire[9:0]	      data_10b_reg_d;
  wire [7:0]       data_8b_dec;
  wire sipo_en,deco_en;

  // Instantiate the SIPO module
  
  sipo sipo_inst_d (
               .clk(clk),
               .reset(reset),
               .din(ser_out),
    			.shift(sipo_en),
  			  .deco(deco_en),
               .dout(data_10b)
             );

  // Instantiate the 10-bit latch
  reg_10 reg_10_inst_d (
                .clk(clk),
                .reset(reset),
                .din(data_10b),
                .data_en(data_en),
                .dout(data_10b_reg_d)
              );

  // Instantiate the 10b/8b decoder
  decoder decoder_inst (
            .clk(clk),
            .reset(reset),
            .din(data_10b_reg_d),
            .dec_en(~deco_en),
            .dout(data_8b_dec)
          );

  // Instantiate the 8-bit latch
  reg_8 reg_8_inst_d (
             .clk(clk),
             .reset(reset),
             .din(data_8b_dec),
             .data_en(data_en),
    		.dout(dout)
           );
endmodule
`default_nettype wire