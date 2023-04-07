module clk_div
#( parameter CNT = 33554432)

	(
	input clk,
	input rst,
	output reg out
	);

reg div_clk;
reg [32:0] cnt;

always @(posedge clk or posedge rst) begin
	if(rst == 1'b1) begin
	   cnt <= 0;
	   out <= 0;
	 end
	 else if (cnt == CNT) begin
	   cnt <= 0;
	   out <= ~out;
	 end
	 else begin
           cnt <= cnt + 1;
	 end
end

endmodule
