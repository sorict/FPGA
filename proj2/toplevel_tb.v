`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps


module toplevel_tb();

parameter clk_PERIOD = 40;
parameter br_PERIOD = 2760;
parameter DURATION = 100000;
reg clk = 0;
reg rst = 0;
reg serial_rx;
wire [7:0] serial_data = 8'b10100110;
integer i = 0;

top_level UUT (
	.clk(clk),
	.reset(rst),
	.s_data(serial_rx),
	.done(),
	.d_out()
);

initial begin

	$dumpfile(`DUMPSTR(`VCD_OUTPUT));
	$dumpvars(0,toplevel_tb);
	#(DURATION) $display("End of simulation");
	$finish;
end

initial begin
rst = 1'b1;
serial_rx = 1'b1;
#100;
rst = 1'b0;
#10000;

serial_rx <= 1'b0;
#br_PERIOD;
	for(i = 0; i < 7; i = i + 1)
	begin
		serial_rx <= serial_data[i];
		#br_PERIOD;
	end
serial_rx <= 1'b1;
end

always begin
#clk_PERIOD;
clk =~clk;
end
endmodule
