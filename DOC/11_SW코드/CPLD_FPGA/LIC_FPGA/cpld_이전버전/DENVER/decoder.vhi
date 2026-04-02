
-- VHDL Instantiation Created from source file decoder.vhd -- 18:23:03 02/11/2012
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT decoder
	PORT(
		RST : IN std_logic;
		ROM_SERIAL_SW : IN std_logic;
		H3 : IN std_logic;
		STRB : IN std_logic;
		RWB : IN std_logic;
		A : IN std_logic_vector(23 downto 18);
		SERVICE_SWITCH : IN std_logic;
		XL16L784_INT : IN std_logic;
		W5100_INT : IN std_logic;    
		D : INOUT std_logic_vector(7 downto 0);
		IO : INOUT std_logic_vector(11 downto 0);      
		RDY : OUT std_logic;
		WDI : OUT std_logic;
		EDGE_MODE : OUT std_logic;
		LRST : OUT std_logic;
		XL16L784_CS : OUT std_logic;
		FROM_CS : OUT std_logic;
		NVSRAM_CS : OUT std_logic;
		W5100_CS : OUT std_logic;
		WR : OUT std_logic;
		RD : OUT std_logic;
		SERVICE_LON : OUT std_logic;
		CSO_LON : OUT std_logic;
		INT0 : OUT std_logic;
		INT1 : OUT std_logic;
		INT2 : OUT std_logic;
		INT3 : OUT std_logic;
		RUN_LED : OUT std_logic;
		ERR_LED : OUT std_logic
		);
	END COMPONENT;

	Inst_decoder: decoder PORT MAP(
		RST => ,
		RDY => ,
		ROM_SERIAL_SW => ,
		H3 => ,
		WDI => ,
		STRB => ,
		RWB => ,
		EDGE_MODE => ,
		LRST => ,
		A => ,
		D => ,
		IO => ,
		XL16L784_CS => ,
		FROM_CS => ,
		NVSRAM_CS => ,
		W5100_CS => ,
		WR => ,
		RD => ,
		SERVICE_LON => ,
		SERVICE_SWITCH => ,
		CSO_LON => ,
		XL16L784_INT => ,
		W5100_INT => ,
		INT0 => ,
		INT1 => ,
		INT2 => ,
		INT3 => ,
		RUN_LED => ,
		ERR_LED => 
	);


