library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dpo is
    Port (
			rst : in STD_LOGIC;
			clk : in STD_LOGIC;

			dtmf_inout : inout  STD_LOGIC_VECTOR (3 downto 0);
			dtmf_rs0 : buffer STD_LOGIC;
			dtmf_cs : buffer STD_LOGIC;
			dtmf_rw : buffer STD_LOGIC;

			both_sw_in : in STD_LOGIC;
			ext_sw_in : in STD_LOGIC;
			int_sw_in : in STD_LOGIC;

			ic_sw_in : in STD_LOGIC;
			pei_sw_in : in STD_LOGIC;
			cancel_sw_in : in STD_LOGIC;
			occ_sw_in : in std_logic; -- PEI CALL SW
         occ_led : out std_logic; --for hs_sw status
			both_led : out STD_LOGIC;
			ext_led : out STD_LOGIC;
			int_led : out STD_LOGIC;
			ic_led : out STD_LOGIC;
			pei_led : buffer STD_LOGIC;
			cancel_led : out STD_LOGIC;
			
			hs_sw : in STD_LOGIC;
			mic_sw : out STD_LOGIC;
			live_sw : out STD_LOGIC;
			mute_sw : out STD_LOGIC;
			pa_sw1 : out STD_LOGIC;
			
			pei_mute_sp : out STD_LOGIC;
			ic_mute_sp : out STD_LOGIC;
			dual_mute_sp : out STD_LOGIC;
--			txs4 : out STD_LOGIC;
--			txs3 : out STD_LOGIC;
			txs_mic : out  STD_LOGIC_VECTOR (3 downto 0);
			rxs : out  STD_LOGIC_VECTOR (3 downto 0)
		);
end dpo;

architecture Behavioral of dpo is

	signal cnt : STD_LOGIC_VECTOR(15 downto 0);
	signal cnt1ms : STD_LOGIC;
	signal cntms : STD_LOGIC_VECTOR(8 downto 0);
	
	signal int_mode, ext_mode, both_mode, ptt_mode1, ptt_mode2  : STD_LOGIC;
	
	signal dtmf_in, dtmf_inout_sp : STD_LOGIC_VECTOR(3 downto 0);
	
	signal need_cs, init_set, tone_tx : STD_LOGIC;
	signal delay_mic1, delay_mic2, delay_mic3, delay_mic4 : STD_LOGIC;
	
	signal ic_call_mode, ic_rx_mode, pei_call_mode, cancel_mode : STD_LOGIC;
   
type state_type is (idle, pei_call, pei_wait, dpo_rx, pei_rx, cancel, ic_call, ic_rx);
signal current_st, next_st : state_type;
signal blink_cnt : std_logic_vector(9 downto 0);
signal blink_sig : std_logic;
signal pei_mode : std_logic;
signal intercom_mode : std_logic;
signal pei_talk_mode : std_logic;
signal dtmf_receive_mode : std_logic_vector(2 downto 0);
signal reset : std_logic;
signal clk_1m : std_logic;
signal cnt_1m : std_logic_vector(5 downto 0);
signal pa_off : std_logic;
signal pei_listen_mode : std_logic;
signal intercom_off_mode : std_logic;
signal occ_call_mode : std_logic;
signal pei_wait_mode, pei_busy, occ_pei_call : std_logic;
signal clear_cntms : std_logic;
signal cnt_tone : std_logic_vector(6 downto 0);

begin
reset <= cancel_sw_in;
-- 1ms clock generation process
process (reset, clk) begin
	if reset = '0' then
		cnt <= (others => '0');
		cnt_1m <= (others=>'0');
		cnt1ms <= '0';
		clk_1m <= '0';
	elsif clk'event and clk = '1' then
		cnt <= cnt + 1;
		if cnt_1m = 45 then
		   clk_1m <= not clk_1m;
			cnt_1m <= (others=>'0');
		end if;
		if cnt = 45000 then
			cnt <= (others => '0');
			cnt1ms <= not cnt1ms;
		end if;
	end if;
end process;

