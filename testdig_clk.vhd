--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:07:56 05/08/2017
-- Design Name:   
-- Module Name:   C:/Users/Student/Documents/221117/projekt_clock/testdig_clk.vhd
-- Project Name:  projekt_clock
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dig_clk
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testdig_clk IS
END testdig_clk;
 
ARCHITECTURE behavior OF testdig_clk IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dig_clk
    PORT(
         clk : IN  std_logic;
         set : IN  std_logic;
         hrs : OUT  std_logic_vector(7 downto 0);
         min : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal set : std_logic := '0';

 	--Outputs
   signal hrs : std_logic_vector(7 downto 0);
   signal min : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dig_clk PORT MAP (
          clk => clk,
          set => set,
          hrs => hrs,
          min => min
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
			-- insert stimulus here 
		wait for 10000000*clk_period;
      assert false severity failure;
   end process;

END;
