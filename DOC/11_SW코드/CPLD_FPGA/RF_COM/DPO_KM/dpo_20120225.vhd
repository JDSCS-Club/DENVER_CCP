library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dpo is
    Port (
			rst : in STD_LOGIC;
			clk : in STD_LOGIC;

			dtmf_inout : inout  STD_LOGIC_VECTOR (3 downto 0);
			dtmf_rs0 : out STD_LOGIC;
			dtmf_cs : inout STD_LOGIC;
			dtmf_rw : out STD_LOGIC;

			both_sw_in : in STD_LOGIC;
			ext_sw_in : in STD_LOGIC;
			int_sw_in : in STD_LOGIC;

			ic_sw_in : in STD_LOGIC;
			pei_sw_in : in STD_LOGIC;
			cancel_sw_in : in STD_LOGIC;
			both_led : out STD_LOGIC;
			ext_led : out STD_LOGIC;
			int_led : out STD_LOGIC;
			ic_led : out STD_LOGIC;
			pei_led : out STD_LOGIC;
			cancel_led : out STD_LOGIC;
			
			hs_sw : in STD_LOGIC;
			mic_sw : out STD_LOGIC;
			live_sw : out STD_LOGIC;
			mute_sw : out STD_LOGIC;
			pa_sw1 : out STD_LOGIC;
			
			pei_mute_sp : out STD_LOGIC;
			ic_mute_sp : out STD_LOGIC;
			dual_mute_sp : out STD_LOGIC;
			txs4 : out STD_LOGIC;
			txs3 : out STD_LOGIC;
			txs_mic : out  STD_LOGIC_VECTOR (3 downto 0);
			rxs : out  STD_LOGIC_VECTOR (3 downto 0)
		);
end dpo;

architecture Behavioral of dpo is

	signal cnt : STD_LOGIC_VECTOR(15 downto 0);
	signal cnt1ms : STD_LOGIC;
	signal cntms : STD_LOGIC_VECTOR(8 downto 0);
--	signal cntblk : STD_LOGIC_VECTOR(8 downto 0);
	
	signal int_mode, ext_mode, both_mode, ptt_mode1, ptt_mode2  : STD_LOGIC;
	signal int_mode_f, ext_mode_f, both_mode_f : STD_LOGIC;
	
	signal dtmf_in, dtmf_inout_sp : STD_LOGIC_VECTOR(3 downto 0);
--	signal dtmf_out : STD_LOGIC_VECTOR(3 downto 0);
	
	signal need_cs, init_set, tone_tx, tone_temp : STD_LOGIC;
	signal delay_mic1, delay_mic2, delay_mic3, delay_mic4 : STD_LOGIC;
	
	signal ic_call_mode, ic_rx_mode, pei_call_mode, pei_rx_mode, cancle_mode : STD_LOGIC;
	signal ic_led_blk, pei_led_blk : STD_LOGIC;
	signal blk_flag : STD_LOGIC;
   
type state_type is (idle, pei_call, pei_wait, dpo_rx, pei_rx, cancel, ic_call, ic_rx);
signal current_st, next_st : state_type;
signal blink_cnt : std_logic_vector(7 downto 0);
signal blink_sig : std_logic;
signal speaker_mode : std_logic_vector(2 downto 0);
signal cancel_mode : std_logic;
signal pei_mode : std_logic;
signal intercom_mode : std_logic;
signal pei_talk_mode : std_logic;
signal dtmf_rw_int : std_logic;
signal dtmf_input_mode : std_logic;
signal dtmf_input_mode2 : std_logic;
signal dtmf_inout_en : std_logic;
signal dtmf_cs_in : std_logic;

begin

--dtmf_rw <= dtmf_rw_int;
--dtmf_cs <= '0';
dtmf_in <= dtmf_inout;
--dtmf_input_mode <= '1' when ((dtmf_rw_int='1') and (dtmf_cs_in='0')) else '0';
-- 1ms clock generation process
process (rst, clk) begin
	if rst = '0' then
		cnt <= (others => '0');
		cnt1ms <= '0';
	elsif clk'event and clk = '1' then
		cnt <= cnt + 1;
		if cnt = 45000 then
			cnt <= (others => '0');
			cnt1ms <= not cnt1ms;
		end if;
	end if;
end process;

-- State Transition process & blink signal generation
process (rst, cnt1ms)
begin
   if (rst = '0') then
      current_st <= idle;
      blink_cnt <= (others => '0');
      blink_sig <= '0';
   elsif cnt1ms'event and cnt1ms='1' then
      current_st <= next_st;
      blink_cnt <= blink_cnt + 1;
		
		if (blink_cnt=200) then
         blink_sig <= not blink_sig;
			blink_cnt <= (others => '0');
		end if;
   end if;
end process;

