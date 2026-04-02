----------------------------------------------------------------------------------
-- Company: 우진산전
-- Engineer: 연준상
-- 
-- Ver1(2012.5.3) : 처음제작
--
--
--
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( 
			ROM_SERIAL_SW		: in std_logic;
			H3					: in  STD_LOGIC;
			WDI					: out std_logic;			
			AH					: in std_logic_vector(23 downto 20);
			AL					: in std_logic_vector(10 downto 0);
			D					: inout std_logic_vector(7 downto 0);
			STRB				: in  STD_LOGIC;
			RW					: in  STD_LOGIC;
			EDGE_MODE			: out std_logic;
			DSP_RST				: out std_logic;
			FPGA_RTS_INIT		: out std_logic;
				
			RD					: out STD_LOGIC;
			WR					: out std_logic;
			
			XL16L784_CS			: out std_logic;
			FROM_CS				: out std_logic;
			NVSRAM_CS			: out std_logic;
			W5100_CS			: out std_logic;			
			
			INT1				: buffer std_logic;
			INT2				: buffer std_logic;
			INT3				: buffer std_logic;

			XL16L784_INT		: in std_logic;
			W5100_INT			: in std_logic;

			RUN_LED				: out std_logic;
			ERR_LED				: out std_logic;

			DIMA				: in std_logic;
			DIMB				: in std_logic;
			
			N1SERVICE_IN		: IN std_logic;
			N1SERVICE_OUT		: out std_logic;
			LRST				: out std_logic;
			LON_INT				: out std_logic; -- CPU가 LON에 인터럽트 요청
			LON_IRQ				: in std_logic; -- LON이 CPU에 인터럽트 요청
			SPI_CLK				: in std_logic;
			SPI_SS				: in std_logic;
			SPI_DOUT			: out std_logic;
			SPI_DIN				: in std_logic;
			IO2					: out std_logic;
			IO3					: out std_logic;
			IO4					: out std_logic;
			IO5					: out std_logic;
			IO6					: out std_logic;
			IO11				: out std_logic;
			LON_CS0				: out std_logic;
			
			DEBUG_OUT			: out std_logic
			);
end main;

architecture Behavioral of main is
	constant VERSION : integer := 1;

	signal FROM_CS_BUF : std_logic;
	signal INT_READ_CS : std_logic;
	signal XL16L784_CS_BUF : std_logic;
	signal WDI_CS : std_logic;
	signal W5100_CS_BUF : std_logic;
	signal LONWK_INT_CS : std_logic;
	signal VERSION_CS : std_logic;
	signal DI_CS : std_logic;
	signal NVSRAM_CS_BUF : std_logic;

	signal WR_DLYBUF : std_logic;
	signal RD_DLYBUF : std_logic;

	signal LED_CS : std_logic;
	signal RUN_LED_BUF : std_logic;
	signal ERR_LED_BUF : std_logic;
	
	signal LON_INT_BUF : std_logic;

	signal BOOT_2_INT_SEL : std_logic;
	signal BOOT_2_INT_CS : std_logic;

	signal WDI_SEL_FLAG : std_logic;

	signal WR_BUF : std_logic;
	signal WR_DPRAM_BUF : std_logic_vector(0 downto 0);
	signal RD_BUF : std_logic;
	signal DPRAM_OUT_WR_MSK : std_logic;
	signal DPRAM_OUT_RD_MSK : std_logic;
	signal DPRAM_OUT_RDWR_MSK : std_logic;
	signal DPRAM_OUT_CS : std_logic;
	signal DPRAM_OUT_DATA : std_logic_vector(7 downto 0);
	
	signal SPI_RDWR_FLAG : std_logic; -- RD(1),WR(0) 신호
	signal SPI_ADDR : std_logic_vector(15 downto 0); -- SPI 어드레스
	signal SPI_ADDR_BUF : std_logic_vector(15 downto 0); -- SPI 어드레스
	signal SPI_WRDATA : std_logic_vector(7 downto 0); -- SPI 쓰기 DATA
	signal SPI_RDDATA : std_logic_vector(7 downto 0); -- SPI 읽기 DATA
	signal SPI_WR : std_logic; -- SPI WRITE 시그널
	signal SPI_DPRAM_WR : std_logic_vector(0 downto 0); -- SPI WRITE 시그널
	signal SPI_RD : std_logic; -- SPI READ 시그널
	signal SPI_RDWR : std_logic;
	signal LON_IO_ENABLE : std_logic;
	
	signal RST : std_logic;
	signal RST_DLYCNT : integer range 0 to 5000000;

	-- DPRAMxA11xD8
	component blk_mem_gen_v6_1
		PORT	(
				clka : IN STD_LOGIC;
				wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
				addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
				dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
				
				clkb : IN STD_LOGIC;
				web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
				addrb : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
				dinb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);	
	END component;	
