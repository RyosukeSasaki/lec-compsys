`include "pu.vh"
module dmem( // Data Memory
	input [`MISB:0] ad,
	input [`WIDTH:0] wd,
	input we,
	input [9:0] pktin,
	output [9:0] pktout,
	output [`WIDTH:0] rd,
	input clk);
	logic [`WIDTH:0] rd;
	logic [9:0] pktout;
	logic [`WIDTH:0] dm [`DMS:0];
	always @* begin
		case(ad[`MISB]) :
		1'b0:
			rd = dm[ad];
		1'b1:
			case(ad[`MISB:0])
			8'h00:
				rd = {6'b0, pktin};
			endcase
		endcase
	end
	always @(posedge clk) begin
		if (ad(`MISB) == 1'b0)
			if(we) dm[ad[`DMSB:0]] <= wd;
		else begin
			if(we) begin
				if(ad[`DMSB:0] = 7'h00) begin
					//we to NIC
					pktout = wd[9:0];
				end
			end
		end
	end
endmodule
