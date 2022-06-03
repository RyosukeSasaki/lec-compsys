module state(a, b, s, clk, rst);
	input a, b;
	output [1:0] s;
	input clk, rst;
	logic [1:0] s, ns;
	always @(posedge clk)
		if(rst) s <= 0;
		else s <= ns;
	always_comb begin
		ns = s;
		if(({a, b} == 2'b00) || ({a, b} == 2'b11))
			ns = s;
		else
			case(s)
			// synopsys full_case parallel_case
			2'b00: if(a) ns = 2'b01;
			2'b01:begin
				if(a) ns = 2'b11;
				if(b) ns = 2'b00;
			end
			2'b11: if(b) ns = 2'b01;
			endcase
	end
endmodule