-- Decode the DTMF Data
--process (rst, cnt1ms)
--begin
----if (cnt1ms'event and cnt1ms='1') then
----	   dtmf_in <= dtmf_inout;
----      if (current_st=idle) then
--
--   end if;
--end process;

-- State Transition Condition Definition Process
process (current_st)--, .....)
begin
   if (rst ='0')then
      cancel_mode <= '0';
      pei_mode <= '0';
      intercom_mode <= '0';
      both_mode <= '0';
      ext_mode <= '0';
      int_mode <= '0';
      pei_call_mode <= '0';
      pei_talk_mode <= '0';
      mute_sw <= '0';
      both_led <= '0';--ON
      ext_led <= '1'; --OFF
      int_led <= '1'; --OFF
   else
   case (current_st) is
      when idle => 
   		pei_led  <= '1';--OFF
         ic_led   <= '1';--OFF
         cancel_led <= '1';--OFF
			dtmf_rw_int <= '1';
			
         if (pei_call_mode ='1') then-- and pei_sw_in ='1') then
            next_st <= pei_call;
			end if;
         if (ic_sw_in ='0') then-- and intercom_mode ='0') then
            next_st <= ic_call;
			end if;
         if (intercom_mode ='1') then-- and ic_sw_in ='1') then
            next_st <= ic_rx;
			end if;
--         else
--            next_st <= idle;
--         end if; 
      when pei_call =>
         next_st <= pei_wait;
         pei_led  <= '0';--ON
         ic_led   <= '1';--OFF
         cancel_led <= '1';--OFF
			dtmf_rw_int <= '0';
			
      when pei_wait =>
         pei_led  <= '0' or blink_sig;--Flashing
         ic_led   <= '1';--OFF
         cancel_led <= '1';--OFF
         dtmf_rw_int <= '0';
         if (pei_mode='1' or (pei_sw_in ='0' and cancel_sw_in ='1')) then
            next_st <= dpo_rx;
         else
            next_st <= pei_wait;
         end if;
      when dpo_rx=>
         pei_led  <= '0';--ON
         ic_led   <= '1';--OFF
         cancel_led <= '0';--ON
			dtmf_rw_int <= '0';
         if (cancel_sw_in ='0') then
            next_st <= cancel;
         elsif (pei_sw_in ='0') then-- or hs_sw='1') then
            next_st <= pei_rx;
         else--if (pei_sw_in ='1' or hs_sw='0') then
            next_st <= dpo_rx;
         end if;
      when pei_rx =>
         pei_led  <= '1';-- and blink_sig;--Flashing
         ic_led   <= '1';--OFF
         cancel_led <= '0';--ON
			dtmf_rw_int <= '0';
         if (cancel_sw_in ='0' or cancel_mode='1') then
            next_st <= cancel; 
         elsif (pei_sw_in ='0') then-- or hs_sw='0') then
            next_st <= dpo_rx;
         else--if (pei_sw_in ='1' or hs_sw='1') then
            next_st <= pei_rx;
         end if;
      when cancel=>
         pei_led  <= '1';--OFF
         ic_led   <= '1';--OFF
         cancel_led <= '1';--OFF
         next_st <= idle;
			dtmf_rw_int <= '1';
      when ic_call =>
         pei_led  <= '1';--OFF
         ic_led   <= '0';--ON
         cancel_led <= '1';--OFF
   		dtmf_rw_int <= '0';
         if (ic_sw_in ='0') then
            next_st <= cancel;
         else
            next_st <= ic_call;
         end if;
      when ic_rx =>
         pei_led  <= '1';--OFF
         ic_led   <= '0';--ON
         cancel_led <= '1';--OFF
			dtmf_rw_int <= '1';
         if (intercom_mode ='1') then
            next_st <= cancel;
         else
            next_st <= ic_rx;
         end if;
      when others =>
         pei_led  <= '1';--OFF
         ic_led   <= '1';--OFF
         cancel_led <= '1';--OFF
         next_st <= idle;
			dtmf_rw_int <= '1';
   end case;

      if (dtmf_rw_int ='1') then
         case (dtmf_in) is
            when "0001" => cancel_mode <= '1';
            when "0010" => pei_mode <= '1';
            when "0011" => intercom_mode <= '1';
            when "0100" => both_mode <= '1'; mute_sw <= '1';
            when "0101" => ext_mode <= '1'; mute_sw <= '1';
            when "0110" => int_mode <= '1'; mute_sw <= '1';
            when "0111" => pei_call_mode <= '1';
            when "1000" => pei_talk_mode <= '1';
            when others => cancel_mode <='1';
         end case;
		end if;	
		
	      if (both_sw_in ='0') then-- or both_mode='1') then
--         dtmf_inout_sp <= "0100";--4
         dtmf_rw_int <= '1';
         both_mode <= '1';
         ext_mode <= '0';
         int_mode <= '0';
         mute_sw <= '1';
			both_led <= '0';--ON
         ext_led <= '1'; --OFF
         int_led <= '1'; --OFF
      elsif (ext_sw_in ='0') then-- or ext_mode='1') then