-- State Transition process & blink signal generation
process (reset, cnt1ms)
begin
   if (reset = '0') then
      current_st <= idle;
      blink_cnt <= (others => '0');
      blink_sig <= '1';
		cntms <= (others=>'0');
		cnt_tone <= (others=> '0');
   elsif cnt1ms'event and cnt1ms='1' then
      current_st <= next_st;
      blink_cnt <= blink_cnt + 1;
		cntms <= cntms + 1;
		cnt_tone <= cnt_tone + 1;
		
		if (blink_cnt=300) then
         blink_sig <= not blink_sig;
			blink_cnt <= (others => '0');
		end if;
		if (cntms = 100) then
		   cntms <= cntms;
		end if;
		if (clear_cntms ='1') then
		   cntms <=(others=>'0');
		end if;
		if (cnt_tone = 104) then
		   cnt_tone <= (others=>'0');
		end if;
   end if;
end process;

-- Decode the DTMF Data
dtmf_receive_mode <= dtmf_rw & dtmf_cs & dtmf_rs0;
dtmf_in <= dtmf_inout when (dtmf_receive_mode = "100") else dtmf_in;

--process(dtmf_rw, dtmf_inout_sp)
--begin
--   if (dtmf_rw = '0') then
--	   dtmf_inout <= dtmf_inout_sp;
--	else 
--	   dtmf_inout <= "ZZZZ";
--	end if;
--end process;

process (reset, cnt1ms, ptt_mode1, ptt_mode2, tone_tx, current_st, pei_sw_in, delay_mic2, 
delay_mic4, both_mode, ext_mode, int_mode, ic_call_mode, ic_rx_mode, intercom_mode, pei_call_mode, 
pei_talk_mode, cancel_mode, blink_sig, dtmf_in, both_sw_in, ext_sw_in, int_sw_in)
begin
   if (reset ='0')then
-- Mode Setting
      cancel_mode <= '0';
      pei_mode <= '0';
      intercom_mode <= '0';
      both_mode <= '0';
      ext_mode <= '0';
      int_mode <= '0';
      pei_call_mode <= '0';
      pei_talk_mode <= '0';

      mute_sw <= '0';
-- LED Setting		
      both_led <= '0';--ON
      ext_led <= '1'; --OFF
      int_led <= '1'; --OFF
   	pei_led  <= '1';--OFF
      ic_led   <= '1';--OFF
      cancel_led <= '1';--OFF
		occ_led <='1';
		
