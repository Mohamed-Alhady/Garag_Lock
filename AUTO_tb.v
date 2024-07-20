module AUTO_GCD_tb();
reg up_max,activate, dn_max;
reg   clk, rst;
wire     up_m, dn_m;

initial  begin
$dumpfile("auto.vcd");
$dumpvars();
initialize();
reset();
test_values(6'b111110, 6'b100101,6'b011011);
#60
$stop;
end

task initialize;
begin
activate=1'b0;
up_max=1'b0;
dn_max=1'b0;
clk=1'b0;
end
endtask


task reset;
begin
rst=1'b1;
#10
rst=1'b0;
#10
rst=1'b1;
end
endtask

task test_values(
[5:0]activate0, up_max0, dn_max0

);
integer I;
begin
for(I=0;I<6;I=I+1) begin
activate=activate0[I];
@(negedge clk)
up_max=up_max0[I];
dn_max=dn_max0[I];
end
end
endtask
always #5 clk=~clk;
AUTO_GDC DUT(
.activate(activate),
.up_max(up_max),
.dn_max(dn_max),
.clk(clk),
.rst(rst),
.up_m(up_m),
.dn_m(dn_m)

);
endmodule