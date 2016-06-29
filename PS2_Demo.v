

module PS2_Demo (

    // Inputs
    CLOCK_50,
    KEY,
    // Bidirectionals

    PS2_CLK,

    PS2_DAT,

    // Outputs
    HEX0,
    HEX1,
    HEX2,
    HEX3,
    HEX4,
    HEX5,
    LEDR
);


/*****************************************************************************

 *                           Parameter Declarations                          *

 *****************************************************************************/



/*****************************************************************************

 *                             Port Declarations                             *

 *****************************************************************************/


// Inputs

input                CLOCK_50;

input        [3:0]    KEY;


// Bidirectionals

inout                PS2_CLK;

inout                PS2_DAT;


// Outputs

output        [6:0]    HEX0;

output        [6:0]    HEX1;

output        [6:0]    HEX2;

output        [6:0]    HEX3;

output        [6:0]    HEX4;

output        [6:0]    HEX5;


output         [9:0] LEDR;

wire space_reset;

/*****************************************************************************

 *                 Internal Wires and Registers Declarations                 *

 *****************************************************************************/


// Internal Wires

wire        [7:0]    ps2_key_data;

wire                ps2_key_pressed;


// Internal Registers

reg            [7:0]    last_data_received;


// State Machine Registers


/*****************************************************************************

 *                         Finite State Machine(s)                           *

 *****************************************************************************/



/*****************************************************************************

 *                             Sequential Logic                              *

 *****************************************************************************/


always @(posedge CLOCK_50)

begin

    if (space_reset == 1'b1)

        last_data_received <= 8'h00;

    else if (ps2_key_pressed == 1'b1)

        last_data_received <= ps2_key_data;


end


/*****************************************************************************

 *                            Combinational Logic                            *

 *****************************************************************************/




/*****************************************************************************

 *                              Internal Modules                             *

 *****************************************************************************/


PS2_Controller PS2 (

    // Inputs

    .CLOCK_50                (CLOCK_50),

    .reset                (~KEY[0]),


    // Bidirectionals

    .PS2_CLK            (PS2_CLK),

    .PS2_DAT            (PS2_DAT),


    // Outputs

    .received_data        (ps2_key_data),

    .received_data_en    (ps2_key_pressed)

);



reg [3:0] for_HEX;
always @(*)
begin
if (last_data_received==8'h16)
	for_HEX<=4'b0001;
else if (last_data_received==8'h1E)
	for_HEX<=4'b0010;
else if (last_data_received==8'h26)
	for_HEX<=4'b0011;
else if (last_data_received==8'h25)
	for_HEX<=4'b0100;
else if (last_data_received==8'h2E)
	for_HEX<=4'b0101;
else if (last_data_received==8'h36)
	for_HEX<=4'b0110;
else if (last_data_received==8'h3D)
	for_HEX<=4'b0111;
else if (last_data_received==8'h3E)
	for_HEX<=4'b0001;
else
	for_HEX<=4'b0000;
end


hexDecoder h0(4'b0000,HEX0);
hexDecoder h1(4'b0000,HEX1);
hexDecoder h4(4'b0000,HEX4);
hexDecoder h5(4'b0000,HEX5);
hexDecoder h2(for_HEX,HEX2);
hexDecoder h3(for_HEX,HEX3);


assign LEDR[9] = (last_data_received[7:4]==8'h1 && last_data_received[3:0]==8'h6)?1:0;
assign LEDR[8] = (last_data_received[7:4]==8'h1 && last_data_received[3:0]==8'hE)?1:0;
assign LEDR[7] = (last_data_received[7:4]==8'h2 && last_data_received[3:0]==8'h6)?1:0;
assign LEDR[6] = (last_data_received[7:4]==8'h2 && last_data_received[3:0]==8'h5)?1:0;
assign LEDR[5] = (last_data_received[7:4]==8'h2 && last_data_received[3:0]==8'hE)?1:0;
assign LEDR[4] = (last_data_received[7:4]==8'h3 && last_data_received[3:0]==8'h6)?1:0;
assign LEDR[3] = (last_data_received[7:4]==8'h3 && last_data_received[3:0]==8'hD)?1:0;
assign LEDR[2] = (last_data_received[7:4]==8'h3 && last_data_received[3:0]==8'hE)?1:0;

assign space_reset = (last_data_received[7:0]==8'h29)?1:0;


endmodule



module hexDecoder (switch, HEX);//1 is off
	input [3:0]switch;
	output reg[0:6]HEX;
	always@(*)
		case(switch[3:0])
		//6543210
		0:HEX=7'b0111111;//bar
		1:HEX=7'b1000110;//C
		2:HEX=7'b0100001;//d
		3:HEX=7'b0000110;//E
		4:HEX=7'b0001110;//F
		5:HEX=7'b0010000;//g
		6:HEX=7'b0001000;//A
		7:HEX=7'b0000011;//b
		8:HEX=7'b0000000;
		9:HEX=7'b0001100;
		10:HEX=7'b0001000;
		11:HEX=7'b1100000;
		12:HEX=7'b0110001;
		13:HEX=7'b1000010;
		14:HEX=7'b0110000;
		15:HEX=7'b0111000;
		endcase
	endmodule

