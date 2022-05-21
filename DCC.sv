module DCC (
	input             CLK,
	input             RST_N,
	input             CE_R,
	input             CE_F,
	
	input             RES_N,
	
	input      [24:1] A,
	input             BS_N,
	input             CS0_N,
	input             CS1_N,
	input             CS2_N,
	input             RD_WR_N,
	input       [1:0] WE_N,
	input             RD_N,
	output            WAIT_N,
	
	output            BRLS_N,
	input             BGR_N,
	input             BREQ_N,
	output            BACK_N,
	input             EXBREQ_N,
	output            EXBACK_N,
	
	input             WTIN_N,
	input             IVECF_N,
	
	input             HINT_N,
	input             VINT_N,
	output      [2:1] IREQ_N,
	
	output reg        MFTI,
	output reg        SFTI,
	
	output            DCE_N,
	output            DOE_N,
	output      [1:0] DWE_N,
	
	output            ROMCE_N,
	output            SRAMCE_N,
	output            SMPCCE_N,
	output            MOE_N,
	output            MWR_N
);

	bit SSH_ACTIVE;
	bit SCU_ACTIVE;
	always @(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			SSH_ACTIVE <= '0;
			SCU_ACTIVE <= 0;
		end else if (CE_R) begin
			if (!BREQ_N && !SSH_ACTIVE && !SCU_ACTIVE) SSH_ACTIVE <= 1;
			else if (BREQ_N && SSH_ACTIVE) SSH_ACTIVE <= 0;
			
			if (!EXBREQ_N && BREQ_N && !SCU_ACTIVE && !SSH_ACTIVE) SCU_ACTIVE <= 1;
			else if (EXBREQ_N && SCU_ACTIVE) SCU_ACTIVE <= 0;
		end
	end
	assign BRLS_N = (BREQ_N | ~SSH_ACTIVE) & (EXBREQ_N | ~SCU_ACTIVE);
	assign BACK_N = BGR_N | ~SSH_ACTIVE;
	assign EXBACK_N = BGR_N | ~SCU_ACTIVE;
	
//	always @(posedge CLK or negedge RST_N) begin
//		if (!RST_N) begin
//			SSH_ACTIVE <= '0;
//			SCU_ACTIVE <= 0;
//		end else if (CE_R) begin
//			if (!BREQ_N && EXBREQ_N && !SSH_ACTIVE && !SCU_ACTIVE) SSH_ACTIVE <= 1;
//			else if (BREQ_N && SSH_ACTIVE) SSH_ACTIVE <= 0;
//			
//			if (!EXBREQ_N /*&& BREQ_N*/ && !SCU_ACTIVE /*&& !SSH_ACTIVE*/) SCU_ACTIVE <= 1;
//			else if (EXBREQ_N && SCU_ACTIVE) SCU_ACTIVE <= 0;
//		end
//	end
//	assign BRLS_N = (BREQ_N | ~SSH_ACTIVE) & (EXBREQ_N | ~SCU_ACTIVE);
//	assign BACK_N = BGR_N | ~SSH_ACTIVE | SCU_ACTIVE;
//	assign EXBACK_N = BGR_N | ~SCU_ACTIVE;
	
	assign WAIT_N = WTIN_N;///////////////////////
	
	assign IREQ_N = {VINT_N,VINT_N&HINT_N};////////////////
	
	assign ROMCE_N = ~(A[24:20] == 5'b00000) | CS0_N;
	assign SMPCCE_N = ~(A[24:19] == 6'b000010) | CS0_N;
	assign SRAMCE_N = ~(A[24:19] == 6'b000011) | CS0_N;
	assign MOE_N = RD_N;
	assign MWR_N = WE_N[0];
	
	
	assign DCE_N = ~(A[24:21] == 4'b0001) | CS0_N;
	assign DOE_N = RD_N;
	assign DWE_N = WE_N;
	
	wire MINIT_SEL = (A[24:23] == 2'b10) & ~CS0_N;
	wire SINIT_SEL = (A[24:23] == 2'b11) & ~CS0_N;
	always @(posedge CLK or negedge RST_N) begin
		bit WE_N_OLD;
		
		if (!RST_N) begin
			MFTI = 1;
			SFTI = 1;
		end else if (!RES_N) begin
			MFTI = 1;
			SFTI = 1;
		end else if (CE_R) begin
			MFTI = 1;
			SFTI = 1;
			
			WE_N_OLD <= &WE_N;
			if (!(&WE_N) && WE_N_OLD) begin
				if (SINIT_SEL) MFTI <= 0;
				if (MINIT_SEL) SFTI <= 0;
			end
		end
	end

endmodule
