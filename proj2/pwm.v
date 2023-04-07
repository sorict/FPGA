module pwm #(parameter PWM_CNT = 10)
	(
	    input clk,
	    input reset,
	    input [PWM_CNT-1:0] cmp,
	    output reg pwm
	);

	reg [PWM_CNT-1:0] cnt_a, cnt_b;
	reg pwm_out;
	
	always @(posedge clk) begin
		cnt_a = cnt_b + 1'b1;
	
	        if (cmp > cnt_b)
		    pwm <= 1'b1;
		else
		    pwm <= 1'b0;
	end
	
	always @(posedge clk) begin
	      if(reset == 1'b1) begin
		cnt_b <= 1'b0;
	     end
	     else begin
		cnt_b <= cnt_a;
	    end
	end

endmodule