-- DTMF Data Mode Setting		
		dtmf_cs <= '0';
		dtmf_rw <= '0';
		dtmf_rs0 <= '1';
		dtmf_inout <= "0001";

		mic_sw <= '1';
		live_sw <= '1';
		pa_sw1 <= '1';
		
		pei_mute_sp <= '1';
		ic_mute_sp <= '1';
		dual_mute_sp <= '1';
		
		txs_mic <= "1111";
		rxs <= "1110";
		
		init_set <= '0';
		tone_tx <= '0';
		need_cs <= '0';

   else
	   if (cnt1ms'event and cnt1ms='1') then
			if init_set = '0' then
				if cntms = 1 then
--					dtmf_rs0 <= '0';
					init_set <= '1';
				end if;
			end if;
				
			if tone_tx = '1' then
				if cnt_tone = 1 then
--					live_sw <= '0';
				elsif cnt_tone = 24 then
					tone_tx <= '0';
--					dtmf_rs0 <= '0';
--					dtmf_rw <= '1';
--               live_sw <= '1';
					dual_mute_sp <= '1';
				end if;
			end if;
			
			if need_cs = '1' then
				if cntms = 10 and dtmf_cs = '0' then
--					dtmf_cs <= '1';
				elsif cntms = 20 and dtmf_cs = '1' then
--					dtmf_cs <= '0';
					need_cs <= '0';
				end if;
			end if;
				
			if hs_sw = '0' then --ON
				mic_sw	<= '0';	--OFF
--				occ_led <= '1'; -- for hs_sw status
            live_sw <= '1';
				if (cntms >= 90) then
				   live_sw <= '0';
				end if;
			else                    --OFF
				mic_sw	<= '1';	--ON
				clear_cntms <= '1';
--				occ_led <= '0';
			end if;
					
			delay_mic1 <= not hs_sw;
			delay_mic2 <= delay_mic1 and  hs_sw;	
			delay_mic3 <= hs_sw;			
			delay_mic4 <= delay_mic3 and not hs_sw;
	end if;	-- End of Clock Event Operation 

   if (init_set='0' and cntms=1) then
	   dtmf_rs0 <= '0';
	elsif (tone_tx='1' and cntms=24) then
	   dtmf_rs0 <= '1';
		dtmf_rw <= '1';
   elsif (need_cs ='1' and cntms=10 and dtmf_cs='0') then
	   dtmf_cs <= '1';
	elsif (need_cs ='1' and cntms=20 and dtmf_cs='1') then
	   dtmf_cs <= '0';
   end if;
	
-- Start of Non-Clock event Operation
	if ( int_mode='1' or ext_mode='1' or both_mode ='1' or ptt_mode1 = '1' or ptt_mode2 = '1' ) then--and tone_tx = '0' then
	   tone_tx <= '1';
		if (tone_tx ='1') then
		   if (cnt_tone =104) then
			   tone_tx <= '0';
			end if;
		end if;
	end if;
	
	if (delay_mic2 = '1') then
			ptt_mode1 <= '1';
			dtmf_inout <= "0101";--changed from dtmf_inout to dtmf_inout_sp
			dtmf_rs0 <= '0';
			dtmf_rw <= '0';
			dtmf_cs <= '0';
			need_cs <= '1';
			dual_mute_sp <= '0';
	else
			ptt_mode1 <= '0';
	end if;
			
		if delay_mic4 = '1' then
			ptt_mode2 <= '1';
			dtmf_inout <= dtmf_inout_sp;
			dtmf_rs0 <= '0';
			dtmf_rw <= '0';
			dtmf_cs <= '0';
			need_cs <= '1';
			dual_mute_sp <= '0';
		else 
			ptt_mode2 <= '0';
		end if;
		
		if (both_mode = '1' or ext_mode = '1' or int_mode = '1') then
			txs_mic <= "0100";
		end if;
		
		if (ic_call_mode = '1' or intercom_mode='1' or ic_rx_mode ='1') then--ic_rx_mode = '1') then
			ic_mute_sp <= '0';
			txs_mic <= "0011";
			rxs <= "0011";
			pa_sw1 <= '0';
		else
			ic_mute_sp <= '0';
			pa_sw1 <= '1';
		end if;
		
		if (pei_call_mode = '1' or pei_talk_mode = '1') then
			pei_mute_sp <= '0';
			txs_mic <= "0111";
			rxs <= "0111";
			pa_sw1 <= '0';
		else
			pei_mute_sp <= '0';
			pa_sw1 <= '1';
		end if;

		if (cancel_mode = '1') then
			txs_mic <= "0001";
			rxs <= "0001";
		end if;	
	
      case (current_st) is
         when idle => 
   	   	pei_led  <= '1';--OFF
            ic_led   <= '1';--OFF
            cancel_led <= '1';--OFF
				occ_led <= '1';--OFF
				
				dtmf_rs0 <= '0';
				dtmf_cs <= '0';
				dtmf_rw <= '1';
				
         when pei_call =>
            pei_led  <= '1' and blink_sig;-- blink_sig;--ON
            ic_led   <= '1';--OFF
            cancel_led <= '1';--OFF
				occ_led <= '1' and blink_sig;
				
				dtmf_rw <= '0';
				dtmf_cs <= '0';
				dtmf_rs0 <= '0';--not dtmf_rs0;

				if (pei_call_mode = '1') then
				   pei_call_mode <= '0';
				end if;
				
         when pei_wait =>
            pei_led  <= '1' and blink_sig;--Flashing
            ic_led   <= '1';--OFF
            cancel_led <= '1';--OFF
            occ_led  <= '1' and blink_sig;--Flashing

         when dpo_rx=>
            pei_led  <= '0';--ON
            ic_led   <= '1';--OFF
            cancel_led <= '0';--ON
            occ_led  <= '1';--OFF
				
				if (pei_sw_in='0') or (hs_sw='0') then
				   pei_talk_mode <='1';
					pei_mode <= '0';
				end if;
				
         when pei_rx =>
            pei_led  <= '1';-- and blink_sig;--Flashing
            ic_led   <= '1';--OFF
            cancel_led <= '0';--ON
				occ_led <= '0';--ON
				
				if (pei_sw_in='0' or hs_sw='0') then
				   pei_talk_mode <='0';
					pei_mode <= '1';
				end if;
				
         when cancel=>
            pei_led  <= '1';--OFF
            ic_led   <= '1';--OFF
            cancel_led <= '1';--OFF
				occ_led <='1';--OFF
				
         when ic_call =>
            pei_led  <= '1';--OFF
            ic_led   <= '0';--ON
            cancel_led <= '1';--OFF
				ic_call_mode <= '0';
				ic_rx_mode <= '0';
				intercom_mode <= '0';
				
         when ic_rx =>
            pei_led  <= '1';--OFF
            ic_led   <= '0';--ON
            cancel_led <= '1';--OFF
				ic_rx_mode <= '0';
				intercom_mode <= '0';
				ic_call_mode <= '0';
      end case;
