----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    15:07:00 02/18/2012
-- Design Name:
-- Module Name:    dpo - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
	signal cntblk : STD_LOGIC_VECTOR(8 downto 0);
	
	signal int_mode, ext_mode, both_mode, ptt_mode1, ptt_mode2  : STD_LOGIC;
	signal int_mode_f, ext_mode_f, both_mode_f : STD_LOGIC;
	
	signal dtmf_in, dtmf_inout_sp : STD_LOGIC_VECTOR(3 downto 0);
	signal dtmf_out : STD_LOGIC_VECTOR(3 downto 0);
	
	signal need_cs, init_set, tone_tx, tone_temp : STD_LOGIC;
	signal delay_mic1, delay_mic2, delay_mic3, delay_mic4 : STD_LOGIC;
	
	signal ic_call_mode, ic_rx_mode, pei_call_mode, pei_rx_mode, cancel_mode : STD_LOGIC;
	signal ic_led_blk, pei_led_blk : STD_LOGIC;
	signal blk_flag : STD_LOGIC;
   signal pei_talk_mode : std_logic;
	
begin

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

process (rst, cnt1ms, hs_sw, int_sw_in, ext_sw_in, both_sw_in, ic_sw_in, pei_sw_in, cancel_sw_in) 
begin
	if rst = '0' then
		cntms <= (others => '0');
		cntblk <= (others => '0');
		
		dtmf_cs <= '0';
		dtmf_rw <= '1';
		dtmf_rs0 <= '0';
		
--		dtmf_inout <= "0001";
--		dtmf_inout_sp <= "0100";

		both_led <= '0';
		ext_led <= '1';
		int_led <= '1';
		ic_led <= '1';
		pei_led <= '1';
		cancel_led <= '1';
		
		mic_sw <= '1';
		live_sw <= '1';
		mute_sw <= '0';
		pa_sw1 <= '1';
		
		pei_mute_sp <= '1';
		ic_mute_sp <= '1';
		dual_mute_sp <= '1';
		
		txs_mic <= "0100";
		rxs <= "0000";
		
		both_mode <= '1';
		ext_mode <= '0';
		int_mode <= '0';
		
		ic_call_mode <= '0';
		ic_rx_mode <= '0';
		pei_call_mode <= '0';
		pei_rx_mode <= '0';
		cancel_mode <= '0';
		
		blk_flag <= '0';
		
		init_set <= '0';
		tone_tx <= '0';
		need_cs <= '0';

	else
		if cnt1ms'event and cnt1ms = '1' then
			cntms <= cntms + 1;
			if cntms = 49 then
			   cntms <= (others => '0');
			end if;
			
			if init_set = '0' then
				if cntms = 1 then
					dtmf_rs0 <= '0';
					init_set <= '1';
				end if;
			end if;
				
			if tone_tx = '1' then
				if cntms = 1 then
					live_sw <= '0';
				elsif cntms = 24 then
					tone_tx <= '0';
					dtmf_rs0 <= '0';
					dtmf_rw <= '1';	
					dual_mute_sp <= '1';
				elsif cntms = 25 then
					dtmf_in <= dtmf_inout;
				end if;
			end if;
			
			if need_cs = '1' then
--				if cntms = 10 and dtmf_cs = '0' then
--					dtmf_cs <= '1';
--				end if;
				if cntms = 20 and dtmf_cs = '1' then
					dtmf_cs <= '0';
					need_cs <= '0';
				end if;
			end if;
				
			if cntms = 49 then
				live_sw <= '1';
