----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:25:34 05/08/2017 
-- Design Name: 
-- Module Name:    dig_clk - Behavioral 
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dig_clk is
    Port ( clk : in  STD_LOGIC;
           set : in  STD_LOGIC;
           hrs : out  STD_LOGIC_VECTOR (15 downto 0);
           min : out  STD_LOGIC_VECTOR (15 downto 0));
end dig_clk;

architecture Behavioral of dig_clk is
signal licz : std_logic_vector(25 downto 0):="0000000000000000000000000";
signal seconds : std_logic_vector(7 downto 0):="00000000";
signal minutes : std_logic_vector(7 downto 0):="00000000";
signal hours : std_logic_vector(7 downto 0):="00000000";
--licz<="0000000000000000000000000";
--seconds<="00000000";
begin
	sec:process(clk)
		begin
		if (rising_edge(clk)) then
			licz <= licz+"1";
		end if;
		if(falling_edge(licz(25))) then
			if(seconds(3 downto 0)="1001")then
				seconds(7 downto 4)<=seconds(7 downto 4)+1;
				seconds(3 downto 0) <= "0000";
			else
				seconds(3 downto 0) <= seconds(3 downto 0)+1;
			end if;
			if(seconds = "01100000" and rising_edge(clk)) then
				seconds <="00000000";
			end if;
			end if;
		end process;
		
		
		
	min:process(seconds)
		begin
			if(falling_edge(seconds(6))) then
				if(minutes(3 downto 0)="1001")then
				minutes(7 downto 4)<=minutes(7 downto 4)+1;
				minutes(3 downto 0) <= "0000";
			else
				minutes(3 downto 0) <= minutes(3 downto 0)+1;
			end if;
			if(minutes = "01010000" and falling_edge(seconds(6))) then
				minutes <="00000000";
			end if;
			end if;
		end process;
	
	
	hors:process(minutes)
		begin
			if(falling_edge(minutes(7))) then
				if(hours(3 downto 0)="1001")then
				hours(7 downto 4)<=hours(7 downto 4)+1;
				hours(3 downto 0) <= "0000";
			else
				hours(3 downto 0) <= hours(3 downto 0)+1;
			end if;
			if(hours = "00100011" and falling_edge(minutes(6))) then
				hours <="00000000";
			end if;
			end if;
		end process;
		 
		 
		dekoder:process(minutes,hours)
			begin
				if(minutes(7 downto 4)="0000")then
					min(15 downto 8)<="00110000";
				elsif(minutes(7 downto 4) ="0001")then
					min(15 downto 8)<="00110001";
				elsif(minutes(7 downto 4)="0010")then
					min(15 downto 8)<="00110010";
				elsif(minutes(7 downto 4)="0011")then
					min(15 downto 8)<="00110011";
				elsif(minutes(7 downto 4)="0100")then
					min(15 downto 8)<="00110100";
				elsif(minutes(7 downto 4)="0101")then
					min(15 downto 8)<="00110101";
				elsif(minutes(7 downto 4)="0110")then
					min(15 downto 8)<="00110110";
				end if;
				if(minutes(3 downto 0)="0000")then
					min(7 downto 0)<="00110000";
				elsif(minutes(3 downto 0) ="0001")then
					min(7 downto 0)<="00110001";
				elsif(minutes(3 downto 0)="0010")then
					min(7 downto 0)<="00110010";
				elsif(minutes(3 downto 0)="0011")then
					min(7 downto 0)<="00110011";
				elsif(minutes(3 downto 0)="0100")then
					min(7 downto 0)<="00110100";
				elsif(minutes(3 downto 0)="0101")then
					min(7 downto 0)<="00110101";
				elsif(minutes(3 downto 0)="0110")then
					min(7 downto 0)<="00110110";
				elsif(minutes(3 downto 0)="0111")then
					min(7 downto 0)<="00110111";
				elsif(minutes(3 downto 0)="1000")then
					min(7 downto 0)<="00111000";
				elsif(minutes(3 downto 0)="1001")then
					min(7 downto 0)<="00111001";
				end if;
				if(hours(7 downto 4)="0000")then
					hrs(15 downto 8)<="00110000";
				elsif(hours(7 downto 4) ="0001")then
					hrs(15 downto 8)<="00110001";
				elsif(hours(7 downto 4)="0010")then
					hrs(15 downto 8)<="00110010";
				end if;
				if(hours(3 downto 0)="0000")then
					hrs(7 downto 0)<="00110000";
				elsif(hours(3 downto 0) ="0001")then
					hrs(7 downto 0)<="00110001";
				elsif(hours(3 downto 0)="0010")then
					hrs(7 downto 0)<="00110010";
				elsif(hours(3 downto 0)="0011")then
					hrs(7 downto 0)<="00110011";
				elsif(hours(3 downto 0)="0100")then
					hrs(7 downto 0)<="00110100";
				elsif(hours(3 downto 0)="0101")then
					hrs(7 downto 0)<="00110101";
				elsif(hours(3 downto 0)="0110")then
					hrs(7 downto 0)<="00110110";
				elsif(hours(3 downto 0)="0111")then
					hrs(7 downto 0)<="00110111";
				elsif(hours(3 downto 0)="1000")then
					hrs(7 downto 0)<="00111000";
				elsif(hours(3 downto 0)="1001")then
					hrs(7 downto 0)<="00111001";
				end if;
			end process;
				
		 


end Behavioral;

