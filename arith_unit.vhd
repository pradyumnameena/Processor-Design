----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2018 14:46:36
-- Design Name: 
-- Module Name: arith_unit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
Port (
        in1,in2:in std_logic_vector(31 downto 0);
         opcode:in std_logic_vector(3 downto 0);
         carry: in std_logic;
         out1:out std_logic_vector(31 downto 0);
		 z,n,v,c : out std_logic);
end ALU;

architecture Behavioral of ALU is
signal temp:std_logic_vector(32 downto 0);
signal carry_load:std_logic_vector(31 downto 0);

begin
-- In order to add the carry at last of the 
carry_load <=(0=> carry,
				others=>'0');
process(opcode,in1,in2,carry_load)
begin
case opcode is
when "0000" => temp <= in1 + in2; -- add
when "0001" => temp <= in1 + in2 + carry_load; -- adc
when "0010" => temp <= in1 - in2; -- sub
when "0011" => temp <= in1 - in2 + carry_load; -- sbc
when "0101" => temp <= in2 - in1 + carry_load;--rsc
when "0100" => temp <= in2 - in1;--rsb
when "1000" => temp <= in1 and in2;--and
when "1001" => temp <= in1 or in2;--orr
when "1010" => temp <= in1 xor in2;--eor
when "1011" => temp <= in1 and (not in2);-- bic
when others => null;
end case;
end process;

process(temp)
begin
z <= not( temp(31) or temp(30) or temp(29) or temp(28) or temp(27) or temp(26) or temp(25) or temp(24) or temp(23) or temp(22) or temp(21) or temp(20) or temp(19) or temp(18) or temp(17) or temp(16) or temp(15) or temp(14) or temp(13) or temp(12) or temp(11) or temp(10) or temp(9) or temp(8) or temp(7) or temp(6) or temp(5) or temp(4) or temp(3) or temp(2) or temp(1) or temp(0) ); 
n <= temp(31);
v <= temp(32) xor ( in1(31) xor in2(31) xor temp(31) );
c <= temp(32);
end process;


out1<=temp;

end Behavioral;
