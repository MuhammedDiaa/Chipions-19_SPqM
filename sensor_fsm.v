module photocell_fsm (out_pulse,sensor_in,clk,reset);
output reg out_pulse ;
input wire sensor_in, reset, clk;
reg state;
parameter A=0, B=1;
always@(posedge clk)
begin
if (reset == 1) 
	begin 
	state <= A;
	out_pulse<=0;
	end
else 
	begin
		case (state)	
		A: if (sensor_in == 1)begin  
					state <=A ;
					out_pulse <=0; end 
			else begin 
					state<=B;
					out_pulse<=0 ; end 
		
		B: if (sensor_in == 1)begin  
					state <=A;
					out_pulse <=1; end 
			else begin 
					state<=B;
					out_pulse<=0 ; end 

		endcase

	end // end of else 

end // end of always block
endmodule

module photo_fsm_tb();
wire out ;
reg reset, clk,photo;
reg [63:0]test ;
 photocell_fsm tt (out,photo,clk,reset);

always 
begin 
#2 clk= ~clk;
end

initial
begin
clk=0;
photo=1;
reset=1;
test= 64'b11101110000111;
#5
reset=0;


end


always
begin
#4
photo = test[0];
test=test>>1;

end

endmodule
