module sw_debounce(
      clk,rst_n,
      sw1_n,sw2_n,sw3_n,
		swout
      
      );



input   clk; //主时钟信号，50MHz
input   rst_n; //复位信号，低有效
input   sw1_n,sw2_n,sw3_n;  //三个独立按键，低表示按下
output [2:0] swout;



//---------------------------------------------------------------------------
reg[2:0] key_rst;  



always @(posedge clk  or negedge rst_n)
    if (!rst_n) key_rst <= 3'b111;
    else key_rst <= {sw3_n,sw2_n,sw1_n};



reg[2:0] key_rst_r;       //每个时钟周期的上升沿将low_sw信号锁存到low_sw_r中



always @ ( posedge clk  or negedge rst_n )
    if (!rst_n) key_rst_r <= 3'b111;
    else key_rst_r <= key_rst;
   
//当寄存器key_rst由1变为0时，led_an的值变为高，维持一个时钟周期 
wire[2:0] key_an = key_rst_r & ( ~key_rst);



//---------------------------------------------------------------------------
reg[19:0]  cnt; //计数寄存器



always @ (posedge clk  or negedge rst_n)
    if (!rst_n) cnt <= 20'd0; //异步复位
 else if(key_an) cnt <=20'd0;
    else cnt <= cnt + 1'b1;
  
reg[2:0] low_sw;



always @(posedge clk  or negedge rst_n)
    if (!rst_n) low_sw <= 3'b111;
    else if (cnt == 20'hfffff)  //满20ms，将按键值锁存到寄存器low_sw中  cnt == 20'hfffff
      low_sw <= {sw3_n,sw2_n,sw1_n};
      
//---------------------------------------------------------------------------
reg  [2:0] low_sw_r;       //每个时钟周期的上升沿将low_sw信号锁存到low_sw_r中



always @ ( posedge clk  or negedge rst_n )
    if (!rst_n) low_sw_r <= 3'b111;
    else low_sw_r <= low_sw;
   
//当寄存器low_sw由1变为0时，swout的值变为高，维持一个时钟周期 
assign  swout = low_sw_r[2:0] & ( ~low_sw[2:0]);




  
endmodule
