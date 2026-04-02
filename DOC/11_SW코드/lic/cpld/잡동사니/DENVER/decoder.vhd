----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:41:15 12/06/2011 
-- Design Name: 
-- Module Name:    decoder - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
    Port (
		RST				: in std_logic;
		RDY				: out std_logic;
		ROM_SERIAL_SW	: in std_logic;
		H3					: in std_logic;
		WDI				: out std_logic;
		STRB				: in std_logic;
		RWB				: in std_logic;
		EDGE_MODE		: out std_logic;
		LRST				: out std_logic;

		A					: in std_logic_vector(23 downto 18);
		D					: inout std_logic_vector(7 downto 0);
		IO           	: inout std_logic_vector(11 downto 0);

		XL16L784_CS		: out std_logic;
		FROM_CS			: out std_logic;
		NVSRAM_CS		: out std_logic;
		--DPRAM_CS		: out std_logic;
		W5100_CS			: out std_logic;
		WR					: buffer std_logic;
		RD					: out std_logic;
		
		
		SERVICE_LON 	: out std_logic;
		SERVICE_SWITCH	: in std_logic;
		CSO_LON			: out std_logic;
		
		
		--VL5V_OE			: out std_logic;
		--VL5V_DIR		: out std_logic;
		
		XL16L784_INT	: in std_logic;
		W5100_INT		: in std_logic;
		
		INT0				: buffer std_logic;
		INT1				: buffer std_logic;
		INT2				: buffer std_logic;
		INT3				: buffer std_logic;
		
		--NIO3			: in std_logic;
		--NIO4			: out std_logic;
		
		RUN_LED			: out std_logic;
		ERR_LED			: out std_logic
		);
end decoder;

architecture Behavioral of decoder is
	signal FROM_CS_BUF : std_logic;
	signal INT_READ_CS : std_logic;
	signal XL16L784_CS_BUF : std_logic;
	signal NVSRAM_CS_BUF : std_logic;
	--signal DPRAM_CS_BUF : std_logic;
	signal LONWK_CS : std_logic;
	signal W5100_CS_BUF : std_logic;
	--signal NIO4_BUF : std_logic;
	signal BOOT_2_INT_SEL : std_logic;
	signal BOOT_2_INT_CS : std_logic;
	signal WDI_CS : std_logic;
	signal WR_DLYBUF : std_logic;
	signal WDI_SEL_FLAG : std_logic;
	signal LED_CS : std_logic;
	signal RUN_LED_BUF : std_logic;
	signal ERR_LED_BUF : std_logic;
