module lidx(
	input [15:0] b,
	output [15:0] lb,
	input lh, ll,
	input [7:0] iv);
	logic [15:0] lb;
	always_comb begin
		case({lh,ll})
		// synopsys full_case parallel_case
		2'b10: lb = {iv, b[7:0]};
		2'b01: lb = {b[15:8], iv};
		2'b11: lb = {8'b00000000, iv};
		default: lb = b;
		endcase
	end
endmodule
