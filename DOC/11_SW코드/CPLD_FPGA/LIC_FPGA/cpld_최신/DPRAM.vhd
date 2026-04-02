---------------------------------------------------------------------------------------------------------
-- DPRAMxA11(2048bit)xD(8Bit)
---------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DPRAMxA11xD8 is
    Port ( CLK : in  STD_LOGIC;
           SA : in  STD_LOGIC_VECTOR (10 downto 0);
           SD : in  STD_LOGIC_VECTOR(7 downto 0);
           DA : in  STD_LOGIC_VECTOR (10 downto 0);
           DD : out  STD_LOGIC_VECTOR(7 downto 0);
           DWE : in  STD_LOGIC);
end DPRAMxA11xD8;

architecture Behavioral of DPRAMxA11xD8 is

	constant ARRAY_CNT : integer := 128; -- 응답하는 어레이 갯수

	type ARRAYx8 is array (0 to ARRAY_CNT-1) of std_logic_vector(7 downto 0);

	signal SEL : std_logic_vector(0 to ARRAY_CNT-1);

	signal DOUT : ARRAYx8;
	
	-- RAM16X1D
	component RAM16X1D 
	   port (
			D   : in std_logic; 
			A0  : in std_logic; 
			A1  : in std_logic; 
			A2  : in std_logic; 
			A3  : in std_logic; 
			WE : in std_logic;
			WCLK : in std_logic;
			DPO  : out std_logic; 
			DPRA0 : in std_logic; 
			DPRA1 : in std_logic; 
			DPRA2 : in std_logic; 
			DPRA3 : in std_logic
			); 
	end component;
begin

	process(DA,DWE)
	begin
		if(DWE = '1') then
			SEL(conv_integer(DA(10 downto 4))) <= '1';
		else
			for i in 0 to ARRAY_CNT-1 loop SEL(i) <= '0'; end loop;
		end if;
	end process;
	
	DD <= DOUT(conv_integer(DA(10 downto 4)));

	DPRAM : for i in 0 to ARRAY_CNT-1 generate
	SRAM00X  : RAM16X1D port map (D => SD(0),A0 => SA(0),A1 => SA(1),A2 => SA(2),A3 => SA(3),WE => SEL(i),WCLK => CLK,DPO => DOUT(i)(0),DPRA0 => DA(0),DPRA1 => DA(1),DPRA2 => DA(2), DPRA3 => DA(3)); 
	SRAM01X  : RAM16X1D port map (D => SD(1),A0 => SA(0),A1 => SA(1),A2 => SA(2),A3 => SA(3),WE => SEL(i),WCLK => CLK,DPO => DOUT(i)(1),DPRA0 => DA(0),DPRA1 => DA(1),DPRA2 => DA(2), DPRA3 => DA(3)); 
	SRAM02X  : RAM16X1D port map (D => SD(2),A0 => SA(0),A1 => SA(1),A2 => SA(2),A3 => SA(3),WE => SEL(i),WCLK => CLK,DPO => DOUT(i)(2),DPRA0 => DA(0),DPRA1 => DA(1),DPRA2 => DA(2), DPRA3 => DA(3)); 
	SRAM03X  : RAM16X1D port map (D => SD(3),A0 => SA(0),A1 => SA(1),A2 => SA(2),A3 => SA(3),WE => SEL(i),WCLK => CLK,DPO => DOUT(i)(3),DPRA0 => DA(0),DPRA1 => DA(1),DPRA2 => DA(2), DPRA3 => DA(3)); 
	SRAM04X  : RAM16X1D port map (D => SD(4),A0 => SA(0),A1 => SA(1),A2 => SA(2),A3 => SA(3),WE => SEL(i),WCLK => CLK,DPO => DOUT(i)(4),DPRA0 => DA(0),DPRA1 => DA(1),DPRA2 => DA(2), DPRA3 => DA(3)); 
	SRAM05X  : RAM16X1D port map (D => SD(5),A0 => SA(0),A1 => SA(1),A2 => SA(2),A3 => SA(3),WE => SEL(i),WCLK => CLK,DPO => DOUT(i)(5),DPRA0 => DA(0),DPRA1 => DA(1),DPRA2 => DA(2), DPRA3 => DA(3)); 
	SRAM06X  : RAM16X1D port map (D => SD(6),A0 => SA(0),A1 => SA(1),A2 => SA(2),A3 => SA(3),WE => SEL(i),WCLK => CLK,DPO => DOUT(i)(6),DPRA0 => DA(0),DPRA1 => DA(1),DPRA2 => DA(2), DPRA3 => DA(3)); 
	SRAM07X  : RAM16X1D port map (D => SD(7),A0 => SA(0),A1 => SA(1),A2 => SA(2),A3 => SA(3),WE => SEL(i),WCLK => CLK,DPO => DOUT(i)(7),DPRA0 => DA(0),DPRA1 => DA(1),DPRA2 => DA(2), DPRA3 => DA(3)); 
	end generate DPRAM;
	
end Behavioral;
