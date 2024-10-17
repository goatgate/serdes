module tb_top;

    // Clock, Reset, and Control signals
    reg clk;
    reg reset; // Active-low reset
    reg [7:0] data_in; // Two data inputs
    reg [7:0] data_out;
    reg dec_en, ser_en;
    reg ser_out;

    // Instantiate the top module
    top uut (
        .clk(clk),
        .reset(reset), // Connect active-low reset
        .din(data_in),
        .ser_out(ser_out),
        .dec_en(dec_en),
        .ser_en(ser_en),
        .dout(data_out)
    );

    // Clock generation (50 MHz, period = 20 ns)
    always #10 clk = ~clk;

    // Test Vector Variables
    reg [7:0] test_vectors1 [0:15]; // Array for first input test vectors

    // Testbench initialization
    initial begin
        // Initialize the clock and reset
        clk = 0;
        reset = 1; // Active high (inactive)

        // Initialize test vectors and expected output
      test_vectors1[0] = 8'b00100111; 
        test_vectors1[1] = 8'h3C; 
        test_vectors1[2] = 8'h5F; 
        test_vectors1[3] = 8'h99; 
        test_vectors1[4] = 8'hAA; 
        test_vectors1[5] = 8'hFF; 
        test_vectors1[6] = 8'h01; 
        test_vectors1[7] = 8'hC3; 
        test_vectors1[8] = 8'h76; 
        test_vectors1[9] = 8'h44; 
        test_vectors1[10] = 8'h68; 
        test_vectors1[11] = 8'h7E;
        test_vectors1[12] = 8'hB2;
        test_vectors1[13] = 8'h0F;
        test_vectors1[14] = 8'h13;
        test_vectors1[15] = 8'hEF;

        // Apply active-low reset for a few cycles
        #10 reset = 1;  // Active-low reset (asserted)
        #10 reset = 0;  // Deassert the reset (inactive)
      	#10 reset = 1;

        // Wait for pipeline stages to initialize
        #10;  // Wait for the pipeline to stabilize after reset

        // Apply each test vector with delays
        // Test Vector 0
        data_in = test_vectors1[0];
        #100; // Apply inputs
        #100 ser_en = 0;
     	#100 ser_en = 1;
        #100 dec_en = 1;
        #100 dec_en =0;
      
        // Loop to capture serial output
        repeat (8) begin
            #10;  // Wait for the next clock cycle
            $display("Serial Output Bit: %b", ser_out);
        end

        #100; // Wait for output

       // Test Vector 1
        data_in = test_vectors1[1];
        #100; // Apply inputs
        #100 ser_en = 0;
     	#100 ser_en = 1;
        #100 dec_en = 1;
        #100 dec_en =0;
      
        // Loop to capture serial output
        repeat (8) begin
            #10;  // Wait for the next clock cycle
            $display("Serial Output Bit: %b", ser_out);
        end
        #100;
      	// Test Vector 2
      	data_in = test_vectors1[2];
        #100; // Apply inputs
        #100 ser_en = 0;
     	#100 ser_en = 1;
        #100 dec_en = 1;
        #100 dec_en =0;
      
        // Loop to capture serial output
        repeat (8) begin
            #10;  // Wait for the next clock cycle
            $display("Serial Output Bit: %b", ser_out);
        end
        
        #1000; // Wait for output
  
        $stop;
    end

    

    initial begin
        $dumpfile("waveform.vcd"); // Name of the VCD file
        $dumpvars(0, tb_top);       // Dump all variables in the tb_top module
    end
    
endmodule
