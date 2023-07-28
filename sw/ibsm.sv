`include "sw.vh"
module isbm(input [1:0] pout, output logic re, input empty,
	input [`PORT:0] reqi, output logic [`PORT:0] req, input ack, input clk, rst);
	typedef enum {INIT='b00, AREQ='b01, XFER='b10} ISBMTYPE;
	ISBMTYPE state, nstate;

	always @(posedge clk) begin
		if (rst) state <= INIT;
		else state <= nstate;
	end
	always_comb begin
		nstate = state;
		req = reqi;
		re = `NEGATE;
		case (state)
		// synopsys full_case parallel_case
		INIT: begin
			req = 0;
			if (pout == `HEAD) begin
				nstate = AREQ;
			end
		end
		AREQ: begin
			if (ack == `ASSERT) begin
				nstate = XFER;
				re = `ASSERT;
			end
		end
		XFER: begin
			re = `ASSERT;
			if (pout == `TAIL) begin
				nstate = INIT;
				re = `ASSERT;
				req = 0;
			end else begin
			end
		end
		endcase
	end

endmodule
