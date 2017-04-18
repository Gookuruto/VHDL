Library IEEE;
Use IEEE.Std_Logic_1164.all;
Use IEEE.Std_Logic_unsigned.all;
Use IEEE.numeric_std.all;
Use IEEE.std_logic_arith.all;

entity rotaryencoder is port
(
CLK : in std_logic;
B : in std_logic;
A : in std_logic;
valueout : out std_logic_vector(6 downto 0) --7 bit value out
);
end rotaryencoder;

architecture struct of rotaryencoder is

signal A_INT : std_logic := '0';
signal B_INT : std_logic := '0';
signal A_INT_P : std_logic := '0';
signal B_INT_P : std_logic := '0';
--signal count : std_logic_vector(6 downto 0):="0111111”;
signal count : integer range 0 to 2**7 := 1;

begin

main:process(CLK) is
begin
valueout <= conv_std_logic_vector(count,7);
if rising_edge(CLK) then
A_INT_p <= A_INT;
B_INT_p <= B_INT;
A_INT <= A;
B_INT <= B;

if (A_INT = '1' and A_INT_P = '0') then -- A rising
if (B='0' and count /= 127) then -- INC
count <= count + 1;
elsif (B='1' and count /= 0) then -- DEC
count <= count - 1;
end if;
elsif (B_INT = '1' and B_INT_P = '0') then -- B rising
if (A='1' and count /= 127) then -- INC
count <= count + 1;
elsif (A='0' and count /= 0) then -- DEC
count <= count - 1;
end if;
elsif (A_INT = '0' and A_INT_P = '1') then --A falling
if (B='1' and count /= 127) then -- INC
count <= count + 1;
elsif (B='0' and count /= 0) then -- DEC
count <= count - 1;
end if;
elsif (B_INT = '0' and B_INT_P = '1') then -- B falling
if (A='0' and count /= 127) then -- INC
count <= count + 1;
elsif (A='1' and count /= 0) then -- DEC
count <= count - 1;
end if;
else
count<= count;
end if;

end if;

end process;

end struct;