begin

	DSP_RST <= RST;
	FPGA_RTS_INIT <= '0';
	
	EDGE_MODE <= '1'; -- 0:Level tigger, 1:Edge tigger
	

	XL16L784_CS <= XL16L784_CS_BUF;
	FROM_CS <= FROM_CS_BUF;
	W5100_CS <= W5100_CS_BUF;
	NVSRAM_CS <= NVSRAM_CS_BUF;
	
	RD_BUF <= STRB or not RW;
	WR_BUF <= STRB or RW;
	
	RD <= RD_BUF;
	WR <= WR_BUF;

	---------------------------------------------------------------------------------------------
	-- FT-5000의 I/O핀 설정
	---------------------------------------------------------------------------------------------
	process(N1SERVICE_IN)
	begin
		if(N1SERVICE_IN = '1') then
			N1SERVICE_OUT <= 'Z';
		else
			N1SERVICE_OUT <= '0';		
		end if;
	end process;
	
	process(RST)
	begin
		if(RST = '1') then
			LRST <= 'Z';
		else
			LRST <= '0';		
		end if;
	end process;

	LON_CS0 <= 'Z';
	IO2 <= 'Z';
	IO3 <= 'Z';
	IO4 <= 'Z';
	IO5 <= 'Z';
	IO6 <= 'Z';
	IO11 <= 'Z';
	LON_INT <= LON_INT_BUF;

	---------------------------------------------------------------------------------------------
	-- DPRAM 설정
	---------------------------------------------------------------------------------------------
	DPRAM_OUT_WR_MSK <= WR_BUF or DPRAM_OUT_CS or not WR_DLYBUF;
	DPRAM_OUT_RD_MSK <= RD_BUF or DPRAM_OUT_CS or not RD_DLYBUF;
	DPRAM_OUT_RDWR_MSK <= DPRAM_OUT_WR_MSK and DPRAM_OUT_RD_MSK;
	WR_DPRAM_BUF(0) <= WR_BUF;
	SPI_RDWR <= SPI_RD and SPI_WR;
	SPI_DPRAM_WR(0) <= SPI_RDWR_FLAG;
	-- DSP에서 LON SPI로 전달하기
	DPRAM_DSP_2_LON : blk_mem_gen_v6_1 port map 
	(
		CLKA => DPRAM_OUT_RDWR_MSK, 
		WEA => not WR_DPRAM_BUF, 
		ADDRA => AL,
		DOUTA => DPRAM_OUT_DATA,
		DINA => D,

		CLKB => SPI_RDWR,
		WEB => not SPI_DPRAM_WR,
		ADDRB => SPI_ADDR(10 downto 0),
		DINB => SPI_WRDATA,
		DOUTB => SPI_RDDATA
	);
	
	---------------------------------------------------------------------------------------------
	-- RESET 만들기
	---------------------------------------------------------------------------------------------
	process(H3)
	begin
		if(rising_edge(H3)) then
			if(RST_DLYCNT < 500000) then
				RST <= '0';
				RST_DLYCNT <= RST_DLYCNT + 1;
			else
				RST <= '1';
			end if;
		end if;
	end process;

	---------------------------------------------------------------------------------------------
	-- LON과 SPI인터페이스 프로그램
	---------------------------------------------------------------------------------------------
	process(SPI_SS,SPI_CLK,SPI_DIN)
		variable SPI_OFFCNT : integer range 0 to 7;
		variable SPI_CNT : integer range 0 to 65535;
	begin
		if(SPI_SS = '0') then
			SPI_ADDR_BUF <= "0000000000000000";
			SPI_WRDATA <= "00000000";
			SPI_RDWR_FLAG <= '1';
			
			SPI_OFFCNT := 0;
			SPI_CNT := 0;
		elsif(falling_edge(SPI_CLK)) then
			case SPI_CNT is
			
			-- Header section
			when  0 => SPI_RDWR_FLAG <= SPI_DIN;
			when  1 => null;
			when  2 => null;
			when  3 => null;
			when  4 => null;
			when  5 => null;
			when  6 => null;
			when  7 => null;
			
			-- Address section
			when  8 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when  9 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 10 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 11 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 12 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 13 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 14 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 15 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 16 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 17 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 18 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 19 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 20 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 21 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 22 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 23 => SPI_ADDR_BUF <= SPI_ADDR_BUF(14 downto 0) & SPI_DIN;
			when 24 => null;
			when 25 => null;
			when 26 => null;
			when 27 => null;
			when 28 => null;
			when 29 => null;
			when 30 => null;
			when 31 => null;
			-- Data section
			when others =>
				SPI_WRDATA <= SPI_WRDATA(6 downto 0) & SPI_DIN;
				SPI_OFFCNT := SPI_OFFCNT + 1;
			end case;
			
			if(SPI_CNT < 65535) then SPI_CNT := SPI_CNT + 1; end if;
		end if;
	end process;
	
	-- ADDRESS/WR/RD 만들기
	process(SPI_SS,SPI_CLK,SPI_DIN,SPI_RDWR_FLAG,SPI_ADDR_BUF)
		variable SPI_OFFCNT : integer range 0 to 7;
		variable SPI_CNT : integer range 0 to 65535;
		variable SPI_WR_BUF : std_logic;
		variable SPI_RD_BUF : std_logic;
		variable SPI_ADDRESS_START_FLAG : std_logic;
		variable SPI_RDDATA_BUF : std_logic_vector(7 downto 0);
	begin
		if(SPI_SS = '0') then
			SPI_ADDR <= "0000000000000000";
			SPI_RD <= '1';
			SPI_WR <= '1';
			SPI_RD_BUF := '1';
			SPI_WR_BUF := '1';
			SPI_DOUT <= '0';
			
			SPI_ADDRESS_START_FLAG := '0';
			
			SPI_OFFCNT := 0;
			SPI_CNT := 0;
			
		elsif(rising_edge(SPI_CLK)) then
			case SPI_CNT is
			
			-- Header section
			when  0 => null;
			when  1 => null;
			when  2 => null;
			when  3 => null;
			when  4 => null;
			when  5 => null;
			when  6 => null;
			when  7 => null;
			
			-- Address section
			when  8 => null;
			when  9 => null;
			when 10 => null;
			when 11 => null;
			when 12 => null;
			when 13 => null;
			when 14 => null;
			when 15 => null;
			when 16 => null;
			when 17 => null;
			when 18 => null;
			when 19 => null;
			when 20 => null;
			when 21 => null;
			when 22 => null;
			when 23 => null;

			when 24 => SPI_RD_BUF := '0';
			when 25 => SPI_ADDR <= SPI_ADDR_BUF; 
			when 26 => SPI_RD_BUF := '1';
			when 27 =>  
						SPI_RDDATA_BUF := SPI_RDDATA;
						SPI_DOUT <= SPI_RDDATA_BUF(7);
						SPI_RDDATA_BUF := SPI_RDDATA_BUF(6 downto 0) & '0';
			when 28 => null; 
			when 29 => null; 
			when 30 => null; 
			when 31 => null;
			
			-- Data section
			when others =>
				if(SPI_OFFCNT = 0) then 
					SPI_RD_BUF := '0'; SPI_WR_BUF := '0'; 

					if(SPI_ADDRESS_START_FLAG = '1' or SPI_RDWR_FLAG = '1') then
						SPI_ADDR <= SPI_ADDR + '1';
					end if;
					
					SPI_ADDRESS_START_FLAG := '1';
				elsif(SPI_OFFCNT = 5) then 
					SPI_RD_BUF := '1'; 
				elsif(SPI_OFFCNT = 7) then 
					SPI_RDDATA_BUF := SPI_RDDATA;
					SPI_WR_BUF := '1';
				end if;
								
				SPI_OFFCNT := SPI_OFFCNT + 1;

				SPI_DOUT <= SPI_RDDATA_BUF(7);
				SPI_RDDATA_BUF := SPI_RDDATA_BUF(6 downto 0) & '0';
				
			end case;
			
			if(SPI_CNT < 65535) then SPI_CNT := SPI_CNT + 1; end if;
		end if;

		SPI_WR <= SPI_WR_BUF or SPI_RDWR_FLAG;
		SPI_RD <= SPI_RD_BUF or not SPI_RDWR_FLAG;
	end process;

	DEBUG_OUT <= SPI_RD;

	---------------------------------------------------------------------------------------------
	-- Delay Write
	---------------------------------------------------------------------------------------------
	process(RST,H3,WR_BUF)
		variable WR_BUFS : std_logic_vector(1 downto 0);
	begin
		if(RST = '0') then
			WR_BUFS := "11";
		elsif(rising_edge(H3)) then
			WR_BUFS := WR_BUFS(0) & WR_BUF;
		end if;
		
		WR_DLYBUF <= WR_BUFS(1);
	end process;

	process(RST,H3,RD_BUF)
		variable RD_BUFS : std_logic_vector(1 downto 0);
	begin
		if(RST = '0') then
			RD_BUFS := "11";
		elsif(rising_edge(H3)) then
			RD_BUFS := RD_BUFS(0) & RD_BUF;
		end if;
		
		RD_DLYBUF <= RD_BUFS(1);
	end process;

	-------------------------------------------------------------------------------------
	-- Interrupt
	-------------------------------------------------------------------------------------
	process(BOOT_2_INT_SEL,XL16L784_INT,W5100_INT,LON_IRQ)
	begin
		if(BOOT_2_INT_SEL = '0') then
			INT1 <= not ROM_SERIAL_SW;
			INT2 <= '1';
			INT3 <= ROM_SERIAL_SW;
		else
			INT1 <= XL16L784_INT;
			INT2 <= LON_IRQ;
			INT3 <= W5100_INT;
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
	
	---------------------------------------------------------------------------------------------
	-- LED
	---------------------------------------------------------------------------------------------
	RUN_LED <= RUN_LED_BUF;
	ERR_LED <= ERR_LED_BUF;

	-------------------------------------------------------------------------------------
	-- CPU에서 Write하여 버퍼하기
	-------------------------------------------------------------------------------------
	process(RST,LED_CS,D,WR_DLYBUF,LONWK_INT_CS)
	begin
		if(RST = '0') then
			RUN_LED_BUF <= '0';
			ERR_LED_BUF <= '0';
			LON_INT_BUF <= '1';
		elsif(falling_edge(WR_DLYBUF)) then
			if(LED_CS = '0') then
				RUN_LED_BUF <= D(0);
				ERR_LED_BUF <= D(1);
			elsif(LONWK_INT_CS <= '0') then
				LON_INT_BUF <= D(0);
			end if;
		end if;
	end process;

	-------------------------------------------------------------------------------------------
	-- CPU가 READ하여 가져가기
	-------------------------------------------------------------------------------------------
	process(RD_BUF,DPRAM_OUT_CS,INT_READ_CS,INT1,INT2,INT3,LED_CS,RUN_LED_BUF,ERR_LED_BUF,LONWK_INT_CS,VERSION_CS,DI_CS,DIMA,DIMB)
	begin
		if(RD_BUF = '0') then
			if(DPRAM_OUT_CS = '0') then
				D <= DPRAM_OUT_DATA;
			elsif(INT_READ_CS = '0') then
				D <= "00000"&INT1&INT2&INT3;
			elsif(LED_CS = '0') then
				D <= "000000"&ERR_LED_BUF&RUN_LED_BUF;
			elsif(LONWK_INT_CS = '0') then
				D <= "0000000"&LON_INT_BUF;
			elsif(VERSION_CS = '0') then
				D <= conv_std_logic_vector(VERSION,8);
			elsif(DI_CS = '0') then
				D <= "000000"&DIMA&DIMB;
			else
				D <= "ZZZZZZZZ";
			end if;
		else
			D <= "ZZZZZZZZ";
		end if;
	end process;

	-------------------------------------------------------------------------------------------
	-- DECODER
	-------------------------------------------------------------------------------------------
	process(RST,AH,AL,STRB)
	begin
		if(RST = '0') then
			VERSION_CS <= '1';
			BOOT_2_INT_CS <= '1';
			DPRAM_OUT_CS <= '1';
			FROM_CS_BUF <= '1';
			INT_READ_CS <= '1';
			XL16L784_CS_BUF <= '1';
			WDI_CS <= '1';
			W5100_CS_BUF <= '1';
			LED_CS <= '1';
			LONWK_INT_CS <= '1';	
			DI_CS <= '1';
			NVSRAM_CS_BUF <= '1';
		-- WDI_CS			(0x002xxx)
		elsif(AH = "0000" and STRB = '0') then WDI_CS <= '0';					
		-- BOOT_2_INT		(0x1xxxxx)
		elsif(AH = "0001" and STRB = '0') then BOOT_2_INT_CS <= '0';					
		-- INT_READ_CS		(0x80Bxxx)
		elsif(AH = "1000" and STRB = '0') then INT_READ_CS <= '0';
		-- LED_CS			(0x2xxxx0)
		elsif(AH = "0010" and AL(7 downto 0) = "00000000" and STRB = '0') then LED_CS <= '0';
		-- DI_CS			(0x2XXXX1)
		elsif(AH = "0010" and AL(7 downto 0) = "00000001" and STRB = '0') then DI_CS <= '0';
		-- VERSION_CS		(0x2xxxx2)
		elsif(AH = "0010" and AL(7 downto 0) = "00000010" and STRB = '0') then VERSION_CS <= '0';
		-- W5100_CS			(0x3xxxxx)
		elsif(AH = "0011" and STRB = '0') then W5100_CS_BUF <= '0';
		-- FROM_CS_BUF		(0x4xxxxx)
		elsif(AH = "0100" and STRB = '0') then FROM_CS_BUF <= '0';
		-- XL16L784_CS_BUF	(0x9xxxxx)
		elsif(AH = "1001" and STRB = '0') then XL16L784_CS_BUF <= '0';
		-- LONWK_INT_CS		(0xAxxxxx)
		elsif(AH = "1010" and STRB = '0') then LONWK_INT_CS <= '0';
		-- DPRAM_CS			(0xBXXXXX)
		elsif(AH = "1011" and STRB = '0') then DPRAM_OUT_CS <= '0';
		-- NVSRAM_CS_BUF	(0xCxxxxx ~ 0xFxxxxx)
		elsif((AH = "1100" or AH = "1101" or AH = "1110" or AH = "1111") and STRB = '0') then NVSRAM_CS_BUF <= '0';
		else
			VERSION_CS <= '1';
			BOOT_2_INT_CS <= '1';
			WDI_CS <= '1';
			XL16L784_CS_BUF <= '1';
			FROM_CS_BUF <= '1';
			DPRAM_OUT_CS <= '1';
			INT_READ_CS <= '1';
			W5100_CS_BUF <= '1';
			LED_CS <= '1';
			LONWK_INT_CS <= '1';
			DI_CS <= '1';
			NVSRAM_CS_BUF <= '1';
		end if;
	end process;
	

end Behavioral;

