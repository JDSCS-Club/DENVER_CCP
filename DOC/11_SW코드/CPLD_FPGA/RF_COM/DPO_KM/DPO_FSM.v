module DPO_V( //);
input rst, clk,
inout [3:0] dtmf_inout,
output reg dtmf_rs0, dtmf_cs, dtmf_rw,

input both_sw_in, ext_sw_in, int_sw_in,
input ic_sw_in, pei_sw_in, cancel_sw_in, occ_sw_in,
output reg occ_led, both_led, ext_led, int_led, ic_led, pei_led, cancel_led,
input hs_sw,
output reg mic_sw, live_sw, mute_sw, pa_sw1,
output reg pei_mute_sp, ic_mute_sp, dual_mute_sp,
output reg [3:0] txs_mic, rxs
);

wire reset = cancel_sw_in;
//MODE SIGNALS
reg int_mode; 
reg ext_mode;
reg both_mode;
reg pa_off;
reg intercom_mode;
reg intercom_off_mode;
reg pei_listen_mode;
reg pei_talk_mode;
reg cancel_mode; 
reg pei_call_mode;
reg occ_call_mode;
reg pei_wait;
reg pei_busy;
reg occ_pei_call;

reg [3:0] current_st, next_st;
reg tone_tx;

reg blink_sig;
reg [3:0] dtmf_inout_tx;
wire [3:0] dtmf_data;
wire dtmf_rx_mode = (dtmf_rw==1'b1 & dtmf_cs==1'b0 & dtmf_rs0==1'b0)? 1'b1 : 1'b0;

parameter idle_st = 4'b0001;
parameter ic_call_st =4'b0010;
parameter pei_call_st = 4'b0011;
parameter pei_wait_st = 4'b0100;
parameter pei_listen_st = 4'b0101;
parameter pei_talk_st = 4'b0110;
parameter cancel_st = 4'b0111;
parameter int_st = 4'b1000;
parameter ext_st = 4'b1001;
parameter both_st = 4'b1010;
parameter occ_call_st = 4'b1011;
parameter occ_pei_call_st = 4'b1100;

assign dtmf_inout = dtmf_rx_mode? 4'bzzzz : dtmf_inout_tx;
assign dtmf_data = dtmf_rx_mode? dtmf_inout: dtmf_data;

reg clk_1ms;
integer cnt, cntms, cnt_blink;
reg clear_cntms;

//1ms clock generation
always @(posedge clk or negedge reset)
   if (~reset) begin
	   cnt <= 0;
		clk_1ms <= 1'b0; end
	else begin
	   cnt <= cnt + 1;
		if (cnt==45000) begin
		   cnt <= 0;
			clk_1ms <= ~clk_1ms; end
	end
	
// BLINK SIGNAL
always @(posedge clk_1ms or negedge reset)
   if (~reset) begin
      cntms <= 0;
		cnt_blink <= 0;
      blink_sig <= 1'b1; end
   else begin
      cntms <= cntms + 1;
		cnt_blink <= cnt_blink + 1;
      if (cntms == 100) begin
		   cntms <= cntms;
			if (clear_cntms) begin
			   cntms <= 0; end 
		end
				
		if (cnt_blink == 300) begin
		   blink_sig <= ~ blink_sig;
			cnt_blink <= 0; 
		end
	end
	
assign clock = clk_1ms;      		
always @(posedge clock or negedge reset)
   if (~reset) current_st <= idle_st;
   else        current_st <= next_st;

always @(*)
   case (current_st)
      idle_st : begin
		// INT, EXT, BOTH MODE STATE
//		   if (int_mode) next_st <= int_st;
//			if (ext_mode) next_st <= ext_st;
//			if (both_mode) next_st <= both_st;
			if (intercom_mode) next_st <= ic_call_st;
			else if (pei_call_mode) next_st <= pei_call_st;
			else if (occ_call_mode) next_st <= occ_call_st;
			else if (occ_pei_call)  next_st <= occ_pei_call_st;
			else                    next_st <= idle_st;
		end
		
		ic_call_st : begin
		   if (intercom_off_mode) next_st <= cancel_st;
			else                   next_st <= ic_call_st;
		end
		
		pei_call_st : begin
		   if (pei_wait) next_st <= pei_wait_st;
			else          next_st <= pei_call_st;
		end
		
		pei_wait_st : begin
		   if (pei_listen_mode) next_st <= pei_listen_st;
			else                 next_st <= pei_wait_st;
		end
		
		pei_listen_st : begin
		   if (cancel_mode)        next_st <= cancel_st;
		   else if (pei_talk_mode) next_st <= pei_talk_st;
			else                    next_st <= pei_listen_st;
		end
		
		pei_talk_st : begin
		   if (cancel_mode) 		   next_st <= cancel_st;
			else if (pei_listen_mode) next_st <= pei_listen_st;
			else 			   next_st <= pei_talk_st;
		end
		
		cancel_st : begin
		   next_st <= idle_st;
		end
		
		int_st : begin
		   if (ext_mode)    next_st <= ext_st;
			else if (both_mode)   next_st <= both_st;
			else next_st <= int_st;
		end

		ext_st : begin
		   if (int_mode) next_st <= int_st;
			else if (both_mode) next_st <= both_st;
			else next_st <= ext_st;
		end

		both_st : begin
		   if (ext_mode) next_st <= ext_st;
			else if (int_mode) next_st <= int_st;
			else next_st <= both_st;
		end	
      
      occ_call_st : begin
      end
      occ_pei_call_st : begin
      end		
   endcase

always @(*) begin
// MODE INITIAL VALUE
int_mode <=1'b0; 
ext_mode <= 1'b0;
both_mode <=1'b0;
pa_off <= 1'b0;
intercom_mode <= 1'b0;
intercom_off_mode <= 1'b0;
pei_listen_mode <=1'b0;
pei_talk_mode <= 1'b0;
cancel_mode <= 1'b0; 
pei_call_mode <=1'b0;
occ_call_mode <= 1'b0;
pei_wait <= 1'b0;
pei_busy <= 1'b0;
occ_pei_call <= 1'b0;

//LED INITIAL VALUE
both_led <= 1'b1;
int_led <= 1'b1;
ext_led <= 1'b1;
ic_led <= 1'b1;
pei_led <= 1'b1;
cancel_led <= 1'b1;
occ_led <= 1'b1;

// DTMF RX MODE : Default
dtmf_rw <= 1'b0;
dtmf_cs <= 1'b0;
dtmf_rs0 <= 1'b0;

   case (current_st)
      idle_st : begin
//         both_led <= 1'b0;
			dtmf_rw <= 1'b1;
         dtmf_cs <= 1'b0;
         dtmf_rs0 <= 1'b0;
//         both_mode <= 1'b1;
			if ((dtmf_rx_mode==1'b1 && dtmf_data == 4'b0101) || (ic_sw_in == 1'b0))//dtmf_rx_mode==1'b0 && 
	         intercom_mode <= 1'b1;
				if (ic_sw_in==1'b0) begin//dtmf_rx_mode==1'b0 && 
				   dtmf_rw <= 1'b0; 
				   dtmf_inout_tx <= 4'b0101; end
			if (dtmf_rx_mode==1'b1 && dtmf_data == 4'b1010)
			   pei_call_mode <= 1'b1;
			if (dtmf_rx_mode==1'b1 && dtmf_data == 4'b1011)
			   occ_call_mode <= 1'b1;
			if (dtmf_rx_mode==1'b1 && dtmf_data == 4'b1110)
			   occ_pei_call <= 1'b1;			
		end
		ic_call_st : begin
		   ic_led <= 1'b0;
         dtmf_rw <= 1'b1;
         dtmf_cs <= 1'b0;
         dtmf_rs0 <= 1'b0;
				
         if ((dtmf_rx_mode==1'b1 && dtmf_data == 4'b0101) || (ic_sw_in == 1'b0))//dtmf_rx_mode==1'b0 && 
            intercom_off_mode <= 1'b1;
				if (ic_sw_in ==1'b0) begin//dtmf_rx_mode==1'b0 && 
				   dtmf_rw <= 1'b0;
					dtmf_inout_tx <= 4'b0101; end					
         else intercom_off_mode <= 1'b0;
		end

		pei_call_st : begin
		   pei_led <= 1'b0 | blink_sig;
         dtmf_rw <= 1'b1;
         dtmf_cs <= 1'b0;
         dtmf_rs0 <= 1'b0;
			if (pei_wait == 1'b0) begin
			   pei_wait <= 1'b1;
				dtmf_inout_tx <= 4'b1100;
				dtmf_rw <=1'b0; end
		end
		
		pei_wait_st : begin
		   pei_led <= 1'b0 | blink_sig;
         dtmf_rw <= 1'b1;
         dtmf_cs <= 1'b0;
         dtmf_rs0 <= 1'b0;
			if ((dtmf_rx_mode==1'b1 && dtmf_data==4'b0111) || (pei_sw_in==1'b0))//dtmf_rx_mode==1'b0 && 
			   pei_listen_mode <= 1'b1;
				if (pei_sw_in==1'b0) begin//dtmf_rx_mode==1'b0 && 
				   dtmf_inout_tx <= 4'b0111;
					dtmf_rw <= 1'b0; end
		end
		pei_listen_st : begin
		   pei_led <= 1'b0;
			cancel_led <= 1'b0;
         dtmf_rw <= 1'b1;
         dtmf_cs <= 1'b0;
         dtmf_rs0 <= 1'b0;
			
//			if (hs_sw==1'b0)
//			   pei_mute_sp <= 1'b1;
				
			if ((dtmf_rx_mode==1'b1 && dtmf_data==4'b1000) || ((pei_sw_in==1'b0 || hs_sw==1'b1 || pa_off==1'b0)))//dtmf_rx_mode==1'b0 && 
			   pei_talk_mode <= 1'b1;
				if (((pei_sw_in==1'b0 || hs_sw==1'b1 || pa_off==1'b0))) begin//dtmf_rx_mode==1'b0 && 
				   dtmf_inout_tx <= 4'b1000;
					dtmf_rw <= 1'b0; end
				/*else if (dtmf_rx_mode==1'b0 && (pei_sw_in==1'b1 || hs_sw==1'b0 || pa_off==1'b1)) begin
				   dtmf_inout_tx <= 4'b0111;
					dtmf_rw <= 1'b0; 
					pei_listen_mode <= 1'b1; end*/
			else if ((dtmf_rx_mode==1'b1 && dtmf_data==4'b1001) || (cancel_sw_in==1'b0))//dtmf_rx_mode==1'b0 && 
			   cancel_mode <= 1'b1;
				if (cancel_sw_in==1'b0) begin//dtmf_rx_mode==1'b0 && 
				   dtmf_inout_tx <= 4'b1001;
					dtmf_rw <= 1'b0; end
      end
		pei_talk_st : begin
		   pei_led <= 1'b0 | blink_sig;
			cancel_led <= 1'b0;
         dtmf_rw <= 1'b1;
         dtmf_cs <= 1'b0;
         dtmf_rs0 <= 1'b0;
			if ((dtmf_rx_mode==1'b1 && dtmf_data==4'b0111) || ((pei_sw_in==1'b0 || pa_off==1'b0)))//dtmf_rx_mode==1'b0 && 
			   pei_listen_mode <= 1'b1;
				if (((pei_sw_in==1'b0 || pa_off==1'b0))) begin//dtmf_rx_mode==1'b0 && 
				   dtmf_inout_tx <= 4'b0111;
					dtmf_rw <= 1'b0; end
			else if ((dtmf_rx_mode==1'b1 && dtmf_data==4'b1001) || (cancel_sw_in==1'b0))//dtmf_rx_mode==1'b0 && 
			   cancel_mode <= 1'b1;
				if (cancel_sw_in==1'b0) begin//dtmf_rx_mode==1'b0 && 
				   dtmf_inout_tx <= 4'b1001;
					dtmf_rw <= 1'b0; end
		end
		cancel_st : begin
		   both_led <= 1'b0;
		end
		
//		int_st : begin
//		   int_led <= 1'b0;
//		end
//   	ext_st : begin
//		   ext_led <= 1'b0;
//		end
//		both_st : begin
//		   both_led <= 1'b0;
//		end		
      occ_call_st : begin
		   occ_led <= 1'b0 | blink_sig;
      end
      occ_pei_call_st : begin
		   occ_led <= 1'b0 | blink_sig;
      end		
	endcase
	
	if (int_sw_in == 1'b0) begin//dtmf_rx_mode==1'b0 && 
	   int_mode <= 1'b1;
		ext_mode <=1'b0;
		both_mode <= 1'b0;
		int_led <= 1'b0;
		ext_led <= 1'b1;
		both_led <=1'b1;
		mute_sw <= 1'b1; end
//		if (int_sw_in == 1'b0) begin//dtmf_rx_mode==1'b0 && 
//		   dtmf_rw <= 1'b0;
//		   dtmf_inout_tx <= 4'b0001; end
   else if (ext_sw_in == 1'b0) begin//dtmf_rx_mode==1'b0 && 
	   int_mode <= 1'b0;
		ext_mode <=1'b1;
		both_mode <= 1'b0;
		int_led <= 1'b1;
		ext_led <= 1'b0;
		both_led <=1'b1;
		mute_sw <= 1'b1; end
//		if (ext_sw_in == 1'b0) begin//dtmf_rx_mode==1'b0 && 
//		   dtmf_inout_tx <= 4'b0010;
//			dtmf_rw <= 1'b0; end
	else if (both_sw_in == 1'b0) begin//dtmf_rx_mode==1'b0 && 
	   int_mode <= 1'b0;
		ext_mode <=1'b0;
		both_mode <= 1'b1;
		int_led <= 1'b1;
		ext_led <= 1'b1;
		both_led <=1'b0;
		mute_sw <= 1'b1; end
//		if (both_sw_in == 1'b0) begin//dtmf_rx_mode==1'b1 && 
//		   dtmf_inout_tx <= 4'b0011;
//			dtmf_rw <= 1'b0; end
//	else both_mode <= 1'b0;
   else mute_sw <= 1'b0;

   if (int_mode ==1'b1) begin
	   dtmf_inout_tx <= 4'b0001;
		dtmf_rw <= 1'b0;
		dtmf_rs0 <= 1'b0;
		dtmf_cs <= 1'b0; end
	else    if (ext_mode ==1'b1) begin
	   dtmf_inout_tx <= 4'b0010;
		dtmf_rw <= 1'b0;
		dtmf_rs0 <= 1'b0;
		dtmf_cs <= 1'b0; end
	else    if (both_mode ==1'b1) begin
	   dtmf_inout_tx <= 4'b0011;
		dtmf_rw <= 1'b0;
		dtmf_rs0 <= 1'b0;
		dtmf_cs <= 1'b0; end
	
	if (hs_sw == 1'b1) begin//dtmf_rx_mode==1'b0 && 
	   pa_off <= 1'b1;
		if (hs_sw == 1'b1) begin//dtmf_rx_mode==1'b0 && 
		   dtmf_inout_tx <= 4'b0100;
			dtmf_rw <= 1'b0; end
	end
	else pa_off <= 1'b0;//hs_sw==1'b0
//end

//always @(*)
   if (hs_sw==1'b0) begin
	   mic_sw <= 1'b0;
		live_sw <= 1'b1;
		mute_sw <= 1'b0;
		pa_sw1 <= 1'b1;
		if (cntms >= 90)
		   live_sw <= 1'b0; 
	end
	else begin
	   mic_sw <= 1'b0;
		clear_cntms <= 1'b1;
		mute_sw <= 1'b1;
		pa_sw1 <= 1'b0;
	end
end

always @(posedge clk_1ms or negedge reset)
   if (~reset)
	   tone_tx <=1'b0;
	else begin
	   if ((live_sw || int_mode || ext_mode || both_mode) && (~tone_tx))
	      tone_tx <= 1'b1;
	   if (tone_tx==1'b1)
		   if (cntms==99) begin
			   tone_tx <= 1'b0;
				dual_mute_sp <= 1'b1; end
	end
	
always @(*) begin
   if (both_mode || ext_mode || int_mode)
	   txs_mic <= 4'b0100;
	if (intercom_mode) begin
	   ic_mute_sp <= 1'b0;
		txs_mic <= 4'b0011;
		rxs <= 4'b0011;
//		pa_sw1 <= 1'b0; 
   end
	else begin
	   ic_mute_sp <= 1'b1;
//		pa_sw1 <= 1'b1; 
   end
	if (pei_listen_mode) begin
	   pei_mute_sp <= 1'b0;
		txs_mic <= 4'b0111;
		rxs <= 4'b0111;
//		pa_sw1 <= 1'b0; 
   end
	else begin
	   pei_mute_sp <= 1'b1;
//		pa_sw1 <= 1'b1; 
   end
	if (cancel_mode) begin
	   txs_mic <= 4'b0001;
		rxs <= 4'b0001; end
end		
endmodule
