module position(CLOCK_50,resetn,sw,rom1data,rom1address,rom2data,rom2address,rom3data,rom3address,rom4data,rom4address,rom5data,rom5address,rom6data,rom6address,rom7data,rom7address,rom8data,rom8address,x,y,colour,writeEn);
   parameter pixel_x=8'd32;
	parameter pixel_y=7'd24;
	input CLOCK_50,resetn;
	input [2:0] rom1data,rom2data,rom3data,rom4data,rom5data,rom6data,rom7data,rom8data;//data read from rom which contain picture information
	output [14:0] rom1address,rom2address,rom3address,rom4address,rom5address,rom6address,rom7address,rom8address;
	reg [14:0] rom1address_r,rom2address_r,rom3address_r,rom4address_r,rom5address_r,rom6address_r,rom7address_r,rom8address_r;
	input [7:0] sw;
	output [7:0] x;
	output [6:0] y;
	output writeEn;
	output [2:0] colour;
	reg [7:0] x_cnt;
	reg [6:0] y_cnt;
	reg [2:0] colour_r;
	reg writeEn_r;
	assign x=x_cnt;
	assign y=y_cnt;
	assign colour=colour_r;
	assign writeEn=writeEn_r;
	assign rom1address=rom1address_r;
	assign rom2address=rom2address_r;
	assign rom3address=rom3address_r;
	assign rom4address=rom4address_r;
	assign rom5address=rom5address_r;
	assign rom6address=rom6address_r;
	assign rom7address=rom7address_r;
	assign rom8address=rom8address_r;
	always@(posedge CLOCK_50 or negedge resetn)
	begin
	
	if(!resetn)
	    begin
	    x_cnt<=8'd0;
	    y_cnt<=7'd0;
	    colour_r<=3'b000;
	    writeEn_r<=1'b0;
		 rom1address_r<=15'd0;
		 rom2address_r<=15'd0;
		 rom3address_r<=15'd0;
		 rom4address_r<=15'd0;
		 rom5address_r<=15'd0;
		 rom6address_r<=15'd0;
		 rom7address_r<=15'd0;
		 rom8address_r<=15'd0;
	    end
	else
	    begin
		 
		 if(x_cnt==8'd159)
		     begin
		     x_cnt<=8'd0;
		     
			  if(y_cnt==7'd119)
			  y_cnt<=7'd0;
			  else
			  y_cnt<=y_cnt+7'd1;
			  
		     end
		 else
		     begin
		     x_cnt<=x_cnt+8'd1;
		     end
		 
	
   if(sw[0]==1'b1)	
	    begin
		 writeEn_r<=1'b1;
		 colour_r<=rom1data;
		 rom1address_r<={y_cnt,7'd0}+{y_cnt,5'd0}+x_cnt;
	    end
   else if(sw[1]==1'b1)	
	    begin
		 writeEn_r<=1'b1;
		 colour_r<=rom2data;
		 rom2address_r<={y_cnt,7'd0}+{y_cnt,5'd0}+x_cnt;
	    end
   else if(sw[2]==1'b1)	
	    begin
		 writeEn_r<=1'b1;
		 colour_r<=rom3data;
		 rom3address_r<={y_cnt,7'd0}+{y_cnt,5'd0}+x_cnt;
	    end
	else if(sw[3]==1'b1)	
	    begin
		 writeEn_r<=1'b1;
		 colour_r<=rom4data;
		 rom4address_r<={y_cnt,7'd0}+{y_cnt,5'd0}+x_cnt;
	    end
	else if(sw[4]==1'b1)	
	    begin
		 writeEn_r<=1'b1;
		 colour_r<=rom5data;
		 rom5address_r<={y_cnt,7'd0}+{y_cnt,5'd0}+x_cnt;
	    end
	else if(sw[5]==1'b1)	
	    begin
		 writeEn_r<=1'b1;
		 colour_r<=rom6data;
		 rom6address_r<={y_cnt,7'd0}+{y_cnt,5'd0}+x_cnt;
	    end
	else if(sw[6]==1'b1)	
	    begin
		 writeEn_r<=1'b1;
		 colour_r<=rom7data;
		 rom7address_r<={y_cnt,7'd0}+{y_cnt,5'd0}+x_cnt;
	    end
	else if(sw[7]==1'b1)	
	    begin
		 writeEn_r<=1'b1;
		 colour_r<=rom8data;
		 rom8address_r<={y_cnt,7'd0}+{y_cnt,5'd0}+x_cnt;
	    end
	   

		 
	end	 
		 
   end
	
	endmodule 