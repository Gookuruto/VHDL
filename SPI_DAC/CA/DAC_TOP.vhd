-----------------------------------------------------------------------------------------
-- Plik g³ówny projektu DAC_TOP.vhd
-- Materia³y pomocnicze: Programowanie Uk³adów Logicznych 
-- Obs³uga przetwornika DAC LTC2624 (Quad 12 bit DAC) Spartan-3E Starter Kit 
-- tryb obs³ugi 32 bitowa ramka danych 
-- zmina wartoœci s³owa sygna³u "pattern" umozliwia zmianê napiêcia wyjœciowego przetwornika DAC
-----------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity DAC_TOP is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           DAC_MOSI : out  STD_LOGIC;
           DAC_CLR : out  STD_LOGIC;
           DAC_SCK : out  STD_LOGIC;
           DAC_CS : out  STD_LOGIC
		   );
end DAC_TOP;

architecture DAC of DAC_TOP is
signal rdy,daccs,dacsck,dacmosi : std_logic;
signal command : std_logic_vector(3 downto 0);
signal address : std_logic_vector(3 downto 0);
signal dacdata : std_logic_vector(31 downto 0);
signal pattern : std_logic_vector(11 downto 0);
type memory_type is array (0 to 10) of std_logic_vector(11 downto 0);
signal sin : memory_type;

component DAC_Control
	 Port (	CLK 			: in  STD_LOGIC;
				RST 			: in  STD_LOGIC;
				DAC_DATA 	: in STD_LOGIC_VECTOR(31 downto 0);
				DAC_MOSI 	: out  STD_LOGIC;
				DAC_SCK 		: out  STD_LOGIC;
				DAC_CS 		: out  STD_LOGIC;
				RDY 			: out  STD_LOGIC);
end component;

begin
	U1 : DAC_Control
	Port map ( CLK => CLK,
				  RST => RST,
				  DAC_MOSI => dacmosi,
				  DAC_SCK => dacsck,
				  DAC_CS => daccs,
				  RDY => RDY,
				  DAC_DATA => dacdata);

process(RST,CLK,daccs,dacsck,dacmosi)
	begin
		if (RST='1') then
			DAC_MOSI <= '0';
			DAC_CLR <= '0';
			DAC_SCK <= '0';
			DAC_CS <= '1';
		elsif rising_edge(CLK) then
			if rdy = '1' then 										-- flaga informuj¹ca o gotowoœci uk³adu
				command <= "0011";									-- polecenie 4-bity
				address <= "1111";									-- adres przetwornika 4-bity
				pattern <= "010000000000";							-- 12-bitowa wartoœæ napiêcia wyjœciowego, s³owo cyfrowe k (nota katalogowa lub wyk³ad)
				dacdata(31 downto 24) <= (others => '0');		-- bity nieznacz¹ce (nota katalogowa lub wyk³ad)
				dacdata(23 downto 20) <= command;
				dacdata(19 downto 16) <= address;
				dacdata(15 downto 4) <= pattern;
				dacdata(3 downto 0) <= (others => '0');		-- bity nieznacz¹ce (nota katalogowa lub wyk³ad)
			end if;
			DAC_CLR <= '1';
		end if;
		DAC_CS <= daccs;
		DAC_SCK <= dacsck;
		DAC_MOSI <= dacmosi;
end process;
end DAC;

