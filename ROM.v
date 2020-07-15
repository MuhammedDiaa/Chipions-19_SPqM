module ROM ( wtime , pcount, tcount ,clk );	 

parameter n =3 ;

output reg [4:0]wtime;  
/*max value of wtime from eqn in case of 3-bits counter is 21 (can be hold in 5bit reg of max value 31)
and the size of the rom is also 5-bits
*/
input wire [n-1:0] pcount ;
input wire [1:0] tcount ;
input wire clk ;
wire [n+1:0] address ;
assign address[n+1:0] = { tcount[1:0] ,pcount[n-1:0] } ; //concatenating tcount(MSBs) and pcount(LSBs) to serve as address to the ROM
reg [4:0]rom [0:31] ; //rom is of 5-bits width with diffferent 32 places ,so we can store 32 values for wtime each of max value 31.

//wtime==> waiting time 

always @(posedge clk) // refreshing the value of wtime every clk cycle according to the current values of counter and tellers.
begin
wtime <= rom[address] ;
end

initial 
begin // for tcount =00 ,don't care case, wtime is set to be 0.
rom[0] <= 5'd0 ;
rom[1] <= 5'd0 ;
rom[2] <= 5'd0 ;
rom[3] <= 5'd0 ;
rom[4] <= 5'd0 ;
rom[5] <= 5'd0 ;
rom[6] <= 5'd0 ;
rom[7] <= 5'd0 ;
rom[8] <= 5'd0 ;
rom[9] <= 5'd3 ;
rom[10] <= 5'd6 ;
rom[11] <= 5'd9 ;
rom[12] <= 5'd12 ;
rom[13] <= 5'd15 ;
rom[14] <= 5'd18 ;
rom[15] <= 5'd21 ;
rom[16] <= 5'd1 ;
rom[17] <= 5'd3 ;
rom[18] <= 5'd4 ;
rom[19] <= 5'd6 ;
rom[20] <= 5'd7 ;
rom[21] <= 5'd9 ;
rom[22] <= 5'd10 ;
rom[23] <= 5'd12 ;
rom[24] <= 5'd2 ;
rom[25] <= 5'd3 ;
rom[26] <= 5'd4 ;
rom[27] <= 5'd5 ;
rom[28] <= 5'd6 ;
rom[29] <= 5'd7 ;
rom[30] <= 5'd8 ;
rom[31] <= 5'd9 ;
end 


endmodule 


module rom_tb ();

parameter n =3 ;
 wire [4:0] wtime;  
reg[4:0]i ; 
reg [n-1:0] pcount ;
reg [1:0] tcount ;
reg clk ;
initial 
begin
i =5'b0 ;
clk =0 ;
$monitor ("%b %b  .. wtime= %d", tcount,pcount,wtime);

end

always
    begin 
#4
	 pcount=i&3'b111;
         tcount=i>>n ;
i=i+1 ;
      //  if (tcount == 0) continue;
        
    end

always 
begin 
#2 clk = ~clk ;
end


ROM rm ( wtime , pcount, tcount ,clk );	
endmodule 