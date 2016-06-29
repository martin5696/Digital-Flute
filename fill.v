// Part 2 skeleton

module fill
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	wire [2:0] rom1data_w,rom2data_w,rom3data_w,rom4data_w,rom5data_w,rom6data_w,rom7data_w,rom8data_w;//data read from rom which contain picture information
	wire [14:0] rom1address_w,rom2address_w,rom3address_w,rom4address_w,rom5address_w,rom6address_w,rom7address_w,rom8address_w;
	position position_uposition(.CLOCK_50(CLOCK_50),
	                            .resetn(resetn),
										 .sw(SW[7:0]),
										 .rom1data(rom1data_w),
										 .rom1address(rom1address_w),
										 .rom2data(rom2data_w),
										 .rom2address(rom2address_w),
										 .rom3data(rom3data_w),
										 .rom3address(rom3address_w),
										 .rom4data(rom4data_w),
										 .rom4address(rom4address_w),
										 .rom5data(rom5data_w),
										 .rom5address(rom5address_w),
										 .rom6data(rom6data_w),
										 .rom6address(rom6address_w),
										 .rom7data(rom7data_w),
										 .rom7address(rom7address_w),
										 .rom8data(rom8data_w),
										 .rom8address(rom8address_w),
										 .x(x),
										 .y(y),
										 .colour(colour),
										 .writeEn(writeEn));
	rom1 rom_u1 (
	.address(rom1address_w),
	.clock(CLOCK_50),
	.q(rom1data_w));
	
	rom2 rom_u2 (
	.address(rom2address_w),
	.clock(CLOCK_50),
	.q(rom2data_w));
	
	rom3 rom_u3 (
	.address(rom3address_w),
	.clock(CLOCK_50),
	.q(rom3data_w));
	
	rom4 rom_u4 (
	.address(rom4address_w),
	.clock(CLOCK_50),
	.q(rom4data_w));
	
	rom5 rom_u5 (
	.address(rom5address_w),
	.clock(CLOCK_50),
	.q(rom5data_w));
	
	rom6 rom_u6 (
	.address(rom6address_w),
	.clock(CLOCK_50),
	.q(rom6data_w));
	
	rom7 rom_u7 (
	.address(rom7address_w),
	.clock(CLOCK_50),
	.q(rom7data_w));
	
	rom8 rom_u8 (
	.address(rom8address_w),
	.clock(CLOCK_50),
	.q(rom8data_w));
	// for the VGA controller, in addition to any other functionality your design may require.
    
    // Instanciate datapath
	
    // Instanciate FSM control

endmodule
