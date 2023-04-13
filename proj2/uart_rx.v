module uart_rx (
	input clk_br,
	input serial_data,
	output wire rx_done,
	output wire [7:0] out
);

parameter s_IDLE = 3'b000;
parameter s_DATA = 3'b001;
parameter s_STOP = 3'b010;
//parameter s_CLEN = 3'b011;

reg [2:0] bit_pos = 0;
reg [7:0] rx_reg = 0;
reg [2:0] s_current = 0;
reg rx_d = 0;
reg rx_bit;

always @(posedge clk_br)
	begin
		rx_bit <= serial_data;
	end


always @(posedge clk_br)
	begin
	case (s_current)
	s_IDLE:
		begin
		bit_pos <= 0;
		if (rx_bit == 1'b0)
			s_current <= s_DATA;
		else
			s_current <= s_IDLE;
		end
	s_DATA:
		begin
		bit_pos <= 1'b1;
		rx_reg[bit_pos] <= rx_bit;
		if (bit_pos < 7)
			begin
				bit_pos <= bit_pos + 1'b1;
				s_current <= s_DATA;
			end
		else
			begin
				bit_pos <= 0;
				s_current <= s_STOP;
			end
		end
	s_STOP:
		begin
		rx_d <= 1'b1;
		s_current <= s_IDLE;
		end
//	s_CLEAN:
//		begin
//		rx_reg <= 8'b00000000;
//		rx_d <= 1'b0;
//		s_current <= s_IDLE;
//		end
	default:
		s_current <= s_IDLE;
	endcase
end

	assign out = rx_reg;
	assign rx_done = rx_d;

endmodule