--end if;
--      if (current_st = idle) then
      case (dtmf_in) is
         when "0001" => int_mode <='1'; --1: INT MODE
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "0010" => int_mode <='0'; --2 : EXT MODE
			               ext_mode <= '1';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "0011" => int_mode <='0'; --3: BOTH MODE
			               ext_mode <= '0';
								both_mode <='1';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "0100" => int_mode <='0'; --4 : PA OFF 
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '1';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "0101" => int_mode <='0'; --5: INTERCOM MODE
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '1';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "0110" => int_mode <='0'; --6 : INTERCOM OFF MODE
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '1';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "0111" => int_mode <='0'; --7 : PEI LISTEN MODE
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='1';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "1000" => int_mode <='0'; -- 8: PEI TALK MODE
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "1001" => int_mode <='0'; --9: CANCEL MODE
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '1'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "1010" => int_mode <='0'; -- 10 : PEI CALL MODE
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='1';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "1011" => int_mode <='0'; -- 11 : OCC CALL MODE
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "1100" => int_mode <='0';--12 : PEI WAIT MODE
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
         when "1101" => int_mode <='0'; -- 13 : PEI BUSY MODE
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '1';
								occ_pei_call <= '0';
         when "1110" => int_mode <='0'; -- 14 : OCC TO PEI CALL MODE
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '1';

         when others => int_mode <='0'; 
			               ext_mode <= '0';
								both_mode <='0';
								pa_off <= '0';
								intercom_mode <= '0';
								intercom_off_mode <= '0';
								pei_listen_mode <='0';
								pei_talk_mode <= '0';
			               cancel_mode <= '0'; 
								pei_call_mode <='0';
								occ_call_mode <= '0';
								pei_wait_mode <= '0';
								pei_busy <= '0';
								occ_pei_call <= '0';
      end case;
	
      if (both_sw_in ='0') then
--         dtmf_inout_sp <= "0100";--4
         both_mode <= '1';
         ext_mode <= '0';
         int_mode <= '0';
         mute_sw <= '1';
			both_led <= '0';--ON
         ext_led <= '1'; --OFF
         int_led <= '1'; --OFF

      elsif (ext_sw_in ='0') then
--         dtmf_inout_sp <= "0101";--5
         ext_mode <= '1';
         both_mode <= '0';
         int_mode <= '0';
         mute_sw <= '1';
			both_led <= '1';--OFF
         ext_led <= '0'; --ON
         int_led <= '1'; --OFF
			
      elsif (int_sw_in ='0') then
