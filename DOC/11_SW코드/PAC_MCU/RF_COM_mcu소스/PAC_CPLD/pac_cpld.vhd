
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pac_cpld is
    Port (
			clk : in STD_LOGIC;
			rst : in STD_LOGIC;
			CO : out  STD_LOGIC_VECTOR (7 downto 0);
			CI : in  STD_LOGIC_VECTOR (7 downto 0);
			CI_IO_SEL : in  STD_LOGIC_VECTOR (3 downto 0);
			CI0 : in  STD_LOGIC_VECTOR (7 downto 0);
			CI1 : in  STD_LOGIC_VECTOR (7 downto 0);
			CI2 : in  STD_LOGIC_VECTOR (7 downto 0);
			CI3 : in  STD_LOGIC_VECTOR (7 downto 0);
			CI4 : in  STD_LOGIC_VECTOR (7 downto 0);
			CO0 : out  STD_LOGIC_VECTOR (7 downto 0);
			CO1 : out  STD_LOGIC_VECTOR (7 downto 0);
			CO2 : out  STD_LOGIC_VECTOR (7 downto 0);
			CI_SCL : in  STD_LOGIC;
			CI_SCL_SEL : in  STD_LOGIC_VECTOR (3 downto 0);
			CO_SCL_ISP : out  STD_LOGIC;
			CO_SCL_ESPR : out  STD_LOGIC;
			CO_SCL_ESPL : out  STD_LOGIC;
			CO_SCL_CSP : out  STD_LOGIC;
			CO_SCL_TLOUT : out  STD_LOGIC;
			CO_SCL_TLIN : out  STD_LOGIC;
			CO_SCL_OCC : out  STD_LOGIC;
			CO_SCL_DPO : out  STD_LOGIC;
			CO_SCL_PEI : out  STD_LOGIC;
			ODOMETER : in  STD_LOGIC;
			CO_RB_LED : out  STD_LOGIC;				-- CI_PAC_AB
			CO_RA_LED : out  STD_LOGIC;				-- CI_PAC_AB
			CO_VOL_PA_AUDIO : out  STD_LOGIC;		-- CO_SEL_PA_TL_IN
			--CO_PEI_CALL : out  STD_LOGIC;
			CO_TEMP : out  STD_LOGIC;
			CO_11KHZ_LINE_CONT : out  STD_LOGIC
		);
end pac_cpld;

architecture Behavioral of pac_cpld is

	signal CI0_TEMP : STD_LOGIC_VECTOR(7 downto 0);

begin