--				cntms <= (others => '0');
			end if;

			if hs_sw = '0' then
				mic_sw	<= '0';	
			else
				mic_sw	<= '1';	
			end if;
					
			delay_mic1 <= not hs_sw;
			delay_mic2 <= delay_mic1 and  hs_sw;	
			delay_mic3 <= hs_sw;			
			delay_mic4 <= delay_mic3 and not hs_sw;

			cntblk <= cntblk + 1;
			if (cntblk = 200) then
				cntblk <= (others => '0');
				if (blk_flag = '0') then
					blk_flag <= '1';
				else
					blk_flag <= '0';
				end if;
			end if;
		end if;
		
		-- 1 : 
		-- 2 : int
		-- 3 : ext
		-- 4 : both
		-- 5 : cancle(int, ext, both)
		-- 6 : ic_call
		-- 7 : ic_rx
		-- 8 : pei_call
		-- 9 : pei_rx
		-- * : 11 : cancle_sw_on
		-- # : 12 : cancle_sw_off
		-- A : 13
		-- B : 14
		-- C : 15
		-- D : 0
		
		if (both_sw_in = '0') then			-- 4
			dtmf_inout_sp <= "0100";
			both_mode <= '1';
			ext_mode <= '0';
			int_mode <= '0';
			both_led <= '0';
			ext_led <= '1';
			int_led <= '1';
		elsif (ext_sw_in = '0') then		-- 3
			dtmf_inout_sp <= "0011";
			both_mode <= '0';
			ext_mode <= '1';
			int_mode <= '0';
			both_led <= '1';
			ext_led <= '0';
			int_led <= '1';
		elsif (int_sw_in = '0') then		-- 2
			dtmf_inout_sp <= "0010";
			both_mode <= '0';
			ext_mode <= '0';
			int_mode <= '1';
			both_led <= '1';
			ext_led <= '1';
			int_led <= '0';
		end if;

		if (ic_sw_in = '0' and pei_call_mode = '0' and pei_rx_mode = '0' and cancel_mode = '0') then
--			if (ic_call_mode = '0' and ic_rx_mode = '0') then
				dtmf_inout <= "0110";		-- 6
				ic_call_mode <= '1';
				ic_rx_mode <= '0';
				ic_led <= '0';
				
				if (ic_call_mode ='1' and ic_sw_in='0') then
				   ic_call_mode <= '0';
					ic_rx_mode <= '0';
					ic_led <= '1';
				end if;
				
		elsif (ic_sw_in = '1' and ic_rx_mode = '1') then
				dtmf_inout <= "0111";		-- 7
				ic_call_mode <= '0';
				ic_rx_mode <= '1';
--				ic_led_blk <= '0';
				ic_led <= '0';
			if (ic_rx_mode = '1') then
			   ic_rx_mode <= '0';
				ic_call_mode <='0';
				ic_led <= '1';
			end if;
		   
			pei_call_mode <= '0';
			pei_rx_mode <= '0';
			cancel_mode <= '0';
			pei_led_blk <= '0';
			pei_led <= '1';
			cancel_led <= '1';
		end if;
		
		if (pei_call_mode='1' and pei_sw_in='1' and ic_call_mode='0' and ic_rx_mode='0') then
		   dtmf_inout_sp <= "0111";
			ic_call_mode <= '0';
			ic_rx_mode <= '0';
			cancel_mode <= '0';
			pei_call_mode <= '1';
			pei_rx_mode <= '0';
			pei_led <= '0' or blk_flag; -- Flashing
			ic_led <= '1';--OFF
			cancel_led <= '1';--OFF
			   
