module top_level
	(
	input clk,
	input reset,
	input s_data,
	output done,
	output [7:0] d_out
	);

wire clk_w;

clk_div #(.CNT(16)) div1
	(.clk(clk),
	 .rst(reset),
	 .out(clk_w)
);

uart_rx uart1 (
	.clk_br(clk_w),
	.serial_data(s_data),
	.rx_done(done),
	.out(d_out)
);


endmodule