--         dtmf_inout_sp <= "0110";--6
         int_mode <= '1';
         ext_mode <= '0';
         both_mode <= '0';
         mute_sw <= '1';
			both_led <= '1';--OFF
         ext_led <= '1'; --OFF
         int_led <= '0'; --ON
      else
         mute_sw <= '0';
      end if;

		if (int_mode = '1') then
			dtmf_inout <= "0001";
			dtmf_rs0 <= '0';
			dtmf_rw <= '0';
			dtmf_cs <= '0';
			need_cs <= '1';
		elsif (both_mode = '1') then
			dtmf_inout <= "0011";
			dtmf_rs0 <= '0';
			dtmf_rw <= '0';
			dtmf_cs <= '0';
			need_cs <= '1';
--		elsif (ptt_mode = '1') then
--			dtmf_inout <= "0101";
--			dtmf_rs0 <= '0';
--			dtmf_rw <= '0';
--			dtmf_cs <= '0';
--			need_cs <= '1';
		elsif (ext_mode = '1') then
			dtmf_inout <= "0010";
			dtmf_rs0 <= '0';
			dtmf_rw <= '0';
			dtmf_cs <= '0';
			need_cs <= '1';		
		else
--			dtmf_cs <= '1';
--			need_cs <= '1';
		end if;

		
      if (cancel_mode='1') then
         dtmf_inout_sp <= "0001";--1
      elsif (pei_mode='1' or current_st=dpo_rx) then
         dtmf_inout_sp <= "0010";--2
      elsif (intercom_mode ='1' or current_st=ic_call or current_st=ic_rx) then
         dtmf_inout_sp <= "0011";--3
      elsif (pei_call_mode ='1' or current_st=pei_call) then
         dtmf_inout_sp <= "0111";--7
      elsif (pei_talk_mode='1' or current_st=pei_rx) then
         dtmf_inout_sp <= "1000";--8
      else
         dtmf_inout_sp <= "0001";--1
      end if;		
		
--   end if;
end if; 
end process;

-- State Transition Condition Definition Process
process (current_st, pei_call_mode, pei_sw_in, intercom_mode, ic_sw_in, hs_sw, cancel_sw_in)
begin
   case (current_st) is
      when idle => 
--         if (pei_call_mode ='1' and pei_sw_in='1' and intercom_mode = '0' and ic_sw_in = '1') then
         if (occ_sw_in='0' and pei_sw_in='1' and intercom_mode = '0' and ic_sw_in = '1') then
            next_st <= pei_call; 
         elsif (ic_sw_in ='0' and intercom_mode ='0' and pei_call_mode = '0' and pei_sw_in = '1') then
               next_st <= ic_call;
         elsif (intercom_mode ='1' and ic_sw_in ='1' and pei_call_mode = '0' and pei_sw_in = '1') then
               next_st <= ic_rx;
			else
            next_st <= idle;
         end if; 
			
      when pei_call =>
         if (pei_call_mode='1') then
			   next_st <= pei_call;
			else
			   next_st <= pei_wait;
			end if;
			
      when pei_wait =>
         if (pei_sw_in ='0' ) then--and cancel_sw_in ='1') then
            next_st <= dpo_rx;
         else
            next_st <= pei_wait;
         end if;
			
      when dpo_rx=>
--			if (hs_sw ='0') then
--			   next_st <= dpo_rx;
--			else
--			   next_st <= pei_rx;
--			end if;

         if (cancel_sw_in ='0') then
            next_st <= cancel;
         elsif (pei_sw_in ='0') then-- or hs_sw='1') then
            next_st <= pei_rx;
         else--if (pei_sw_in ='1' or hs_sw='0') then
            next_st <= dpo_rx;
         end if;
			
      when pei_rx =>
         if (cancel_sw_in ='0') then
            next_st <= cancel; 
         elsif (pei_mode='1' or pei_talk_mode='0') then--(pei_sw_in ='0' or hs_sw='0') then
            next_st <= dpo_rx;
         else--if (pei_sw_in ='1' or hs_sw='1') then
            next_st <= pei_rx;
         end if;
			
      when cancel=>
         next_st <= idle;
			
      when ic_call =>
         if (ic_sw_in ='0') then
            next_st <= cancel;
         else
            next_st <= ic_call;
         end if;
			
      when ic_rx =>
         if (intercom_mode ='1') then
            next_st <= cancel;
         else
            next_st <= ic_rx;
         end if;
      end case;
