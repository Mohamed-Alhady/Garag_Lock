module AUTO_GDC(
input up_max,activate, dn_max,
input clk, rst,
output reg up_m, dn_m
);

localparam idle= 2'b00, S10=2'b01, S01=2'b10;
reg current_state, next_state;

always @(posedge clk, negedge rst) begin
if(!rst)
current_state<=idle;
else
current_state<=next_state;
end

always @(*) begin
case(current_state)
	idle:	begin
		if(activate && dn_max && !up_max)
		next_state<= S10;
		else if(!activate)
		next_state<=idle;
		else if (activate && up_max && !dn_max)
		next_state<=S01;
		else
		next_state<=idle;
		end
	S10:	begin
			if(up_max)
			next_state<=idle;
			else
			next_state<=S10;
			end
	
	S01:	begin
			if(dn_max)
			next_state<=idle;
			else
			next_state<=S01;
			end
	default: next_state<=idle;
endcase	
	
end

always @(*) begin
case(current_state)
idle:	begin
		up_m<=1'b0;
		dn_m<=1'b0;
		end
S10:	begin
		up_m<=1'b1;
		dn_m<=1'b0;
		end
S01:    begin
		up_m<=1'b0;
		dn_m<=1'b1;
		end
default: begin
			up_m<=1'b0;
			dn_m<=1'b0;
			end
endcase			
end
endmodule