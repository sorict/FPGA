`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module toplevel_tb();

parameter DURATION = 100000;
reg clk = 0;
reg rst = 0;
reg [9:0] cmp;
wire [1:0] out;

pwm UUT(
	.clk(clk),
	.reset(rst),
	.cmp(cmp),
	.pwm(out)
	);
initial begin

	$dumpfile(`DUMPSTR(`VCD_OUTPUT));
	$dumpvars(0,toplevel_tb);
	#(DURATION) $display("End of simulation");
	$finish;
end

initial begin
cmp = 9'b100000000;
#100;
rst = 1'b1;
#100;
rst = 1'b0;
#30000
cmp =10'b1011111000;
end

always begin
#1;
clk =~clk;
end
endmodule