end process;

--process (rst, cnt1ms)--, hs_sw, int_sw_in, ext_sw_in, both_sw_in, ic_sw_in, pei_sw_in, cance_sw_in) 
--begin
--	if rst = '0' then
--		dtmf_cs <= '1';
--		dtmf_rw <= '1';
--		dtmf_rs0 <= '1';
--		
----		dtmf_inout <= "0001";
----		dtmf_inout_sp <= "0111";
----      dtmf_in <= "0011";
--
--		mic_sw <= '1';
--		live_sw <= '1';
--		pa_sw1 <= '1';
--		
--		pei_mute_sp <= '1';
--		ic_mute_sp <= '1';
--		dual_mute_sp <= '1';
--		
--		txs_mic <= "0100";
--		rxs <= "0000";
--		
--		init_set <= '0';
--		tone_tx <= '0';
--		need_cs <= '0';
--
--	elsif cnt1ms'event and cnt1ms = '1' then
----			cntms <= cntms + 1;
----      if (dtmf_rw = '1' and dtmf_cs = '0' and dtmf_rs0 = '0') then
----		   dtmf_in <= dtmf_inout;
----		elsif (dtmf_rw = '0' and dtmf_cs = '0' and dtmf_rs0 = '0') then
----		   dtmf_inout <= dtmf_inout_sp;
----		else
----		   dtmf_inout <= "ZZZZ";
----		end if;
--
--			if init_set = '0' then
--				if cntms = 1 then
--					dtmf_rs0 <= '0';
--					init_set <= '1';
--				end if;
--			end if;
--				
----			if tone_tx = '1' then
--				if cntms = 1 then
--					live_sw <= '0';
--				elsif cntms = 10 then
--				   dtmf_rw <= '1';
--				elsif cntms = 20 then
--				   dtmf_rs0 <= '0';
--				elsif cntms = 24 then
----					tone_tx <= '0';
----					dtmf_rs0 <= '0';
----					dtmf_rw <= '1';	
--					dual_mute_sp <= '1';
--					dtmf_cs <= '0';
--				elsif cntms = 25 then
----					dtmf_in <= dtmf_inout;
----               dtmf_input_mode2 <='1';
--                dtmf_rw <= '0';
--					 dtmf_cs <= '0';
--					 dtmf_rs0 <= '0';
--				end if;
--			end if;
--			
----			if need_cs = '1' then
----				if cntms = 10 and dtmf_cs = '0' then
----					dtmf_cs <= '1';
----				end if;
----				if cntms = 20 and dtmf_cs = '1' then
----					dtmf_cs <= '0';
----					need_cs <= '0';
----				end if;
----			end if;
--				
--			if cntms = 49 then
--				live_sw <= '1';
--				tone_tx <= '0'; -- added
----				dtmf_input_mode2 <= '0'; --added
----				cntms <= (others => '0');
--			end if;
--			
--			if hs_sw = '0' then --ON
--				mic_sw	<= '0';	--OFF
--			else                    --OFF
--				mic_sw	<= '1';	--ON
--			end if;
--					
--			delay_mic1 <= not hs_sw;
--			delay_mic2 <= delay_mic1 and  hs_sw;	
--			delay_mic3 <= hs_sw;			
--			delay_mic4 <= delay_mic3 and not hs_sw;
--
----		end if;
--		
----		if (both_sw_in = '0') then		-- 4
----			dtmf_inout_sp <= "0100";
----		elsif (ext_sw_in = '0') then		-- 5
----			dtmf_inout_sp <= "0101";
----		elsif (int_sw_in = '0') then		-- 6
----			dtmf_inout_sp <= "0110";
----		end if;
----
----      if (cancel_mode='1') then
----         dtmf_inout_sp <= "0001";--1
----      elsif (pei_mode='1' or current_st=dpo_rx) then
----         dtmf_inout_sp <= "0010";--2
----      elsif (intercom_mode ='1' or current_st=ic_call or current_st=ic_rx) then
----         dtmf_inout_sp <= "0011";--3
----      elsif (pei_call_mode ='1' or current_st=pei_call) then
----         dtmf_inout_sp <= "0111";--7
----      elsif (pei_talk_mode='1' or current_st=pei_rx) then
----         dtmf_inout_sp <= "1000";--8
----      else
----         dtmf_inout_sp <= "0001";--1
----      end if;
--
--		if ( ptt_mode1 = '1' or ptt_mode2 = '1' ) and tone_tx = '0' then
--			   tone_tx <= '1';
--		end if;
--		
--      if (current_st = dpo_rx or current_st = pei_rx) then
--		   if (pei_sw_in = '0') then
--			   tone_tx <= '1';
--			else
--			   tone_tx <= '0';
--			end if;
--		else
--		   tone_tx <= '0';
--		end if;
--		
--		if (delay_mic2 = '1') then
--			ptt_mode1 <= '1';
----			dtmf_inout <= "0101";--changed from dtmf_inout to dtmf_inout_sp
----         dtmf_inout_en <= '1';
--			dtmf_rs0 <= '0';
--			dtmf_rw <= '0';
--			dtmf_cs <= '0';
--			need_cs <= '1';
--			dual_mute_sp <= '0';
--		else
--			ptt_mode1 <= '0';
----			dtmf_inout <= "ZZZZ";
--		end if;
--			
--		if delay_mic4 = '1' then
--			ptt_mode2 <= '1';
----			dtmf_inout <= dtmf_inout_sp;
----         dtmf_inout_en <= '1'; --added
--			dtmf_rs0 <= '0';
--			dtmf_rw <= '0';
--			dtmf_cs <= '0';
--			need_cs <= '1';
--			dual_mute_sp <= '0';
--		else 
--			ptt_mode2 <= '0';
----			dtmf_inout <= "ZZZZ";
--		end if;
--		
--		if (both_mode = '1' or ext_mode = '1' or int_mode = '1') then
--			txs_mic <= "0100";
--		end if;
--		if (ic_call_mode = '1' or ic_rx_mode = '1') then
--			ic_mute_sp <= '0';
--			txs_mic <= "0011";
--			rxs <= "0011";
--			pa_sw1 <= '0';
--		else
--			ic_mute_sp <= '0';
--			pa_sw1 <= '1';
--		end if;
--		if (pei_call_mode = '1' or pei_talk_mode = '1') then
--			pei_mute_sp <= '0';
--			txs_mic <= "0111";
--			rxs <= "0111";
--			pa_sw1 <= '0';
--		else
--			pei_mute_sp <= '0';
--			pa_sw1 <= '1';
--		end if;
--
--		if (cancel_mode = '1') then
--			txs_mic <= "0001";
--			rxs <= "0001";
--		end if;
----	end if;
--end process;

-- Bidirection Pin Output Control
--process(dtmf_inout_en, dtmf_inout_sp)
--begin
--   if rst ='0' then
--	   dtmf_inout <= "0001";
--	elsif (dtmf_inout_en ='1') then
--	   dtmf_inout <= dtmf_inout_sp;
--	else
--	   dtmf_inout <= "ZZZZ";
--	end if;
--end process;
--
--process(rst, need_cs,dtmf_cs_in)
--begin
--   if (rst='0') then
--	   dtmf_cs <= '0';
--	else 
--	   if need_cs='1' then
--	      if cntms = 10 and dtmf_cs_in ='0' then
--		      dtmf_cs <= '1';
--		   elsif cntms = 20 and dtmf_cs_in = '1' then
--			   dtmf_cs <= '0';
--			else dtmf_cs <= 'Z';
--		   end if;
--		else dtmf_cs <= 'Z';
--		end if;
--		if (delay_mic2 = '1' or delay_mic4 = '1') then
--		   dtmf_cs <= '0';
--		else dtmf_cs <= 'Z';
--		end if;
--	end if;
--end process;

--dtmf_in <= dtmf_inout;
--dtmf_cs_in <= dtmf_cs;

end Behavioral;