--		elsif (pei_sw_in = '0' and ic_rx_mode = '0' and ic_call_mode = '0' and cancel_mode = '0' and pei_call_mode = '1') then
		elsif (pei_sw_in = '0' and pei_call_mode = '1' and pei_rx_mode='0') then
			dtmf_inout_sp <= "1001";		-- 9
			ic_call_mode <= '0';
			ic_rx_mode <= '0';
			pei_call_mode <= '0';
			pei_rx_mode <= '1';
			cancel_mode <= '0';
			ic_led <= '1';
			pei_led <= '0';
			cancel_led <= '0';
		
		elsif (pei_rx_mode='1' and pei_sw_in='0' and pei_call_mode='0') then
		   dtmf_inout_sp <= "1000";
			ic_call_mode <= '0';
			ic_rx_mode <= '0';
			pei_call_mode <= '0';
			pei_rx_mode <= '0';
			cancel_mode <= '0';
			pei_talk_mode <= '1';
			ic_led <= '1';
			pei_led <= '0' or blk_flag;
			cancel_led <= '0';
		
		elsif (pei_talk_mode='1' and pei_sw_in='0') then
		   dtmf_inout_sp <= "0010";
			ic_call_mode <= '0';
			ic_rx_mode <= '0';
			pei_call_mode <= '0';
			pei_rx_mode <= '1';
			cancel_mode <= '0';
			pei_talk_mode <= '0';
			ic_led <= '1';
			pei_led <= '0';
			cancel_led <= '0';
			
		elsif (cancel_sw_in = '0') then
			dtmf_inout_sp <= "0001";		-- 11
			ic_call_mode <= '0';
			ic_rx_mode <= '0';
			pei_call_mode <= '0';
			pei_rx_mode <= '0';
			cancel_mode <= '1';
			ic_led <= '1';
			pei_led <= '1';
			cancel_led <= '0';
			
		elsif (cancel_mode = '1') then
			dtmf_inout_sp <= "0001";		-- 12
			ic_call_mode <= '0';
			ic_rx_mode <= '0';
			pei_call_mode <= '0';
			pei_rx_mode <= '0';
			cancel_mode <= '0';
			ic_led <= '1';
			pei_led <= '1';
			cancel_led <= '1';
		end if;

		if (( ptt_mode1 = '1' or ptt_mode2 = '1' ) and tone_tx = '0') then
			tone_tx <= '1';
		end if;
		
		if delay_mic2 = '1' then
			ptt_mode1 <= '1';
			dtmf_inout <= "0101";
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
		
		if (dtmf_in = "0001") then		-- 1: Cancel
         cancel_mode <= '1'; pei_rx_mode <= '0'; pei_call_mode <='0'; 
         pei_talk_mode <= '0'; ic_call_mode <= '0'; ic_rx_mode <= '0';
		elsif (dtmf_in = "0011") then		-- 3
         cancel_mode <= '0'; pei_rx_mode <= '0'; pei_call_mode <='0'; 
         pei_talk_mode <= '0'; ic_call_mode <= '0'; ic_rx_mode <= '1';
		elsif (dtmf_in = "0111") then		-- 7
         cancel_mode <= '0'; pei_rx_mode <= '0'; pei_call_mode <='1'; 
         pei_talk_mode <= '0'; ic_call_mode <= '0'; ic_rx_mode <= '0';
		elsif (dtmf_in = "1000") then		-- 8
         cancel_mode <= '0'; pei_rx_mode <= '0'; pei_call_mode <='0'; 
         pei_talk_mode <= '1'; ic_call_mode <= '0'; ic_rx_mode <= '0';
		elsif (dtmf_in = "0010") then		-- 2
         cancel_mode <= '0'; pei_rx_mode <= '1'; pei_call_mode <='0'; 
         pei_talk_mode <= '0'; ic_call_mode <= '0'; ic_rx_mode <= '0';
		elsif (dtmf_in = "0100" and dtmf_in = "0101" and dtmf_in = "0110") then		-- PA
			mute_sw <= '1';
		else
         cancel_mode <= '0'; pei_rx_mode <= '0'; pei_call_mode <='0'; 
         pei_talk_mode <= '0'; ic_call_mode <= '0'; ic_rx_mode <= '0';
		end if;
		
		if (both_mode = '1' or ext_mode = '1' or int_mode = '1') then
			mute_sw <= '1';
			txs_mic <= "0100";
		else
			mute_sw <= '0';
		end if;
		
		if (ic_call_mode = '1' or ic_rx_mode = '1') then
			if (ic_call_mode = '1') then
				if (blk_flag = '1') then
					ic_led <= '0';
				else
					ic_led <= '1';
				end if;
			else
				ic_led <= '0';
			end if;
			ic_mute_sp <= '0';
			txs_mic <= "0010";
			rxs <= "0001";
			pa_sw1 <= '0';
		else
			ic_mute_sp <= '0';
			pa_sw1 <= '1';
		end if;
		if (pei_call_mode = '1' or pei_rx_mode = '1') then
			if (pei_call_mode = '1') then
				if (blk_flag = '1') then
					pei_led <= '0';
				else
					pei_led <= '1';
				end if;
			else
				pei_led <= '0';
			end if;			
			pei_mute_sp <= '0';
			txs_mic <= "0001";
			rxs <= "0010";
			pa_sw1 <= '0';
		else
			pei_mute_sp <= '0';
			pa_sw1 <= '1';
		end if;
		if (cancel_mode = '1') then
			txs_mic <= "0100";
			rxs <= "0000";
		end if;
	end if;
end process;

end Behavioral;