begin

	RDY <= '0';
	EDGE_MODE <= '1'; -- 0:Level tigger, 1:Edge tigger
	--WDI <= H3;

	XL16L784_CS <= XL16L784_CS_BUF;
	FROM_CS <= FROM_CS_BUF;
	NVSRAM_CS <= NVSRAM_CS_BUF;
	--DPRAM_CS <= DPRAM_CS_BUF;
	W5100_CS <= W5100_CS_BUF;

	RD <= STRB or not RWB;
	WR <= STRB or RWB;
	
	--VL5V_OE <= DPRAM_CS_BUF;
	--VL5V_DIR <= RWB;
	
	--NIO4 <= NIO4_BUF;
	
	---------------------------------------------------------------------------------------------
	-- Lonwork Reset
	---------------------------------------------------------------------------------------------
	--process(RST)
	--begin
	--	if(RST = '1') then
			LRST <= 'Z';
	--	else
	--		LRST <= '0';
	--	end if;
	--end process;
	
	process(SERVICE_SWITCH)
	begin
		if(SERVICE_SWITCH = '1') then
			SERVICE_LON <= '1';
		else
			SERVICE_LON <= '0';
		end if;
	end process;
			
	---------------------------------------------------------------------------------------------
	-- LED
	---------------------------------------------------------------------------------------------
	RUN_LED <= RUN_LED_BUF;
	ERR_LED <= ERR_LED_BUF;

	---------------------------------------------------------------------------------------------
	-- Delay Write
	---------------------------------------------------------------------------------------------
	process(RST,H3,WR)
		variable WR_BUFS : std_logic_vector(1 downto 0);
	begin
		if(RST = '0') then
			WR_BUFS := "11";
		elsif(rising_edge(H3)) then
			WR_BUFS := WR_BUFS(0) & WR;
		end if;
		
		WR_DLYBUF <= WR_BUFS(1);
	end process;
	
	---------------------------------------------------------------------------------------------
	-- Watch Dog
	---------------------------------------------------------------------------------------------
	process(ROM_SERIAL_SW,WDI_SEL_FLAG,H3,WDI_CS,FROM_CS_BUF)
	begin
		if(ROM_SERIAL_SW = '0') then -- Serial
			WDI <= H3;
		else -- Rom Boot
			if(WDI_SEL_FLAG = '0') then
				WDI <= FROM_CS_BUF;
			else
				WDI <= WDI_CS;
			end if;
		end if;
	end process;
	
	process(RST,WDI_CS)
	begin
		if(RST = '0') then
			WDI_SEL_FLAG <= '0';
		elsif(WDI_CS = '0') then
			WDI_SEL_FLAG <= '1';
		end if;
	end process;	
	
	-------------------------------------------------------------------------------------
	-- Interrupt
	-------------------------------------------------------------------------------------
	process(BOOT_2_INT_SEL,XL16L784_INT,W5100_INT)
	begin
		if(BOOT_2_INT_SEL = '0') then
			INT0 <= '1';
			INT1 <= not ROM_SERIAL_SW;
			INT2 <= '1';
			INT3 <= ROM_SERIAL_SW;
		else
			INT0 <= XL16L784_INT;
			INT1 <= '1';
			INT2 <= W5100_INT;
			INT3 <= '1';
		end if;
	end process;	
	
	process(RST,BOOT_2_INT_CS)
	begin
		if(RST = '0') then
			BOOT_2_INT_SEL <= '0';
		elsif(BOOT_2_INT_CS = '0') then
			BOOT_2_INT_SEL <= '1';
		end if;
	end process;

	-------------------------------------------------------------------------------------
	-- Data Read
	-------------------------------------------------------------------------------------
	process(RST,INT_READ_CS,LED_CS,RWB,INT0,INT1,RUN_LED_BUF,ERR_LED_BUF,RUN_LED_BUF)
		variable LED_READ_CS : std_logic;
		variable LONWK_READ_CS : std_logic;
	begin
		LED_READ_CS := LED_CS or (not RWB);
		LONWK_READ_CS := LONWK_CS or (not RWB);
	
		if(RST = '0') then
			D <= "ZZZZZZZZ";
		elsif(INT_READ_CS = '0') then
			D <= '0'&'0'&'0'&'0'&'0'&'0'&INT1&INT0; 
		elsif(LED_READ_CS = '0') then
			D <= '0'&'0'&'0'&'0'&'0'&'0'&ERR_LED_BUF&RUN_LED_BUF;
		--elsif(LONWK_READ_CS = '0') then
			--D <= '0'&NIO4_BUF;
		else
			D <= "ZZZZZZZZ";
		end if;
	end process;

	-------------------------------------------------------------------------------------
	-- Data Write
	-------------------------------------------------------------------------------------
	process(RST,LED_CS,D,WR_DLYBUF)
	begin
		if(RST = '0') then
			RUN_LED_BUF <= '0';
			ERR_LED_BUF <= '0';
			--NIO4_BUF <= '1';
		elsif(falling_edge(WR_DLYBUF)) then
			if(LED_CS = '0') then
				RUN_LED_BUF <= D(0);
				ERR_LED_BUF <= D(1);
			--elsif(LONWK_CS = '0') then
				--NIO4_BUF <= D(0);
			end if;
		end if;
	end process;

	-------------------------------------------------------------------------------------
	-- Decoder
	-------------------------------------------------------------------------------------
	process(RST,STRB,A)
	begin
		if(RST='0') then
			BOOT_2_INT_CS <= '1';
			FROM_CS_BUF <= '1';
			XL16L784_CS_BUF <= '1';
			INT_READ_CS <= '1';
			WDI_CS <= '1';
			LED_CS <= '1';
			NVSRAM_CS_BUF <= '1';
			--DPRAM_CS_BUF <= '1';
			LONWK_CS <= '1';
			W5100_CS_BUF <= '1';
				
		-- WDI_CS : 0x002xxx
		elsif(A = "0000" and STRB = '0') then WDI_CS <= '0';					
		
		-- BOOT_2_INT : 0x1xxxxx
		elsif(A = "0001" and STRB = '0') then BOOT_2_INT_CS <= '0';					
		
		-- LED_CS : 0x2xxxxx
		elsif(A = "0010" and STRB = '0') then LED_CS <= '0';

		-- W5100_CS : 0x3xxxxx
		elsif(A = "0011" and STRB = '0') then W5100_CS_BUF <= '0';
		
		-- FROM_CS_BUF : 0x4xxxxx
		elsif(A = "0100" and STRB = '0') then FROM_CS_BUF <= '0';
		
		-- INT_READ_CS : 0x80Bxxx
		elsif(A = "1000" and STRB = '0') then INT_READ_CS <= '0';

		-- XL16L784_CS_BUF : 0x9xxxxx
		elsif(A = "1001" and STRB = '0') then XL16L784_CS_BUF <= '0';
		
		-- LONWK_CS : 0xAxxxxx
		elsif(A = "1010" and STRB = '0') then LONWK_CS <= '0';

		-- DPRAM_CS_BUF : 0xBxxxxx
	--	elsif(A = "1011" and STRB = '0') then DPRAM_CS_BUF <= '0';
		
		-- NVSRAM_CS_BUF : 0xCxxxxx ~ 0xFxxxxx
		elsif(A(23 downto 22) = "11" and STRB = '0') then NVSRAM_CS_BUF <= '0';
		
		else
			BOOT_2_INT_CS <= '1';
			FROM_CS_BUF <= '1';
			XL16L784_CS_BUF <= '1';
			INT_READ_CS <= '1';
			WDI_CS <= '1';
			LED_CS <= '1';
			NVSRAM_CS_BUF <= '1';
			--DPRAM_CS_BUF <= '1';
			LONWK_CS <= '1';
			W5100_CS_BUF <= '1';
		end if;
	end process;
	
end Behavioral;