--         dtmf_inout_sp <= "0101";--5
         dtmf_rw_int <= '1';
         ext_mode <= '1';
         both_mode <= '0';
         int_mode <= '0';
         mute_sw <= '1';
			both_led <= '1';--OFF
         ext_led <= '0'; --ON
         int_led <= '1'; --OFF
      elsif (int_sw_in ='0') then-- or int_mode='1') then
--         dtmf_inout_sp <= "0110";--6
         dtmf_rw_int <= '1';
         int_mode <= '1';
         ext_mode <= '0';
         both_mode <= '0';
         mute_sw <= '1';
			both_led <= '1';--OFF
         ext_led <= '1'; --OFF
         int_led <= '0'; --ON
      else
         dtmf_rw_int <= '0';
         mute_sw <= '0';
      end if;
end if;
end process;

process (rst)
begin
   if (rst = '0') then
	   cntms <= (others=>'0');
		dtmf_rw <= '0';
	elsif (cnt1ms'event and cnt1ms='1') then
	   cntms <= cntms + 1;
		if (cntms=49) then
		   cntms <=(others=>'0');
		elsif cntms = 20 then
		   dtmf_rw <= '1';
		end if;
	end if;
end process;

--process (rst, cnt1ms)--, hs_sw, int_sw_in, ext_sw_in, both_sw_in, ic_sw_in, pei_sw_in, cance_sw_in) 
--begin
--	if rst = '0' then
----		cntms <= (others => '0');
--		
----		dtmf_cs <= '0';
--		dtmf_rw_int <= '1';
--		dtmf_rs0 <= '1';
--		
----		dtmf_inout <= "0001";
--		dtmf_inout_sp <= "0111";
----      dtmf_in <= "0111";
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
--	else if cnt1ms'event and cnt1ms = '1' then
----			cntms <= cntms + 1;
--			if init_set = '0' then
--				if cntms = 1 then
--					dtmf_rs0 <= '0';
--					init_set <= '1';
--				end if;
--			end if;
--				
--			if tone_tx = '1' then
--				if cntms = 1 then
--					live_sw <= '0';
--				elsif cntms = 24 then
----					tone_tx <= '0';
--					dtmf_rs0 <= '0';
--					dtmf_rw_int <= '1';	
--					dual_mute_sp <= '1';
--				elsif cntms = 25 then
----					dtmf_in <= dtmf_inout;
--               dtmf_input_mode2 <='1';
--				end if;
--			end if;
--			
--			if need_cs = '1' then
--				if cntms = 10 and dtmf_cs_in = '0' then
----					dtmf_cs <= '1';
--				end if;
--				if cntms = 20 and dtmf_cs_in = '1' then
----					dtmf_cs <= '0';
--					need_cs <= '0';
--				end if;
--			end if;
--				
--			if cntms = 49 then
--				live_sw <= '1';
--				tone_tx <= '0'; -- added
--				dtmf_input_mode2 <= '0'; --added
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
--		end if;
--		
--		if (both_sw_in = '0') then		-- 4
--			dtmf_inout_sp <= "0100";
--		elsif (ext_sw_in = '0') then		-- 5
--			dtmf_inout_sp <= "0101";
--		elsif (int_sw_in = '0') then		-- 6
--			dtmf_inout_sp <= "0110";
--		end if;
--
--      if (cancel_mode='1') then
--         dtmf_inout_sp <= "0001";--1
--      elsif (pei_mode='1' or current_st=dpo_rx) then
--         dtmf_inout_sp <= "0010";--2
--      elsif (intercom_mode ='1' or current_st=ic_call or current_st=ic_rx) then
--         dtmf_inout_sp <= "0011";--3
--      elsif (pei_call_mode ='1' or current_st=pei_call) then
--         dtmf_inout_sp <= "0111";--7
--      elsif (pei_talk_mode ='1' or current_st=pei_rx) then
--         dtmf_inout_sp <= "1000";--8
--      else
--         dtmf_inout_sp <= "0001";--1
--      end if;
--
--		if (( ptt_mode1 = '1' or ptt_mode2 = '1' ) and tone_tx = '0') then
--			tone_tx <= '1';
--		end if;
--		
--		if delay_mic2 = '1' then
--			ptt_mode1 <= '1';
----			dtmf_inout_sp <= "0101";--changed from dtmf_inout to dtmf_inout_sp
--         dtmf_inout_en <= '1';
--			dtmf_rs0 <= '0';
--			dtmf_rw_int <= '0';
----			dtmf_cs <= '0';
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
--         dtmf_inout_en <= '1'; --added
--			dtmf_rs0 <= '0';
--			dtmf_rw_int <= '0';
----			dtmf_cs <= '0';
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
--		if (cancel_mode = '1') then
--			txs_mic <= "0001";
--			rxs <= "0001";
--		end if;
--	end if;
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

dtmf_in <= dtmf_inout;
--dtmf_cs_in <= dtmf_cs;

end Behavioral;

