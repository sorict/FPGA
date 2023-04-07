module top_level
	(
	input clk,
	input reset,
	output [1:0] out
	);

clk_div #(.CNT(33554432)) div1
	(.clk(clk),
	 .rst(reset),
	 .out(out[0])
);

//clk_div #(.CNT(33554432*2)) div2
//	(.clk(clk),
//	 .rst(reset),
//	 .out(out[1])
//);

endmodule