process (rst) begin
	if rst = '0' then			-- reset
		CI0_TEMP <= CI0;
		CO <= CI0;
		CO0 <= "10001111";
		CO1 <= "11110000";
		CO2 <= "00000000";
		CO_SCL_ISP <= '1';
		CO_SCL_ESPR <= '1';
		CO_SCL_ESPL <= '1';
		CO_SCL_CSP <= '1';
		CO_SCL_TLOUT <= '1';
		CO_SCL_TLIN <= '1';
		CO_SCL_OCC <= '1';
		CO_SCL_DPO <= '1';
		CO_SCL_PEI <= '1';
		CO_RB_LED <= '1';
		CO_RA_LED <= '1';
		CO_VOL_PA_AUDIO <= '0';
		--CO_PEI_CALL <= '0';
		CO_TEMP <= '0';
		CO_11KHZ_LINE_CONT <= '0';
	else
		--if (CI4(0) = '1' or CI4(1) = '1' or CI4(2) = '1' or CI6(0) = '1' or CI6(1) = '1' or CI6(2) = '1') then
		--	CO_PEI_CALL <= '1';
		--else
		--	CO_PEI_CALL <= '0';
		--end if;

		if (CI0(6) = '0') then
			CO_RB_LED <= '0';
			CO_RA_LED <= '1';
		else
			CO_RB_LED <= '1';
			CO_RA_LED <= '0';
		end if;

		case CI_IO_SEL is
			when "0000" =>
				CO <= "00000000";
				CO_SCL_ISP <= '1';
				CO_SCL_ESPR <= '1';
				CO_SCL_ESPL <= '1';
				CO_SCL_CSP <= '1';
				CO_SCL_TLOUT <= '1';
				CO_SCL_TLIN <= '1';
				CO_SCL_OCC <= '1';
				CO_SCL_DPO <= '1';
				CO_SCL_PEI <= '1';
			when "0001" =>
				CI0_TEMP <= CI0;
				if (CI0(0) = '0' and CI0(1) = '0') or (CI0(0) = '1' and CI0(1) = '1') then
					CI0_TEMP(0) <= '0';
					CI0_TEMP(1) <= '0';
				end if;
				if CI0(2) = '0' and CI0(3) = '0' then
					CI0_TEMP(2) <= '0';
					CI0_TEMP(3) <= '0';
				end if;
				if CI0(2) = '1' and CI0(3) = '1' then
					CI0_TEMP(2) <= '1';
					CI0_TEMP(3) <= '1';
				end if;
				if CI0(6) = '0' then		-- CRA
					if CI0(0) = '0' and CI0(1) = '1' then		-- CAB
						CI0_TEMP(0) <= '1';
						CI0_TEMP(1) <= '0';
					end if;
					if CI0(0) = '1' and CI0(1) = '0' then		-- CAB
						CI0_TEMP(0) <= '0';
						CI0_TEMP(1) <= '1';
					end if;
					if CI0(2) = '0' and CI0(3) = '1' then		-- Couple
						CI0_TEMP(2) <= '0';
						CI0_TEMP(3) <= '1';
					end if;
					if CI0(2) = '1' and CI0(3) = '0' then		-- Couple
						CI0_TEMP(2) <= '1';
						CI0_TEMP(3) <= '0';
					end if;
				else						-- CRB
					if CI0(0) = '0' and CI0(1) = '1' then		-- CAB
						CI0_TEMP(0) <= '0';
						CI0_TEMP(1) <= '1';
					end if;
					if CI0(0) = '1' and CI0(1) = '0' then		-- CAB
						CI0_TEMP(0) <= '1';
						CI0_TEMP(1) <= '0';
					end if;
					if CI0(2) = '0' and CI0(3) = '1' then		-- Couple
						CI0_TEMP(2) <= '1';
						CI0_TEMP(3) <= '0';
					end if;
					if CI0(2) = '1' and CI0(3) = '0' then		-- Couple
						CI0_TEMP(2) <= '0';
						CI0_TEMP(3) <= '1';
					end if;
				end if;
				CO <= CI0_TEMP;
			when "0010" =>
				CO <= CI1;
			when "0011" =>
				CO <= CI2;
			when "0100" =>
				CO <= CI3;
			when "0101" =>
				CO <= CI4;

			when "1001" =>
				CO0 <= CI;
				if (CI(4) = '1') then
					CO_VOL_PA_AUDIO <= '1';
				else
					CO_VOL_PA_AUDIO <= '0';
				end if;
			when "1010" =>
				CO1 <= CI;
			when "1011" =>
				CO2 <= CI;

			when others =>
		end case;

		case CI_SCL_SEL is
			when "1010" =>
				CO_TEMP <= CI_SCL;
			when "0001" =>
				CO_SCL_ISP <= CI_SCL;
			when "0010" =>
				CO_SCL_ESPR <= CI_SCL;
			when "0011" =>
				CO_SCL_ESPL <= CI_SCL;
			when "0100" =>
				CO_SCL_CSP <= CI_SCL;
			when "0101" =>
				CO_SCL_TLOUT <= CI_SCL;
			when "0110" =>
				CO_SCL_TLIN <= CI_SCL;
			when "0111" =>
				CO_SCL_OCC <= CI_SCL;
			when "1000" =>
				CO_SCL_DPO <= CI_SCL;
			when "1001" =>
				CO_SCL_PEI <= CI_SCL;

			when others =>
		end case;
	end if;

end process;

end Behavioral;
